DVBCXUTL ;ALB/GTS-AMIE Transfer utility routines ; 11/28/94  2:30 PM
 ;;2.7;AMIE;**2**;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 15)
 ;
INREAS ;** Add insufficient reason to server msg
 S EXAMS=EXAMS_"^"
 I $D(DVBAINSF) DO
 .N DVBAXMDA S DVBAXMDA=""
 .F  S DVBAXMDA=$O(XEXAMS(DVBAXMDA)) Q:(DVBAXMDA="")  DO
 ..S EXAMS=EXAMS_$S(+$P(^DVB(396.4,DVBAXMDA,0),U,11)>0:$P(^DVB(396.94,$P(^DVB(396.4,DVBAXMDA,0),U,11),0),U,2),1:"")_"^"
 Q
 ;
CLRVAR ;** Clear the XMVAR local array
 F LPCNT=0:0 S LPCNT=$O(XMVAR(LPCNT)) Q:LPCNT=""  K XMVAR(LPCNT)
 Q
 ;
SETXMVR ;** XMVAR(XMCNT)=$EXAM AMIE EXAM IFN^INSUF REASON IFN
 S XMVAR(XMCNT)="$EXAM "_$P(^DVB(396.4,+Y,0),U,3)
 S:$D(DVBAINSF) XMVAR(XMCNT)=XMVAR(XMCNT)_U_$S(+$P(^DVB(396.4,+Y,0),U,11)>0:$P(^DVB(396.94,$P(^DVB(396.4,+Y,0),U,11),0),U,1),1:"")
 Q
 ;
KILLVRS ;** Kill variables used by DVBCXFRA
 K DIC,%,%Y,I,J,JJ,EXMNM,SEL,CORR,DOMNUM,DOMNUM1,DOMNAM,EXAMS,DVBAINSF,XMCNT,LPCNT
 Q