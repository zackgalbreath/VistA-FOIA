NURSDFFS ;HIRMFO/RM-FILE FIELD STRUCTURES FOR NURSING FILES ;AUGUST 1986
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),"^",1)=1
 D DT^DICRW S NURQUEUE=0
 W ! S ZTRTN="EN1^NURSDFFS" D EN7^NURSUT0 G:POP!($D(ZTSK)) QUIT
EN1 ; ENTRY TO BEGIN PRINTING
 S IOP=ION D ^%ZIS K IOP U IO
 F NURSFILE=209.99999:0 S NURSFILE=$O(^DIC(NURSFILE)) Q:NURSFILE'<220!(NURSFILE="")  S STACK=1,NURSPACE="",NURSPAGE=1,NURSLINE=0 D PRNTFLDS
QUIT D CLOSE^NURSUT1,^NURSKILL
 Q
PRNTFLDS ; PRINTS LINES FOR FIELDS
 D:(STACK=1)!(NURSLINE>55) HEADER
 F NURSFLD=0:0 S NURSFLD=$O(^DD(NURSFILE,NURSFLD)) Q:NURSFLD'>0  D PRINTLN,POPSTACK,CKSUB
 Q
CKSUB ; CHECKS FOR THE EXISTENCE OF SUB-FIELDS AND PRINTS THEM OUT (RECURSIVE)
 S STACK=STACK+1,NURSPACE="       "_NURSPACE
 F NURSFILE=NURSFILE:0 S NURSFILE=$O(^DD(NURSFILE(STACK-1),"SB",NURSFILE)) Q:NURSFILE'>0  S NURSFLD=$O(^DD(NURSFILE(STACK-1),"SB",NURSFILE,"")) I NURSFLD=NURSFLD(STACK-1) D PRNTFLDS
 S STACK=STACK-1,NURSFLD=NURSFLD(STACK),NURSFILE=NURSFILE(STACK),NURSPACE=$E(NURSPACE,8,$L(NURSPACE))
 K NURSFLD(STACK),NURSFILE(STACK)
 Q
PRINTLN ; PRINT A LINE
 D FIELD^DID(NURSFILE,NURSFLD,"","LABEL","NURSFLNM","") S NURSLINE=NURSLINE+1
 W !,NURSPACE_NURSFLD_$E("       ",1,7-$L(NURSFLD))_NURSFLNM("LABEL")
 Q
POPSTACK ; ADD ONE MORE ITEM TO STACK
 S NURSFLD(STACK)=NURSFLD,NURSFILE(STACK)=NURSFILE
 Q
HEADER ; PRINT HEADING FOR EACH FILE
 I '$D(NURSFILE(1)) S NURSFIL1=NURSFILE
 E  S NURSFIL1=NURSFILE(1)
 W @IOF
 W !!,$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?22,"FILE FIELD STRUCTURE FOR FILE #"_NURSFIL1,?70,"PAGE: ",NURSPAGE,!,$$REPEAT^XLFSTR("-",80),!
 S NURSLINE=0,NURSPAGE=NURSPAGE+1
 Q
