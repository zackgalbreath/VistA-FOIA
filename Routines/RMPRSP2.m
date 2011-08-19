RMPRSP2 ;PHX/RFM-PRINT SUSPENSE STATISTICS ;8/29/1994
 ;;3.0;PROSTHETICS;**45,52,77**;Feb 09, 1996
 ;
 ; ODJ - patch 52 - ensure report does not include records prior to
 ;       10/05/00   today.
 ;
 ; ODJ - patch 52 - ensure cancelled records are excluded from stats.
 ;       10/05/00
 ; RVD 3/17/03 patch #77 - allow queing to p-message.  IO to ION
 ;
 K ^TMP($J)
 D DIV4^RMPRSIT G:$D(X) EXIT1 D HOME^%ZIS S %DT="AEX",%DT("A")="Starting Date: " D ^%DT G:Y<1 EXIT1 S RMPRBDT=Y
 S %DT(0)=Y,%DT("A")="Ending Date: " D ^%DT K %DT G:Y<1 EXIT1 S RMPREDT=Y
 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT1
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PROSTHETIC SUSPENSE STATISTICS",ZTRTN="PRINT^RMPRSP2",ZTIO=ION,ZTSAVE("RMPRBDT")="",ZTSAVE("RMPREDT")="",ZTSAVE("RMPR(""STA"")")="",ZTSAVE("RMPRSITE")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT1
PRINT W:$E(IOST)["C" @IOF S RMPRPAGE=1 F I=1:1:11 S (CFOT(I),OFOT(I))=0
 S RB=RMPRBDT,(RO,OTOT,CTOT,ITOT,DELDAT,J1,ODELDAT)=0 ;patch 52
 S:$D(^RMPR(668,"B",RB)) RB=$O(^RMPR(668,"B",RB),-1) ;patch 52
C F  S RB=$O(^RMPR(668,"B",RB)) Q:$P(RB,".",1)>RMPREDT!(RB'>0)  F  S RO=$O(^RMPR(668,"B",RB,RO)) Q:RO=""  D CK
 G WRI
CK Q:$P(RB,".",1)<RMPRBDT  ;patch 52
 Q:'$D(^RMPR(668,RO,0))  Q:$P(^(0),U,3)'>0!('+$P(^(0),U,2))  I RMPRSITE'=1,$P(^(0),U,7)'=RMPR("STA") Q
 I RMPRSITE=1,$P(^RMPR(668,RO,0),U,7)'="",$P(^(0),U,7)'=RMPR("STA") Q
 Q:$P(^RMPR(668,RO,0),U,10)="X"  ;patch 52
 S ^TMP($J,$P(^RMPR(668,RO,0),U),RO)=""
 Q
WRI ;
 S RP=0,RQ=0
 F  S RP=$O(^TMP($J,RP)) Q:RP=""  F  S RQ=$O(^TMP($J,RP,RQ)) Q:RQ=""  D CALC
 ;
 I '$D(^TMP($J)) D
 .  S Y=DT D DD^%DT W !,Y,?25,"PROSTHETICS SUSPENSE STATISTICS"_"     STA ",$$STA^RMPRUTIL
 .  W !!,"No statistics available for this period!" S RMPREX=1
 G:$D(RMPREX) EXIT1
LINE W !?15,"Prosthetics Suspense Statistics "
 N X,Y,% D NOW^%DTC S Y=% D DD^%DT S Y=$TR(Y,"@"," ") W $P(Y,":",1,2)
 W !?16,"For The Period "
 ;W !,"PROSTHETICS SUSPENSE STATISTICS FOR THE PERIOD "
 S Y=RMPRBDT D DD^%DT W Y S Y=RMPREDT D DD^%DT
 W "-"_Y_" STA "_$$STA^RMPRUTIL
 W !,"OPEN SUSPENSE RECORDS" S RX="O"
 W !,"PSC",?5,"2421",?11,"2237",?17,"2529-3",?25,"2529-7",?33,"2474",?39,"2431",?45,"2914",?51,"OTHER",?58,"2520",?64,"STK ISU"
 W !,$J(OFOT(1),3),?5,$J(OFOT(2),4),?11,$J(OFOT(3),4),?17,$J(OFOT(4),6),?25,$J(OFOT(5),6),?33,$J(OFOT(6),4),?39,$J(OFOT(7),4),?45,$J(OFOT(8),4),?51,$J(OFOT(9),5),?58,$J(OFOT(10),4),?64,$J(OFOT(11),7)
 ;init action is pending not open
 S RO=0 F  S RO=$O(OFOT(RO)) Q:RO=""  S OTOT=OTOT+OFOT(RO)
 ;
 W !!,"CLOSED SUSPENSE RECORDS"
 W !,"PSC",?5,"2421",?11,"2237",?17,"2529-3",?25,"2529-7"
 W ?33,"2474",?39,"2431",?45,"2914",?51,"OTHER",?58,"2520"
 W ?64,"STK ISU"
 W !,$J(CFOT(1),3),?5,$J(CFOT(2),4),?11,$J(CFOT(3),4),?17
 W $J(CFOT(4),6),?25,$J(CFOT(5),6),?33,$J(CFOT(6),4),?39
 W $J(CFOT(7),4),?45,$J(CFOT(8),4),?51,$J(CFOT(9),5),?58
 W $J(CFOT(10),4),?64,$J(CFOT(11),7)
 ;
TOT1 ;
 N RO
 S RO=0
 F  S RO=$O(CFOT(RO)) Q:RO=""  S CTOT=CTOT+CFOT(RO)
 ;
 W !!,"NUMBER INITIAL ACTION AFTER 5 DAYS: ",DELDAT
 ;
 W !,"PERCENT OF DELIQUENT RECORDS: "
 I DELDAT>0 W DELDAT/CTOT*100\1_"%"
 E  W "NONE"
 ;
 W !,"NUMBER OF DELIQUENT OPEN RECORDS: ",ODELDAT W ?42,"PERCENT: " I ODELDAT>0 W $FN(ODELDAT/OTOT*100,"P",1)
 W !!,"TOTAL CLOSED RECORDS: ",CTOT
 W !,"TOTAL PENDING RECORDS: ",ITOT
 W !,"TOTAL OPEN RECORDS: ",OTOT
 W !!,"TOTAL RECORDS: ",CTOT+OTOT+ITOT
 W !!,"OVERALL PERCENT OF RECORDS BY FORM TYPE",?73,"ERROR"
 ;
 S CALC="S FTOT=CTOT+OTOT+ITOT,FTOT=$S(FTOT=0:0,1:$J(TTOT/FTOT*100,1,1))"
 F I=(OFOT(1)+CFOT(1)),(OFOT(2)+CFOT(2)),(OFOT(3)+CFOT(3)),(OFOT(4)+CFOT(4)),(OFOT(5)+CFOT(5)),(OFOT(6)+CFOT(6)),(OFOT(7)+CFOT(7)),(OFOT(8)+CFOT(8)),(OFOT(9)+CFOT(9)),(OFOT(10)+CFOT(10)),(OFOT(11)+CFOT(11)) D PCAL
 ;
 W !,"PSC",?5,"2421",?11,"2237",?17,"2529-3",?25,"2529-7",?33
 W "2474",?39,"2431",?45,"2914",?51,"OTHER",?58,"2520"
 W ?64,"STK ISU",?73,"MARGIN"
 W !,RTOT(1),?5,RTOT(2),?11,$J(RTOT(3),4),?17,$J(RTOT(4),6)
 W ?25,$J(RTOT(5),6),?33,$J(RTOT(6),4),?39,$J(RTOT(7),4)
 W ?45,$J(RTOT(8),4),?51,$J(RTOT(9),5),?58,$J(RTOT(10),4)
 W ?64,$J(RTOT(11),7)
 N RO,MARERR
 S RO=0,MARERR=0
 F  S RO=$O(RTOT(RO)) Q:RO=""  S MARERR=MARERR+RTOT(RO)
 W ?74,100-MARERR_"%"
 G ASK1
 ;
PCAL S TTOT=I,J1=(J1+1) X CALC S RTOT(J1)=FTOT Q
 ;
ASK1 I $E(IOST)["C" K DIR S DIR(0)="E" D ^DIR G:Y<1 EXIT1
 I $D(NAME) W:$Y>(IOSL-4) @IOF W !!,"RECORDS CLOSED BY PROSTHETICS AGENT",! S RO=0 F  S RO=$O(NAME(RO)) Q:RO=""  W !,RO,?30,$P(NAME(RO),U)
 I $D(NAME),$E(IOST)["C" W !! D ^DIR
EXIT1 ;common exit
 K FO,I,J1,MARERR,MART,RMPRBDT,RX,TTOT,ITOT,TOT,FOT,OFOT,CALC,DELDAT
 K ODELDAT,FTOT,CTOT,OTOT,CFOT,RTOT,RMPREDT,RMPRFLG,RMPRFL,RMPREND
 K RMPRPAGE,RMPRG,X,Y,RMPRFORM,DIR,RP,RS,RQ,RO,RB,RZ,RMPRFOR1,RMPREX
 K ^TMP($J),RP,RR,RMPRFOR2,NAME,DIR
 D ^%ZISC
 Q
 ;
CALC S FO=$P(^RMPR(668,RQ,0),U,3)
 I $P(^RMPR(668,RQ,0),U,5) S $P(CFOT(FO),U)=$P(CFOT(FO),U)+1,X2=$P(^(0),U),X1=$P(^(0),U,9) D ^%DTC I X>7 S DELDAT=DELDAT+1
 ;pending total
 I ($P(^RMPR(668,RQ,0),U,9))&($P(^RMPR(668,RQ,0),U,5)="") S ITOT=ITOT+1
 ;
 I $P(^RMPR(668,RQ,0),U,9),$D(^VA(200,+$P(^RMPR(668,RQ,0),U,6),0)) S:'$D(NAME($P(^(0),U))) NAME($P(^(0),U))="" S $P(NAME($P(^(0),U)),U)=$P(NAME($P(^(0),U)),U)+1
 I '$P(^RMPR(668,RQ,0),U,9) S $P(OFOT(FO),U)=$P(OFOT(FO),U)+1 S X2=$P(^RMPR(668,RQ,0),U),X1=DT D ^%DTC I X>7 S ODELDAT=ODELDAT+1
 Q