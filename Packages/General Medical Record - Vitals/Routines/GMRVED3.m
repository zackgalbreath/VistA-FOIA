GMRVED3 ;HIRMFO/YH,FT-VITAL SIGNS EDIT SHORT FORM (cont.) ;6/28/01  14:42
 ;;4.0;Vitals/Measurements;**1,5,6,7,11,13**;Apr 25, 1997
EN2 ;VITAL ENTRY FOR A PATIENT
 D EN2^GMRVED1 G:GMROUT NEXT D EN4^GMRVED2 S GMROK=0
NEXT I '(GMRENTY=5!(GMRENTY=6)!(GMRENTY=9))!GMROUT S GMRVIDT=GMRDT0 Q
 I $G(GMROUT(1))=1 S GMROUT(1)=0 S GMRVIDT=GMRDT0 Q
 I GMRSTR'["BP" S GMRVIDT=GMRDT0 Q
 S:'$D(GPRMT)&($D(GMRPRMT)) GPRMT="("_$P(GMRPRMT,":")_" continued )" S GPRMT(1)=GMRSTR
 I '$D(^GMR(120.5,"AA",DFN,1,9999999-GMRVIDT)) S:GMRENTY=5 GMRSTR="T;P;R;BP;" S:GMRENTY=6 GMRSTR="BP;P;" S:GMRENTY=10 GMRSTR="T;P;R;BP;HT;WT;" S GMRVIDT=GMRDT0 S:GMRENTY=9 GMRSTR=GPRMT(1) K GPRMT,GBP Q
