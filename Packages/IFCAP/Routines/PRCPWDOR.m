PRCPWDOR ;WISC/RFJ-print outstanding (due-outs) items               ;24 Jul 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PRCPPVNO
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="W" W !,"YOU NEED TO BE A 'WAREHOUSE' INVENTORY POINT TO RUN THIS OPTION!" Q
 S PRCPPVNO=+$O(^PRC(440,"AC","S",0))_";PRC(440," I '$D(^PRC(440,+PRCPPVNO,0)) W !!,"THERE IS NOT A VENDOR IN THE VENDOR FILE (#440) DESIGNATED AS A SUPPLY WHSE." Q
 W !,"THIS REPORT WILL TAKE A WHILE TO RUN.  IT IS RECOMMENDED THE REPORT BE",!,"QUEUED TO RUN AT NIGHT."
 K PRCPWDOU S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) S ZTRTN="DQ^PRCPWDOR",ZTDESC="Outstanding Due-Outs for Warehouse",ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@" D ^%ZTLOAD K IO("Q"),ZTSK Q
 W !!,"<*> please wait <*>"
DQ ;  queue comes here
 N %,PRCPDATA,PRCPDAT0,PRCPDAT3,MASTITEM,ITEMDATA,PRCPDAT7,PRCPDAT9,PAGE,PRCPCONV,PRCPDATE,PRCPERR,PRCPFLAG,PRCPITEM,PRCPLIDA,PRCPLINE,PRCPNSN,PRCPOUT,PRCPSRC1,PRCPTRAN,PRCPTRDA,REFNUM,SCREEN,X,Y
 K ^TMP($J,"PRCPWDOR")
 D NOW^%DTC S Y=% D DD^%DT S PRCPDATE=Y,PRCPTRDA=0
 F  S PRCPTRDA=$O(^PRCS(410,PRCPTRDA)) Q:'PRCPTRDA!($G(PRCPFLAG))  S PRCPDAT0=$G(^PRCS(410,PRCPTRDA,0)) I PRCPDAT0'="" S PRCPTRAN=$P(PRCPDAT0,"^") D
 .   S PRCPDAT3=$G(^PRCS(410,PRCPTRDA,3)),PRCPDAT7=$G(^PRCS(410,PRCPTRDA,7)),PRCPDAT9=$G(^PRCS(410,PRCPTRDA,9))
 .   I $P(PRCPDAT0,"^",2)="O",$P(PRCPDAT0,"^",4)=5,$P(PRCPDAT3,"^",4)=+PRCPPVNO,$P(PRCPDAT7,"^",6)'="",$P(PRCPDAT9,"^",3)="" D
 .   .   S PRCPSRC1=+$P(PRCPDAT0,"^",6),PRCPLIDA=0 F  S PRCPLIDA=$O(^PRCS(410,PRCPTRDA,"IT",PRCPLIDA)) Q:'PRCPLIDA  S PRCPLINE=$G(^(PRCPLIDA,0)) I PRCPLINE'="",$P(PRCPLINE,"^",14)="" D
 .   .   .   S PRCPITEM=+$P(PRCPLINE,"^",5),PRCPCONV=$P($$GETVEN^PRCPUVEN(PRCPSRC1,PRCPITEM,PRCPPVNO,1),"^",4)
 .   .   .   S PRCPOUT=$P(PRCPLINE,"^",2) I $P(PRCPLINE,"^",12)'="" S PRCPOUT=$P(PRCPLINE,"^",2)-$P(PRCPLINE,"^",12)
 .   .   .   I $P(PRCPLINE,"^",12)="" S %=$G(^PRCP(445,PRCPSRC1,1,PRCPITEM,7,PRCPTRDA,0)) I %'="" S PRCPOUT=$P(%,"^",2)\PRCPCONV
 .   .   .   S:PRCPOUT<0 PRCPOUT=0 Q:'PRCPOUT  S MASTITEM=$G(^PRC(441,PRCPITEM,0)) I MASTITEM="" S ^TMP($J,"PRCPWDOR"," ",PRCPITEM,"ERROR")="ITEM NOT IN ITEM MASTER FILE #441" Q
 .   .   .   S PRCPNSN=$P(MASTITEM,"^",5) S:PRCPNSN="" PRCPNSN=" " S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,PRCPITEM,0)) K PRCPERR I ITEMDATA="" S PRCPERR="ITEM NOT FOUND IN INVENTORY POINT"
 .   .   .   I '$D(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM)) S ^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM)=$P(MASTITEM,"^",2)_"^"_$P(ITEMDATA,"^",7)_"^"_$$GETOUT^PRCPUDUE(PRCP("I"),PRCPITEM)
 .   .   .   S:$D(PRCPERR) ^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,"ERROR")=PRCPERR S Y=$P($G(^PRCS(410,PRCPTRDA,1)),"^",1) I Y'="" D DD^%DT
 .   .   .   S REFNUM=$P($G(^PRCS(410,PRCPTRDA,445)),"^") I REFNUM="" S REFNUM=$P($G(^PRCS(410,PRCPTRDA,100)),"^")
 .   .   .   I '$D(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,PRCPTRDA)) S ^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,PRCPTRDA)=PRCPTRAN_"^"_REFNUM_"^"_PRCPSRC1_"^"_Y
 .   .   .   S $P(^(PRCPTRDA),"^",5)=$P(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,PRCPTRDA),"^",5)+PRCPOUT,$P(^(PRCPITEM),"^",4)=$P(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM),"^",4)+PRCPOUT
 .   .   .   S %=$G(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,PRCPTRDA,"L")) S ^("L")=%_$S(%="":"",1:",")_$P(PRCPLINE,"^")
 I $G(PRCPFLAG) D Q Q
 S PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S PRCPNSN="" F  S PRCPNSN=$O(^TMP($J,"PRCPWDOR",PRCPNSN)) Q:PRCPNSN=""!($G(PRCPFLAG))  S PRCPITEM=0 F  S PRCPITEM=$O(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM)) Q:'PRCPITEM!($G(PRCPFLAG))  S PRCPDATA=^(PRCPITEM) D
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .   S %=$E($P(PRCPDATA,"^"),1,20-$L(PRCPITEM)-2)_"("_PRCPITEM_")"
 .   I $D(PRCPWDOU),$P(PRCPDATA,"^",3)'=$P(PRCPDATA,"^",4),'$D(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,"ERROR")) S $P(PRCPDATA,"^",3)="* "_$P(PRCPDATA,"^",3)
 .   W !!,PRCPNSN,?19,%,?40,$J($P(PRCPDATA,"^",2),13),$J($P(PRCPDATA,"^",3),13),$J($P(PRCPDATA,"^",4),13) I $D(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,"ERROR")) W !?19,^("ERROR")
 .   S PRCPTRDA=0 F  S PRCPTRDA=$O(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,PRCPTRDA)) Q:'PRCPTRDA!($G(PRCPFLAG))  S PRCPDATA=^(PRCPTRDA) D
 .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .   .   W !?5,$P(PRCPDATA,"^"),?24,$P(PRCPDATA,"^",2),?31,"#",$G(^TMP($J,"PRCPWDOR",PRCPNSN,PRCPITEM,PRCPTRDA,"L")),?42,$P(PRCPDATA,"^",4),?55,$E($P($$INVNAME^PRCPUX1($P(PRCPDATA,"^",3)),"-",2,99),1,15),?70,$J($P(PRCPDATA,"^",5),9)
 I $G(PRCPFLAG) D Q Q
 I $D(PRCPWDOU) W !!,"* indicates the quantity due-out has been changed to the quantity outstanding"
 I '$D(PRCPWDOU) D END^PRCPUREP
Q I '$D(PRCPWDOU) K ^TMP($J,"PRCPWDOR") D ^%ZISC
 Q
 ;
H S %=PRCPDATE_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"OUTSTANDING TRANSACTION REPORT",?(79-$L(%)),% S %="INVENTORY POINT: "_PRCP("IN") W !?(79-$L(%)\2),%
 W !,?19,"ITEM",?40,$J("QUANTITY",13),$J("QUANTITY",13),$J("QUANTITY",13) S %="",$P(%,"-",80)="" W !,"NSN",?19,"DESCRIPTION (#)",?40,$J("ON-HAND",13),$J("DUE-OUT",13),$J("OUTSTANDING",13),!,%
 Q
