SPNLSCH ;ISC-SF/RAH SCHEDULE NATIONAL REGISTRY EXTRACT ;8/29/95  14:30
V ;;2.0;Spinal Cord Dysfunction;;01/02/1997
EN1 ;
 S SPNLERR=""
 K X,% D NOW^%DTC S SPNLSDT=X,SPNLSDAT=% K X,%
 D GETPARM Q:SPNLERR
 ;D SCHED
 D ^SPNLS
 D END
 Q
SCHED ;
 S %DT="AERX",%DT("A")="DATE and TIME to Run SCD Extract:"
 D ^%DT Q:$D(DTOUT)!(X="")!(X="^")  K %DT
 I Y=-1 G SCHED
 S SPNLTMP1=Y
 S ZTDTH=SPNLTMP1,ZTIO=""
 S ZTRTN="SPNLS",ZTDESC="SCD SPINAL CORD REGISTRY EXTRACT"
 D ^%ZTLOAD
 I '$D(ZTSK) S SPNLERR="2^COULD NOT TASK SCD REGISTRY EXTRACT" D ERRMSG
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 Q
ERRMSG ;
 I $D(ZTQUEUED) G ERR2
 W !!,"UNABLE TO SCHEDULE SCD NATIONAL REGISTRY EXTRACT"
 W !!,"ERROR IS: ",$S(SPNLERR="":"SPNLERR IS NULL",SPNLERR'="":SPNLERR)
 Q
ERR2 ;
 K X,% D NOW^%DTC S SPNLDT=%
 S XMSUB="SCD REGISTRY EXTRACT ERROR",XMY("G.SPNL SCD COORDINATOR")=""
 S SPNLFAC=$P(^DIC(4,$P(^XMB(1,1,"XUS"),U,17),99),U,1),SPNLFAC=+$E(SPNLFAC,1,3)
 S SPNLFNAM=$P(^DIC(4,$P(^XMB(1,1,"XUS"),U,17),0),U,1)
 S SPNLTEXT(1)="H$ "_SPNLFAC_"^"_SPNLFNAM
 S SPNLTEXT(2)="E$ "_SPNLDT_"^"_SPNLERR
 S XMDUZ=.5,XMTEXT="SPNLTEXT("
 S:'$D(DTIME) DTIME=300 D ^XMD
 K XMDUZ,SPNTEXT,XMTEXT,XMSUB,XMY
 Q
GETPARM ;
 I '$D(^SPNL(154.91,1,0)) D MAKPARMS Q:SPNLERR
 S SPNPARMS=^SPNL(154.91,1,0)
 S SPNLFAC=$P(^SPNL(154.91,1,0),U,1)
 S SPNLXREC=$P(SPNPARMS,U,2),SPNLXRUN=$P(SPNPARMS,U,3)
 S SPNLFREQ=$P(SPNPARMS,U,4),SPNLSEEN=$P(SPNPARMS,U,5)
 S SPNLEXAM=$P(SPNPARMS,U,6),SPNLXMY=$P(^SPNL(154.91,1,0),U,7)
 Q
MAKPARMS ;
 S SPNLYN=""
 W !!,"===>>>  SITE PARAMETER FILE NOT SET UP  <<<==="
 W !!,"===>>>  SET IT UP NOW?  <<<===" R SPNLYN:DTIME
 I '$T!(SPNLYN']"")!(SPNLYN["^") S SPNLERR="7^SITE PARAMETER FILE NOT SET UP" Q
 I "YNyn"'[SPNLYN W !,"=> Enter only Y for yes or N for no",! G MAKPARMS
 I "nN"[SPNLYN S SPNLERR="7^SITE PARAMETER FILE NOT SET UP" Q
 D EN1^SPNLSPAR
 S SPNLFAC=$P($G(^DIC(4,+$P(^XMB(1,1,"XUS"),U,17),99)),U,1)
 S SPNLFAC=+$E(SPNLFAC,1,3)
 I SPNLFAC'>0 S SPNLERR="2^NO FACILITY NUM IN INSTITUTION FILE"
 Q
END ;
 K SPNLERR,SPNLFAC,SPNLFNAM,SPNLSDAT,SPNLSDT,SPNLTMP1,SPNLYN
 K SPNLTEXT,SPNLXREC,SPNLXRUN,SPNLFREQ,SPNLDT,SPNLSEEN,SPNLEXAM
 K SPNLXMY,SPNPARMS
 Q