SDCCP ;MAN/GRR - AUTO-REBOOK CANCELLED CLINIC REPORT ; 22 MAR 84  12:27 pm
 ;;5.3;Scheduling;**140**;Aug 13, 1993
 I '$D(FSW) S FSW="" D HED
 D:$Y>(IOSL-2) HED
 S P=^DPT(+A,0) W !!,$P(P,"^",1),?32,$E($P(P,"^",9),6,9) S X=GDATE D TM W ?37,$J(X,8) S X=NDATE D:X]"" TM S Y=NDATE D DTS^SDUTL W:NDATE]"" ?48,Y," ",$J(X,8)
 I NDATE F TST=3,4,5 S X=$P(^DPT(+A,"S",NDATE,0),"^",TST) I X]"" D TM W !,?57,$J(X,8)," ",$P("LAB^X-RAY^EKG","^",(TST-2))
 W ! S:DUPE MESS=MESS_$S(MESS]"":",",1:"")_" MULTIPLE APPNTS. ON CANCELLED DATE" W:MESS]"" !,?5,MESS,! S MESS=""
 Q
HED W @IOF,!,?22,"CANCELLED CLINIC AUTO-REBOOK REPORT",!!,"CLINIC: ",$S($D(^SC(SC,0)):$P(^(0),"^"),1:"CLINIC HAS NO NAME"),!,"CLINIC CANCELLED: " S Y=CDATE D DTS^SDUTL W Y,?54,"DATE PRINTED: " S Y=DT D DTS^SDUTL W Y
 W !,"PATIENT NAME",?32,"SSN",?39,"TIME",?50,"NEW DATE/TIME",!! Q
TM S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" Q