ASK I '$D(GMRSITE("BP"))&'$D(GMRINF("BP")) S:GMRENTY=9 GMRSTR=GPRMT(1) K GPRMT Q
  W !,"Enter another B/P? NO// " R GMRX:DTIME S:'$T GMRTO=1 I '$T!(GMRX="^") S GMROUT=1,GMRVIDT=GMRDT0 S:GMRENTY=9 GMRSTR=GPRMT(1) K GBP,GPRMT Q
 I GMRX=""!("Nn"[GMRX) S GMRVIDT=GDT S:GMRENTY=5 GMRSTR="T;P;R;BP;" S:GMRENTY=10 GMRSTR="T;P;R;BP;HT;WT;" S GMRVIDT=GMRDT0 S:GMRENTY=9 GMRSTR=GPRMT(1) K GPRMT Q
 I GMRX["Y"!(GMRX["y") S GMRSTR=$S(GMRENTY=5!(GMRENTY=6):"BP;P;",1:"BP;"),GMRVIDT=GMRDT0 W @IOF,GPRMT D DSPOV^GMRVED4 D SETBP S GLAST=GLAST+.00000001,GMRVIDT=GLAST G EN2
 W !,"ANSWER YES OR NO, maximum 6 B/Ps ",*7 G ASK
SETBP ;
 N I S I=0 F  S I=$O(GMROV("BP",I)) Q:I'>0  I $P(GMROV("BP",I),"^",2)'="" S GBP($P(GMROV("BP",I),"^",2))=""
 Q
CHKDAT ;CHECK V/M ENTRY DATA
 S GMRVITY=$P(GMRSTR(0),";",GMRX),GMRVIT=+$O(^GMRD(120.51,"C",GMRVITY,"")),GMRVIT(1)=$S($D(^GMRD(120.51,GMRVIT,0)):$P(^(0),"^"),1:""),GMRO2(GMRVITY)=""
 F GMRY=0:0 S GMRY=$O(^GMR(120.5,"AA",DFN,GMRVIT,9999999-GMRVIDT,GMRY)) Q:GMRY'>0  I $S('$D(^GMR(120.5,GMRY,2)):1,$P(^(2),"^"):0,1:1) D
 . I GMRENTY=21,"Nn"'[GMRDAT D WDUP S GMRDAT="" Q
 . D:"Nn"'[$P(GMRDAT,"-",GMRX-1) WDUP S $P(GMRDAT,"-",GMRX-1)="" Q
 S GMRINPTR=$S($D(^GMRD(120.51,GMRVIT,1)):^(1),1:"K:X'?.NP X")
INPTR ;
 Q:GMROUT  S X=$S(GMRENTY=21:GMRDAT,1:$P(GMRDAT,"-",GMRX-1))
 I X="n"!(X="N")!(X="") S (GMRDAT(GMRVITY),GMRSITE(GMRVITY),GMRINF(GMRVITY))="" Q
 I "UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR(X) S GMRSITE(GMRVITY)="",GMRINF(GMRVITY)="",GMRDAT(GMRVITY)=X Q
INPTR1 ;
 I GMRVITY="PO2" G:$L(X)>10 A G:+X>100 A D O2^GMRVUT3
 I GMRVITY="HT" G:'$$HTCHK(X) A S X=$$UP^XLFSTR(X),GMRSITE=$P(X,",",2),X=$P(X,",") D
 .I GMRSITE="" S:X["E" GMRSITE=$E(X,$F(X,"E")-1),X=$P(X,"E") S:X["A" GMRSITE=$E(X,$F(X,"A")-1),X=$P(X,"A")
 .S:GMRSITE="" GMRSITE="A"
 .D TPSITE^GMRVUT1
 .Q
 I GMRVITY="PN" S GMRDAT("PN")=+X,GMRSITE("PN")=""
 I GMRVITY="WT" G:$L(X)>10 A G:+X>1500 A S GMRSITE=$P(X,+X,2) G:GMRSITE=""!("LlKk"'[$E(GMRSITE)) A K GMRSITE(GMRVITY),GMRINF(GMRVITY) D WTYPE^GMRVUT1
 I GMRVITY="CG" K GMRSITE(GMRVITY),GMRINF(GMRVITY) S GLVL=8 D LISTQ^GMRVQUAL,OTHERQ^GMRVQUAL,CLEAR^GMRVQUAL
 I GMRVITY="BP",GMRENTY<5,$L(X,"/")=1 G A
 I GMRVITY="BP" N GMRDP D
 .S X=$$UP^XLFSTR(X)
 .Q:X'["/"
 .S:$P(X,"/",2)="" GMRSITE="PA",GMRDP=1
 .S:$P(X,"/",2)="D" GMRSITE="D",X=$P(X,"/")_"/",GMRDP=1
 .S:$P(X,"/",2)="P" GMRSITE="PA",X=$P(X,"/")_"/",GMRDP=1
 .D:$D(GMRDP)&(GMRENTY<5) TPSITE^GMRVUT1
 .Q
 I GMRVITY="T"!(GMRVITY="P")!(GMRVITY="BP"&(GMRENTY>4))!(GMRVITY="R")!(GMRVITY="PO2") D SITE I '$D(X) G A
 X GMRINPTR I $D(X)#2 S GMRDAT(GMRVITY)=X Q
A W !,?5,$C(7),"Invalid ",GMRVIT(1)," entry"
A1 W !,GMRVIT(1)_": " R GMRRET:DTIME
 S:'$T GMRTO=1 I GMRRET="^"!'$T S GMROUT=1 G INPTR
 I GMRRET="N"!(GMRRET="n") S (X,GMRRET)="" Q
 I GMRRET'["?" S X=GMRRET G INPTR1
 I GMRRET?1"?".E S XQH="GMRV-"_$S(GMRVITY="CG":"CIRCUM/GIRTH",GMRVITY="PO2":"PO2",GMRVITY="CVP":"CVP",1:GMRVIT(1))_" RATE HELP" D EN^XQH K XQH
 G A1
WDUP ;
 W $C(7),!,?4,GMRVIT(1)_" data already exists for this patient on this date/time.",!,?4,"To change this data use the enter a vital/measurement in error option.",!
 Q
SITE ;
 I GMRVITY'="BP" S GMRSITE=$P(X,+X,2),X=+X S GMRSITE=$$UP^XLFSTR(GMRSITE) I GMRVITY="T"!(GMRVITY="P")!(GMRVITY="R") D TPSITE^GMRVUT1 Q
 Q:GMRVITY'="BP"
 I GMRVITY="BP" S GLVL=8 D LISTQ^GMRVQUAL N GMRIN D:$D(GMRDP) CHKBP D OTHERQ^GMRVQUAL,CLEAR^GMRVQUAL
 I $L(X,"/")=1!($L(X,"/")=2&($P(X,"/",2)="")) D
 . I '$D(GMRINF("BP")) W !,"Missing diastolic data!",! K X D BP^GMRVUT1 W ! Q
 . N II S (II,II(0))=0 F  S II=$O(GMRINF("BP",II)) Q:II'>0  D
 . . I $D(GMRINF("BP",II,"PALPATED")) S II(0)=1 Q
 . . I $D(GMRINF("BP",II,"DOPPLER")) S II(0)=1
 . I II(0)=0 W !,"Missing diastolic data!",! K X D BP^GMRVUT1 W !
 Q
CHKBP ; Check for Method of BP for Systolic Value only
 N GMRVOK S (GMRVODR,GMRVOK)=0 F  S GMRVODR=$O(GCOUNT(GMRVODR)) Q:GMRVODR<1  D  Q:GMRVOK
 .S GCAT="" F  S GCAT=$O(GCOUNT(GMRVODR,GCAT)) Q:GCAT=""  D  Q:GMRVOK
 ..I GCAT["METHOD" S GMRVOK=1 Q
 ..Q
 .Q
 Q:'GMRVOK
 Q:'GMRVODR
 K GCOUNT(GMRVODR),GQUAL(GMRVODR),GMRLAST(GMRVODR),GORDER(GMRVODR)
 N GMRCI,GMRCJ,GMRCX
 S GMRCX=$S(GMRSITE="D":"DOPPLER",1:"PALPATED")
 F GMRCI=0:0 S GMRCI=$O(GCHART(GMRCI)) Q:GMRCI<1  I $P(GCHART(GMRCI),"^")=GMRCX S GMRCJ=$P(GCHART(GMRCI),"^",2,3) Q
 S:$G(GMRCJ)'="" GMRIN(GMRVODR,GMRCX)=GMRCJ
 D RESET(GMRVODR,0,.GCOUNT)
 D RESET(GMRVODR,0,.GQUAL)
 D RESET(GMRVODR,0,.GMRLAST)
 D RESET(GMRVODR,0,.GORDER)
 D RESET(GMRVODR,1,.GCHART)
 D RESET(GMRVODR,1,.GCHART1)
 S (GMRCI,GMRCJ,GMRCX)=0 F  S GMRCI=$O(GCHART(GMRCI)) Q:GMRCI<1  D
 .S:GMRCX=0 GMRCX=$P(GCHART(GMRCI),"^",3)
 .I GMRCX=$P(GCHART(GMRCI),"^",3) S GMRCJ=GMRCJ+1 Q
 .I GMRCX'=$P(GCHART(GMRCI),"^",3) D
 ..S GCAT=$O(GMRLAST(GMRCX,"")),GMRLAST(GMRCX,GCAT)=GMRCJ
 ..S GMRCX=$P(GCHART(GMRCI),"^",3),GMRCJ=GMRCJ+1 Q
 .Q
 I GMRCX S GCAT=$O(GMRLAST(GMRCX,"")),GMRLAST(GMRCX,GCAT)=GMRCJ
 Q
RESET(GMRVOD,GMRVFLG,GMY) ; Reset GMY after removal of METHOD
 N GMRCI,GMRCJ,GMY1,GMRCX
 I GMRVFLG D  Q
 .S GMRCJ=0
 .F GMRCI=0:0 S GMRCI=$O(GMY(GMRCI)) Q:GMRCI<1  S GMRCX=$G(GMY(GMRCI)) I $P(GMRCX,"^",3)'=GMRVOD S GMRCJ=GMRCJ+1,GMY1(GMRCJ)=GMRCX S:$P(GMRCX,"^",3)>GMRVOD $P(GMY1(GMRCJ),"^",3)=$P(GMY1(GMRCJ),"^",3)-1
 .K GMY F GMRCI=0:0 S GMRCI=$O(GMY1(GMRCI)) Q:GMRCI<1  S GMRCX=$G(GMY1(GMRCI)),GMY(GMRCI)=GMRCX
 .Q
 F GMRVOD=GMRVOD:0 S GMRVOD=$O(GMY(GMRVOD)) Q:GMRVOD<1  D
 .S GMRCI=$O(GMY(GMRVOD,"")) I GMRCI="" S GMY(GMRVOD-1)=$G(GMY(GMRVOD)) K GMY(GMRVOD) Q
 .S GCAT="" F  S GCAT=$O(GMY(GMRVOD,GCAT)) Q:GCAT=""  D
 ..S GMY(GMRVOD-1,GCAT)=$G(GMY(GMRVOD,GCAT))
 ..K GMY(GMRVOD,GCAT)
 ..Q
 .Q
 Q
HTCHK(X) ; Check ' and " symbols in height entry
 ;  input - X (the height entry)
 ; output - 0 means there is a problem with the single or double quotes
 ;          1 means the single and double quotes are fine 
 I X'["""",X'["'" Q 1  ;quit if ' and " are not in X
 I $L(X,"'")>2!($L(X,"""")>2) Q 0  ;quit if more than 1 ' or "
 N GMRVSQ,GMRVDQ
 S GMRVSQ=$F(X,"'") ;find location of single quote in X
 S GMRVDQ=$F(X,"""") ;find location of double quote in X
 I GMRVDQ>0,GMRVDQ<GMRVSQ Q 0  ;quit if " is before '
 I GMRVSQ>0,GMRVDQ>0,$E(X,GMRVSQ)="""" Q 0  ;quit if '" combination
 Q 1
 ;