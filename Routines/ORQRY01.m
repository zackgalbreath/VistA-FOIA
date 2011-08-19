ORQRY01 ;SLC/JDL - Order query utility ;11/20/06  09:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**153,174,215,260**;Dec 17, 1997;Build 26
 ;
 ; DBIA 3869   GETPLIST^SDAMA202   ^TMP($J,"SDAMA202")
 ;
DOCDT(DOCS) ;Date range for TIU
 N XDT,SDATE,EDATE
 S XDT=$O(DOCS("Reference",""))
 Q:'$L(XDT)
 S SDATE=$P(XDT,":"),EDATE=$P(XDT,":",2)
 S:SDATE=-1 SDATE=0
 I EDATE=-1 S EDATE=9999999+EDATE
 E  S EDATE=EDATE+1
 K DOCS("Reference",XDT)
 S DOCS("Reference",SDATE_":"_EDATE)=""
 Q
CLINPTS(ORY,CLIN,ORBDATE,OREDATE) ; RETURN LIST OF PTS W/CLINIC APPT W/IN DT RNG
 ;Copied from CLINPTS^ORQPTQ2 without maximum limitation
 S ORY="^TMP(""ORCLINPT"",$J)"
 K @ORY
 I +$G(CLIN)<1 S @ORY@(1)="^No clinic identified" Q 
 I $$ACTLOC^ORWU(CLIN)'=1 S @ORY@(1)="^Clinic is inactive or Occasion Of Service" Q
 N DFN,NAME,I,J,X,ORERR,ORJ,ORSRV,ORNOWDT,CHKX,CHKIN,ORC,CLNAM
 S ORNOWDT=$$NOW^XLFDT
 S ORSRV=$$GET1^DIQ(200,DUZ,29,"I") I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 S DFN=0,I=1
 I ORBDATE="" S ORBDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))
 I OREDATE="" S OREDATE=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))
 ;CONVERT ORBDATE AND OREDATE INTO FILEMAN DATE/TIME
 D DT^DILF("T",ORBDATE,.ORBDATE,"","")
 D DT^DILF("T",OREDATE,.OREDATE,"","")
 I (ORBDATE=-1)!(OREDATE=-1) S @ORY@(1)="^Error in date range." Q 
 S OREDATE=$P(OREDATE,".")_.5  ;ADD 1/2 DAY TO END DATE
 ; DBIA 3869
 N ORI,ORCSTAT
 K ^TMP($J,"SDAMA202","GETPLIST")
 D GETPLIST^SDAMA202(+CLIN,"1;3;4","",ORBDATE,OREDATE)  ;DBIA 3869
 S ORERR=$$CLINERR
 I $L(ORERR) S @ORY@(1)=U_ORERR Q
 S ORI=0
 F  S ORI=$O(^TMP($J,"SDAMA202","GETPLIST",ORI)) Q:ORI<1  D  ;DBIA 3869
 . S ORCSTAT=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,3))
 . I ORCSTAT'="NT" Q:ORCSTAT="C"  Q:ORCSTAT="N"
 . S ORJ=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,1))
 . S DFN=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,4))
 . I ORJ,DFN S @ORY@(I)=DFN_"^"_$P(^DPT(DFN,0),"^")_"^"_+CLIN_"^"_ORJ,I=I+1
 K ^TMP($J,"SDAMA202","GETPLIST")
 S:'$D(@ORY) @ORY@(1)="^No appointments."
 Q
 ;
SDA(ERR,ERRMSG) ; common call to scheduling to return new variables for errors - out of scope
 D SDA^VADPT
 S ERR=VAERR
 I ERR=1 S ERRMSG="^Error encountered^Error encountered" Q
 I ERR=2 S ERRMSG="^Database is unavailable^Database is unavailable" Q
 S ERRMSG=""
 Q
 ;
CLINERR() ; $$ -> error msg or ""
 N ERR,MSG
 S MSG=""
 S ERR=+$O(^TMP($J,"SDAMA202","GETPLIST","ERROR",""))
 I ERR D
 . S MSG="Server Error #"_ERR_": "
 . S MSG=MSG_$G(^TMP($J,"SDAMA202","GETPLIST","ERROR",ERR))
 . K ^TMP($J,"SDAMA202","GETPLIST")
 Q MSG