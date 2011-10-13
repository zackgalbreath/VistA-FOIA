RMPR4C1 ;PHX/HNB,RVD - PURCHASE CARD SUMMARY SHEET ;3/1/1996
 ;;3.0;PROSTHETICS;**3,20,26**;Feb 09, 1996
 ;using new data fields
 W !,"Prosthetics Purchase Card Summary Sheet"
 W !!
START K ^TMP($J) D DIV4^RMPRSIT G:$D(X) EX S RMPRCOUN=0 D HOME^%ZIS W !! S %DT("A")="Starting Date: ",%DT="AEPX" D ^%DT S RMPRBDT=Y G:Y<0 EX
 S %DT("A")="Ending Date: ",%DT="AEX" D ^%DT G:Y<0 EX I RMPRBDT>Y W !,$C(7),"Invalid Date Range Selection!!" G START
 S RMPREDT=Y,Y=RMPRBDT D DD^%DT S RMPRX=Y,Y=RMPREDT D DD^%DT S RMPRY=Y
PCRD ;ask purchase card number
 K DIR S DIR(0)="FO",DIR("A")="Enter PURCHASE CARD NUMBER"
 S DIR("?")="Enter the 16 Digit Purchase Card Number"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) W !,$C(7),$C(7),"Try Later!" G EX
 I $L(X)>16!($L(X)<16)!(X'?.N) W !,"Must be 16 a Digit Number." G PCRD
 S RMPRPCRD=Y
 ;task it
 S %ZIS="MQ" K IOP D ^%ZIS G:POP EX
 I '$D(IO("Q")) U IO G PRINT
 S ZTDESC="PURCHASE CARD SUMMARY",ZTRTN="PRINT^RMPR4C1"
 S ZTSAVE("RMPRBDT")="",ZTSAVE("RMPREDT")="",ZTSAVE("RMPRX")=""
 S ZTSAVE("RMPRY")="",ZTSAVE("RMPR(")="",ZTSAVE("RMPRPCRD")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EX
PRINT S X1=RMPRBDT,X2=-1 D C^%DTC S RO=X,RP=0,PAGE=1,RMPRCOUN=0,RMPREND=""
 I $E(IOST)["C" D WAIT^DICD W @IOF
 F  S RO=$O(^RMPR(664,"B",RO)) Q:RO'>0  Q:RO>RMPREDT  F  S RP=$O(^RMPR(664,"B",RO,RP)) Q:RP'>0  D CK
 ;TCLCNT, total closed liquidated amount
 ;CNT, total authorized amount
 ;ORCNT1, total open transactions
 ;ORCNT2, total closed transactions
 S (RP,RMPROBL,CNT,TCLCNT,NL,RMAMTOT)=""
 S (ORCNT1,ORCNT2)=0
 F  S RMPROBL=$O(^TMP($J,RMPROBL)) Q:RMPROBL'>0  Q:RMPREND=1  F  S RP=$O(^TMP($J,RMPROBL,RP)) Q:RP'>0  S RMAST=$G(^(RP)) Q:RMPREND=1  D WRI
 I $D(RMPREDT)&(RMPRCOUN=0) W @IOF D HDR W $C(7),!!,"NO SELECTIONS MADE DURING THIS DATE RANGE!!"
 I $D(RMPREDT),RMPRCOUN>0,RMPREND'=1 D
 .W !,RMPR("L"),!,?26,"TOTALS"
 .W ?36,$J(NL,9,2)
 .W ?48,$J(RMAMTOT,7,2)
 .W ?57,$J(TCLCNT,9,2)
 .W ?69,$J(CNT,9,2)
 .W !!,?10,"           Total liquidated       ",$J(TCLCNT,9,2)
 .W !,?10,"       Total non-liquidated       ",$J(CNT-TCLCNT,9,2)
 .W !,?10,"Total Cumulative Authorized       ",$J(CNT,9,2)
 .W !!,?10,"Total Open Orders/Transactions        ",$J(ORCNT1,5)
 .W !,?8,"Total Closed Orders/Transactions        ",$J(ORCNT2,5)
 .H 1
EXIT I $E(IOST)["C"&($Y<20) F  W ! Q:$Y>20
 I $D(RMPREDT),'$D(DTOUT),'$D(DUOUT),$E(IOST)["C",'$D(RMPRFLL),RMPREND'=1 S DIR(0)="E" D ^DIR
EX K RMPREND,RMPROBL,RMPRFLL,RMPRFLG,DUOUT,DIR,RO,RP,RMPRY,RMPRCOUN,RMPRX,RMPRBDT,RMPREDT,RMPRCK,%DT,X,Y,PAGE,IT,ZTSK,^TMP($J) D ^%ZISC
 K CNT,DTOUT,ROBL,X1,X2,RMPR,RMSHI,R660T,R660AC,RMAMTOT,RMAST,RMCUM,RMIDA,RMAMEN,CLODT,TCLCNT,NL,ORCNT1,ORCNT2,%ZIS,DCT,RMACS
 Q
CK ;check record, apply screen
 Q:'$D(^RMPR(664,RP,0))
 ;vendor, purchase card, cancelation date
 Q:$P(^RMPR(664,RP,0),U,4)=""!($P($G(^(4)),U,1)="")!($P(^(0),U,5)'="")
 Q:$P(^RMPR(664,RP,0),U,14)'=""&($P(^(0),U,14)'=RMPR("STA"))
 S ROBL=$P($G(^RMPR(664,RP,4)),U,1)
 S RMPROBL=$$DEC^RMPR4LI($P(^RMPR(664,RP,4),U,1),$P(^RMPR(664,RP,0),U,9),RP)
 Q:RMPROBL'=RMPRPCRD
 S RMAST="",(R660AC,R660T,RMACS)=0,DCT=0 S RMACS=$S($P(^RMPR(664,RP,0),U,11):$P(^RMPR(664,RP,0),U,11),1:$P(^RMPR(664,RP,0),U,10)) S RMSHI=$P(^RMPR(664,RP,0),U,12) I RMSHI S R660T=$P($G(^RMPR(660,RMSHI,0)),U,17) S:+RMACS'=+R660T RMAST="*"
 I $D(^RMPR(664,RP,2)),$P(^(2),U,6) S DCT=$P(^(2),U,6),DCT=DCT/100
 F I=0:0 S I=$O(^RMPR(664,RP,1,I)) Q:I'>0  S R660T=$S($P($G(^(I,0)),U,7):$P(^(0),U,7)*$P(^(0),U,4),1:$P(^(0),U,3)*$P(^(0),U,4)) I R660T D
 .S:DCT R660T=R660T-(R660T*DCT)
 .S RMIDA=$P($G(^(0)),U,13) I RMIDA S R660AC=$P($G(^RMPR(660,RMIDA,0)),U,16) S:+R660AC'=+R660T RMAST="*"
 S ^TMP($J,RMPROBL,RP)=RMAST,RMPRCOUN=RMPRCOUN+1
 Q
WRI I '$D(RMPRFLG) D HDR
 W !,$E($P(^DPT($P(^RMPR(664,RP,0),U,2),0),U,1),1,12)
 W ?14,$E($P(^DPT($P(^RMPR(664,RP,0),U,2),0),U,9),6,9)
 N RD
 S RD=$P(^RMPR(664,RP,0),U,1)
 S RD=$P(RD,"."),RD=$E(RD,4,5)_"/"_$E(RD,6,7)
 W ?19,RD,?26,$P($G(^RMPR(664,RP,4)),U,5)
 S (AACNT,CLCNT,RMAMEN)=0
 ;AACNT, est amount
 ;RMAMEN, ADJ amount
 ;CLCNT, closed amount
 ;CLODT, CLOSE OUT DATE
 S RMAMEN=$P(^RMPR(664,RP,2),U,9)
 S AACNT=$P(^RMPR(664,RP,4),U,3)
 S CLCNT=$P(^RMPR(664,RP,4),U,4)
 S CLODT=$P(^RMPR(664,RP,0),U,8)
 I 'RMAMEN S RMAMEN=0
 E  S RMAMEN=RMAMEN-AACNT
 I $G(CLODT) S ORCNT2=ORCNT2+1
 E  S ORCNT1=ORCNT1+1
 S NL=NL+AACNT,RMAMTOT=RMAMTOT+RMAMEN
 S TCLCNT=TCLCNT+CLCNT
 S RMCUM=$S(CLCNT'="":CLCNT,AACNT'="":AACNT+RMAMEN,1:"")
 ;S:RMCUM'=R660T RMAST="*"
 S CNT=CNT+RMCUM
 W ?36,$J(AACNT,9,2)
 W ?48,$J(RMAMEN,7,2)
 W ?57,$J(CLCNT,9,2)
 W ?69,$J(CNT,9,2)_RMAST
 S RMPRFLG=1
 I $E(IOST)["C"&($Y>(IOSL-6)) W ! S DIR(0)="E" D ^DIR S:Y<1 RMPREND=1 Q:Y=""  S:Y<1 RMPRFLL=1 Q:Y<1  S:$D(DTOUT) RMPREND=1 Q:$D(DTOUT)  D HDR Q
 I $Y>(IOSL-6) K RMPRFLG
 Q
HDR I PAGE'=1 W @IOF
 W !,RMPRX_"-",RMPRY,"  "_RMPRPCRD_" Summary "_"STA "_$$STA^RMPRUTIL,?72,"PAGE ",PAGE,! S PAGE=PAGE+1
 W !,"Patient",?14,"SSN",?19,"Date",?26,"PC #",?37,"Auth Amt",?48,"Adj Amt",?59,"Liq Amt",?71,"Cum Amt",!,RMPR("L")
 Q