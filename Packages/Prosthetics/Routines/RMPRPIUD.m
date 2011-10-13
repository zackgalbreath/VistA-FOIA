RMPRPIUD ;HINCIO/ODJ - 661.4 APIs ;3/8/01
 ;;3.0;PROSTHETICS;**61,132**;Feb 09, 1996;Build 13
 Q
 ;
 ; LEV - check re-order level for Station, Location, HCPCS Item
LEV(RMPR) ;
 N RMPRERR
 S RMPRERR=0
LEVX Q RMPRERR
 ;
 ; MES - generate MailMan message if item below re-order level
 ;       at a given location.
 ;       this version uses the same business rules as the old
 ;       PIP routine RMPR5NU
 ;
 ; Inputs:
 ;    XMY
MES(XMY) ;
 N RMPRERR,RMPRLINE,RMPRNM,RMPRGBL,RMPRSTR,RMPROBAL,RMPRLEV,RMPRQOH
 N XMSUB,XMDUZ,XMZ,RMPRTXT,RMPR5,RMPR11,RMPRORQ,X,Y,DA
 S RMPRERR=0
 S RMPRNM="RMPRPIUD"
 K ^TMP($J,RMPRNM)
 S RMPRERR=$$ALL(RMPRNM)
MESX Q RMPRERR
 ;
 ; Generate reorder notification for all Stations
ALL(RMPRNM) ;
 N RMPRSTN,RMPRERR,I,J,RMITEM,RMLOC,RMQUA,RMSTN
 S RMPRERR=0
 I $G(RMPRNM)="" S RMPRNM="ALL-RMPRPIUD"
 S (I,RMPRSTN)=""
 ;get current inventory from 661.7 for all HCPCS
 F  S I=$O(^RMPR(661.7,"B",I)) Q:I=""  F J=0:0 S J=$O(^RMPR(661.7,"B",I,J)) Q:J'>0  D
 .I $D(^RMPR(661.7,J,0)) S RMD7=^RMPR(661.7,J,0) D
 ..S RMITEM=$P(RMD7,U,4),RMLOC=$P(RMD7,U,6),RMSTN=$P(RMD7,U,5)
 ..S RMQUA=$P(RMD7,U,7)
 ..I $D(^TMP($J,RMPRNM,RMSTN,I,RMITEM,"L",RMLOC)) S $P(^TMP($J,RMPRNM,RMSTN,I,RMITEM,"L",RMLOC),U,2)=$P(^TMP($J,RMPRNM,RMSTN,I,RMITEM,"L",RMLOC),U,2)+RMQUA
 ..E  S $P(^TMP($J,RMPRNM,RMSTN,I,RMITEM,"L",RMLOC),U,2)=RMQUA
 ;get reorder level for all HCPCS
 F  S RMPRSTN=$O(^RMPR(661.4,"XSHIL",RMPRSTN)) Q:RMPRSTN=""  D
 . S RMPRERR=$$STN(RMPRNM,RMPRSTN)
 . Q
ALLX Q RMPRERR
 ;
 ; Generate reorder/order position for single Station
STN(RMPRNM,RMPRSTN) ;
 N RMPRERR,RMPRH,RMPRI,RMPRL,RMPRK,RMPROLD,RMPREOF,RMPRQFOR,RMPR7E
 N RMPR7I,RMPRTQOH,RMPRTORQ,RMPRTREO,RMPRD,RMPR11,RMPR41,RMPRIEN,RML,RME
 N RMDATA,RMREQUAN
 S RMPRERR=0
 I $G(RMPRNM)="" S RMPRNM="STN-RMPRPIUD"
 S RMPRH=""
 F  S RMPRH=$O(^RMPR(661.4,"XSHIL",RMPRSTN,RMPRH)) Q:RMPRH=""  D
 . F RMPRI=0:0 S RMPRI=$O(^RMPR(661.4,"XSHIL",RMPRSTN,RMPRH,RMPRI)) Q:RMPRI'>0  D
 .. ;set initial balance of re-order quantity
 .. F RML=0:0 S RML=$O(^RMPR(661.4,"XSHIL",RMPRSTN,RMPRH,RMPRI,RML)) Q:RML'>0  D
 ... F RME=0:0 S RME=$O(^RMPR(661.4,"XSHIL",RMPRSTN,RMPRH,RMPRI,RML,RME)) Q:RME'>0  D
 .... I RME,$D(^RMPR(661.4,RME,0)) S RMDATA=$G(^RMPR(661.4,RME,0))
 .... S RMREQUAN=$P(RMDATA,U,4) Q:'$G(RMREQUAN)
 .... S $P(^TMP($J,RMPRNM,RMPRSTN,RMPRH,RMPRI,"L",RML),U,1)=$G(RMREQUAN)
 .. ;
 .. ; Loop on open orders
 .. F STS="O","R" S RMPRD="" F  S RMPRD=$O(^RMPR(661.41,"ASSHID",RMPRSTN,STS,RMPRH,RMPRI,RMPRD)) Q:RMPRD=""  D  Q:RMPRERR
 ... S RMPRIEN=""
 ... F  S RMPRIEN=$O(^RMPR(661.41,"ASSHID",RMPRSTN,STS,RMPRH,RMPRI,RMPRD,RMPRIEN)) Q:RMPRIEN=""  D  Q:RMPRERR
 .... K RMPR41 S RMPR41("IEN")=RMPRIEN
 .... S RMPRERR=$$GET^RMPRPIXN(.RMPR41,)
 .... I RMPRERR S RMPRERR=99 Q
 .... I RMPR41("BALANCE QTY")<1 Q
 .... S ^TMP($J,RMPRNM,RMPRSTN,RMPRH,RMPRI,"M",RMPRD,RMPRIEN)=RMPR41("ORDER QTY")_"^"_RMPR41("DATE ORDER")_"^"_RMPR41("RECEIVE QTY")
 .... Q
 ... Q
 .. Q
 . Q
STNX Q RMPRERR