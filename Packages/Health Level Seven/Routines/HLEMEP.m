HLEMEP ;ALB/CJM-HL7 - Purge Monitor Events  ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
PURGE ;
 N NOW,WHEN,EVENT,ERROR
 S NOW=$$NOW^XLFDT
 S WHEN=0
 D START^HLEVAPI(.VAR)
 ;
 ;delete the old events
 F  S WHEN=$O(^HLEV(776.4,"AJ",WHEN)) Q:'WHEN  Q:WHEN>NOW  D
 .S EVENT=0
 .F  S EVENT=$O(^HLEV(776.4,"AJ",WHEN,EVENT)) Q:'EVENT  D
 ..I '$$DELETE^HLEMU(776.4,EVENT,.ERROR),'$D(^HLEV(776.4,EVENT,0)) K ^HLEV(776.4,"AJ",WHEN,EVENT)
 ;
 ;delete the old statistics
 N STATS,SITE,TYPE,YEAR,MONTH,DAY,CUTMONTH,CUTDAY,CUTHOUR
 S STATS="^HLEV(776.4,""AF"")"
 S SITE=0
 ;
 ;these determine the timeframes within which to delete the old statistics
 S CUTMONTH=$E($$FMADD^XLFDT(DT,-65),1,5)
 S CUTDAY=$P($$FMADD^XLFDT(DT,-8),".")
 S CUTHOUR=$$FMADD^XLFDT(NOW,-2)
 ;
 F  S SITE=$O(@STATS@(SITE)) Q:'SITE  D
 .S TYPE=0
 .F  S TYPE=$O(@STATS@(SITE,TYPE)) Q:'TYPE  D
 ..S YEAR=""
 ..F  S YEAR=$O(@STATS@(SITE,TYPE,"RECEIVED","YEAR",YEAR)) Q:'YEAR  D
 ...S MONTH=""
 ...F  S MONTH=$O(@STATS@(SITE,TYPE,"RECEIVED","YEAR",YEAR,"MONTH",MONTH)) Q:(MONTH="")  D
 ....I ((YEAR-1700)_$$PAD2(MONTH))<CUTMONTH D
 .....K @STATS@(SITE,TYPE,"RECEIVED","YEAR",YEAR,"MONTH",MONTH)
 ....E  D
 .....S DAY=""
 .....F  S DAY=$O(@STATS@(SITE,TYPE,"RECEIVED","YEAR",YEAR,"MONTH",MONTH,"DAY",DAY)) Q:(DAY="")  D
 ......I ((YEAR-1700)_$$PAD2(MONTH)_$$PAD2(DAY))<CUTDAY D
 .......K @STATS@(SITE,TYPE,"RECEIVED","YEAR",YEAR,"MONTH",MONTH,"DAY",DAY)
 ......E  D
 .......S HOUR=0
 .......F  S HOUR=$O(@STATS@(SITE,TYPE,"RECEIVED","YEAR",YEAR,"MONTH",MONTH,"DAY",DAY,"HOUR",HOUR)) Q:(HOUR="")  Q:((YEAR-1700)_$$PAD2(MONTH)_$$PAD2(DAY)_"."_$$PAD2(HOUR))>CUTHOUR  D
 ........K @STATS@(SITE,TYPE,"RECEIVED","YEAR",YEAR,"MONTH",MONTH,"DAY",DAY,"HOUR",HOUR)
 ;
 ;
 D CHECKOUT^HLEVAPI
 K ^TMP("HLEVFLAG",$J)
 Q
 ;
INPERSON ;entry point for running in the foreground
 S ^TMP("HLEVFLAG",$J)="STOP"
 D PURGE
 Q
PAD2(STRING) ;
 ; pads a number on the left with '0', to a length of 2
 Q $$RJ^XLFSTR(STRING,2,"0")
 ;