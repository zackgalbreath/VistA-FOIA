QAMPFAL1 ;HISC/DAD-PATIENTS WITH MULTIPLE FALL OUTS REPORT ;9/14/92  11:26
 ;;1.0;Clinical Monitoring System;;09/13/1993
 S PAGE=1,QAMQUIT=0 K UNDL S $P(UNDL,"-",80)="-" D NOW^%DTC S Y=X X ^DD("DD") S TODAY=Y D HEAD
 I $O(^UTILITY($J,"QAMPFAL",""))="" W !!,"NO DATA FOUND FOR THIS REPORT" G EXIT
 S QAMNAME="" F QAMNAME(0)=0:0 S QAMNAME=$O(^UTILITY($J,"QAMPFAL",QAMNAME)) Q:QAMNAME=""!QAMQUIT  D LOOP1
EXIT ;
 Q
LOOP1 ;
 S QAMSSN=^UTILITY($J,"QAMPFAL",QAMNAME) W !!,QAMNAME,?56,QAMSSN I $Y>(IOSL-6) D:$E(IOST)="C" PAUSE Q:QAMQUIT  D HEAD
 F QAMDT=0:0 S QAMDT=$O(^UTILITY($J,"QAMPFAL",QAMNAME,QAMDT)) Q:QAMDT'>0!QAMQUIT  D
 . F QAMONIEN=0:0 S QAMONIEN=$O(^UTILITY($J,"QAMPFAL",QAMNAME,QAMDT,QAMONIEN)) Q:QAMONIEN'>0!QAMQUIT  D
 .. F QAMD0=0:0 S QAMD0=$O(^UTILITY($J,"QAMPFAL",QAMNAME,QAMDT,QAMONIEN,QAMD0)) Q:QAMD0'>0!QAMQUIT  D LOOP2
 .. Q
 . Q
 Q
LOOP2 ;
 S Y=QAMDT X ^DD("DD") S QAM=$S($D(^QA(743,QAMONIEN,0))#2:^(0),1:QAMONIEN) W !?2,Y,?24,$P(QAM,"^",2),?56,$E($P(QAM,"^"),1,20),$S($P(QAM,"^",4):" (a)",1:" (m)") I $Y>(IOSL-6) D:$E(IOST)="C" PAUSE Q:QAMQUIT  D HEAD
 Q
PAUSE ;
 K DIR S DIR(0)="E" D ^DIR S QAMQUIT=$S(Y'>0:1,1:0)
 Q
HEAD ;
 W:(PAGE>1)!($E(IOST)="C") @IOF
 W !!?20,"PATIENTS WITH MULTIPLE FALL OUTS (MIN=",QAMINFAL,")",?68,TODAY,!,?80-$L(QAQ2HED)/2,QAQ2HED,?68,"PAGE: ",PAGE S PAGE=PAGE+1
 D EN6^QAQAUTL W !,"PATIENT",?56,"SOCIAL SECURITY NUMBER",!?2,"EVENT DATE",?24,"MONITOR TITLE",?56,"MONITOR CODE",!,UNDL
 Q