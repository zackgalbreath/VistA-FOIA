PSJMPRT ;BIR/MV-PRINT DRIVE FOR MDWS  ;13 FEB 96 / 10:06 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;Loop thru TMP global to print report
 ;
INIT ;
 Q:'$D(^TMP($J))  U IO
 NEW DRG,ND,PID,PID1,PPN,PPN1,PPNO,PRB,PRB1,PRBO,QST,TM,TM1,TMO,UD0,UD2,XNAME
 S PSJHL1="MEDICATIONS DUE WORKSHEET For: "
 S PSJHL2="Report from: "_$$ENDTC^PSGMI(PSGPLS)_" to: "_$$ENDTC^PSGMI(PSGPLF)_"           "_"Report Date: "_$E($$ENDTC^PSGMI(DT),1,8)
 S XNAME="" S:PSGMTYPE[1 XNAME="ALL MEDS"
 S:PSGMTYPE[2 XNAME="NON-IV MEDs"
 I PSGMTYPE[3 S:XNAME]"" XNAME=XNAME_", " S XNAME=XNAME_"IVPB"
 I PSGMTYPE[4 S:XNAME]"" XNAME=XNAME_", " S XNAME=XNAME_"LVPs"
 I PSGMTYPE[5 S:XNAME]"" XNAME=XNAME_", " S XNAME=XNAME_"TPNs"
 I PSGMTYPE[6 S:XNAME]"" XNAME=XNAME_", " S XNAME=XNAME_"CHEMO (IV)"
 S PSJHL3="Continuous/One time Orders for: "_XNAME
 S PSJHL62="* Projected admin. times based on order's volume, flow rate, and start time."
 S (PSGPG,PSJNEED,PSJLN,PSJADTO,PSJATMEO)=0,(PPNO,PRBO,TMO)=""
 S (PPN,QST,DRG,TM,PSJPRB)="",PSJTOTLN=$S($E(IOST)="C":23,1:62)
 D @PSGSS
 I PSGPG,$G(PSJASTR) D
 . S X=$Y F X=X:1:PSJTOTLN W !
 . W !,PSJHL62 S PSJASTR=0
 Q
 ;
P ;***Selected by Patients.
 F PSJADT=0:0 S PSJADT=$O(^TMP($J,PSJADT)) Q:'PSJADT  F  S PPN=$O(^TMP($J,PSJADT,PPN)) Q:PPN=""  D
 . S PSJHL1=$P(PSJHL1,":")_": "_$P(PPN,U)
 . F PSJATME=0:0 S PSJATME=$O(^TMP($J,PSJADT,PPN,PSJATME)) Q:'PSJATME  F  S QST=$O(^TMP($J,PSJADT,PPN,PSJATME,QST)) Q:QST=""  D
 . . F  S DRG=$O(^TMP($J,PSJADT,PPN,PSJATME,QST,DRG)) Q:DRG=""  D:'$G(PSJSTOP) PRT
 Q
 ;
G ;***Selected by Ward Group.
 S PSJHL1=PSJHL1_PSGWGNM
 ;
W ;***Selected by Ward.
 S:PSGSS="W" PSJHL1=PSJHL1_PSGWN
 F PSJADT=0:0 S PSJADT=$O(^TMP($J,PSJADT)) Q:'PSJADT  F  S TM=$O(^TMP($J,PSJADT,TM)) Q:TM=""  D @("W"_PSGRBADM)
 Q
 ;
WA ;*** Selected by Ward and sort by Admin. time.
 F PSJATME=0:0 S PSJATME=$O(^TMP($J,PSJADT,TM,PSJATME)) Q:'PSJATME  F  S PSJPRB=$O(^TMP($J,PSJADT,TM,PSJATME,PSJPRB)) Q:PSJPRB=""  D
 . F  S PPN=$O(^TMP($J,PSJADT,TM,PSJATME,PSJPRB,PPN)) Q:PPN=""  F  S QST=$O(^TMP($J,PSJADT,TM,PSJATME,PSJPRB,PPN,QST)) Q:QST=""  D
 . .F  S DRG=$O(^TMP($J,PSJADT,TM,PSJATME,PSJPRB,PPN,QST,DRG)) Q:DRG=""  D:'$G(PSJSTOP) PRT
 Q
 ;
WP ;*** Selected by Ward and sort by Patients. 
 F  S PPN=$O(^TMP($J,PSJADT,TM,PPN)) Q:PPN=""  F PSJATME=0:0 S PSJATME=$O(^TMP($J,PSJADT,TM,PPN,PSJATME)) Q:'PSJATME  D
 . F  S QST=$O(^TMP($J,PSJADT,TM,PPN,PSJATME,QST)) Q:QST=""  F  S DRG=$O(^TMP($J,PSJADT,TM,PPN,PSJATME,QST,DRG)) Q:DRG=""  D
 . . D:'$G(PSJSTOP) PRT
 Q
 ;
WR ;*** Selected by Ward and sort by Room-Bed.
 F  S PSJPRB=$O(^TMP($J,PSJADT,TM,PSJPRB)) Q:PSJPRB=""  F  S PPN=$O(^TMP($J,PSJADT,TM,PSJPRB,PPN)) Q:PPN=""  D
 . F PSJATME=0:0 S PSJATME=$O(^TMP($J,PSJADT,TM,PSJPRB,PPN,PSJATME)) Q:'PSJATME  F  S QST=$O(^TMP($J,PSJADT,TM,PSJPRB,PPN,PSJATME,QST)) Q:QST=""  D
 . . F  S DRG=$O(^TMP($J,PSJADT,TM,PSJPRB,PPN,PSJATME,QST,DRG)) Q:DRG=""  D:'$G(PSJSTOP) PRT
 Q
 ;
PRT ;
 S ND=^(DRG),PSGP=+ND,ON=$P(ND,U,2),PID=$P(ND,U,3),PSGWN=$S(PSGSS="W":"",1:$P(ND,U,4)),PRB=$P(ND,U,5)
 I QST["V" D PRT^PSJMIV Q
 S ND=^TMP($J,QST,PSGP,ON),PSJDOS=$P(ND,U),PSJMR=$P(ND,U,2),PSJSCHE=$P(ND,U,3),PSJHOLD=$S($P(ND,U,4):1,1:0)
 S PSGLOD=$E($$ENDTC^PSGMI($P(ND,U,5)),1,5)
 I QST'["Z" S X=$$ENDTC^PSGMI($P(ND,U,6)),PSGLSD=$E(X,1,5)_$E(X,9,15),PSGLFD=$$ENDTC^PSGMI($P(ND,U,7))
 S PSJONETM=$S(QST="O":1,1:0),PSJONCAL=$S(QST="OA":1,1:0)
 S PSJSI=$$ENSET^PSGSICHK(^TMP($J,QST,PSGP,ON,1))
 NEW MARX
 D DRGDISP^PSJLMUT1(PSGP,+ON_$S(QST["Z":"P",1:"U"),40,0,.MARX,1)
 S PSJNEED=$S($D(MARX(2)):2,1:1)
 S X=$L(PSJSI)/41,X=$P(X,".")+($P(X,".",2)>0)
 S PSJNEED=PSJNEED+X+5+PSJHOLD+PSJONETM+PSJONCAL
 D ^PSJMPRTU,PRT^PSJMPRTU
 Q
