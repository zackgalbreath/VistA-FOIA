PRCHUTL1 ;WISC/AKS-UTILITY ROUTINES FOR SUPPLY SYSTEM ;1/26/93  12:47
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENRDAT ; ROUTINE ALLOWING ENTRY OF A DATE FOR PRINTING, ETC. (DEFAULTS TO NOW)
 W !!,"Enter date (and time, if not NOW) to "_M S %DT="AETR",%DT("A")="DATE: NOW//" D ^%DT K %DT
 S:X="" X="NOW" S:X="NOW" Y=$H,PRCHPDAT=$H S:Y=-1 X="^" Q:(X="NOW")!(X["^")
 I +$P(Y,".",2)'>0 W $C(7),!,"You must enter the time as well as the date to print the report" G ENRDAT
 S PRCHPDAT=Y
 Q
 ;
SELDEV ; SELECT DEVICE FOR QUED PRINTING
 D ENK31 W ! K %ZIS,IOP S %ZIS="Q",IOP="Q",%ZIS("B")="" D ^%ZIS Q:POP
 S IOP=ION_";"_IOST_";"_IOM_";"_IOSL I IO=IO(0) D ^%ZIS U IO D @ZTRTN D ^%ZISC
 Q
 ;
ENK3 ; KILL VARIABLES USED BY UNIVERSAL TASK MANAGER AND CLOSE PRINTER
 D ^%ZISC K ZTRTN
ENK31 K ZTUCI,ZTDTH,ZTSAVE,ZTDESC,ZTIO,ZTSK,ZTSKT,ZTCPU,ZTI,ZTJOB,ZTM1,ZTM2,ZTMAST,ZTMGR,ZTNLG,ZTOS,ZTPD,ZTPO,ZTPROD,ZTPT,ZTRET,ZTSIZ,ZTU1,ZTVOL,ZTXMB
 Q
 ;
SQUE(RTN) ;PRINT MESSAGE DENOTING QUEUED JOB HAS BEEN REQUESTED TO STOP
 ;RTN is the routine name that called this line tag
 S:'$D(RTN)!(RTN="") RTN="NOT GIVEN"
 Q "*** USER-REQUESTED STOP ***  ROUTINE - "_RTN