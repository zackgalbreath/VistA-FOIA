DGJTEE1 ;MAF/ALB - CONT. ENTER EDIT DEFICIENCIES - JUNE 1992
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
LOOP F DGJTCDIS=0:0 S DGJTCDIS=$O(^TMP("DGJ",$J,DGJTCDIS)) Q:DGJTCDIS']""  F DGJTYP=0:0 S DGJTYP=$O(^TMP("DGJ",$J,DGJTCDIS,DGJTYP)) Q:'DGJTYP  F IFN=0:0 S IFN=$O(^TMP("DGJ",$J,DGJTCDIS,DGJTYP,IFN)) Q:'IFN  D LOOP2
 Q
LOOP2 Q:'$D(^VAS(393,IFN,0))  S DGJTADN=^VAS(393,IFN,0) Q:$P(DGJTDV,"^",1)'=$P(DGJTADN,"^",6)  Q:DGJTAIFN'=$P(DGJTADN,"^",4)  I '$D(DGJTDLT) D STATCK I $D(DGJFL1) K DGJFL1 Q
 I $D(DGJTDLT),'$D(DGJVIEW),$O(^VAS(393.3,"B","DISCHARGE SUMMARY",0))=DGJTYP Q
 I DGJTAIFN]"" D SETG1 Q
 Q
LOWER(X) ;
 N Y,C,Z,I
 S Y=$E(X)_$TR($E(X,2,999),"ABCDEFGHIJKLMNOPQRSTUVWXYZ@","abcdefghijklmnopqrstuvwxyz ")
 F C=" ",",","/" S I=0 F  S I=$F(Y,C,I) Q:'I  S Y=$E(Y,1,I-1)_$TR($E(Y,I),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(Y,I+1,999)
 Q Y
SETSTR(S,V,X,L) ; -- insert text(S) into variable(V)
 ;    S := string
 ;    V := destination
 ;    X := @ col X
 ;    L := # of chars
 ;
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
STATCK ;Status check (complete)
 S X=$P(DGJTADN,"^",11),DGJX=$P(DGJTADN,"^",6),DGJX=$G(^DG(40.8,DGJX,"DT"))
 I $D(DGJTCOM) D
 .I X=CM Q
 .I $P(DGJX,"^",3)=1,X=RV Q
 .I $P(DGJX,"^",3)=0,X=SN Q
 .S DGJFL1=1
 .Q
 E  D  ;not complete
 .I X=CM S DGJFL1=1 Q
 .I $P(DGJX,"^",3)=1,X=RV S DGJFL1=1 Q
 .I $P(DGJX,"^",3)=0,X=SN S DGJFL1=1 Q
 Q
HDR S X=""
 S X=$$SETSTR("  PATIENT: ",X,1,11)
 S X=$$SETSTR($E($P($G(^DPT(DGJTPT,0)),"^",1),1,20),X,12,20)
 S X=$$SETSTR("PT ID: ",X,40,7)
 S X=$$SETSTR(DGJID,X,48,12)
 S VALMHDR(1)=X
 S X=""
 S X=$$SETSTR("ADMISSION: ",X,1,11)
 I $D(DGJTOA),+$G(DGJTX) S X=$$SETSTR($$FTIME^VALM1($P(DGJTOA(DGJTX),"^",2)),X,12,18)
 I '$D(DGJTOA) S X=$$SETSTR("OUTPATIENT",X,12,10)
 S VALMHDR(2)=X
 Q
EXP ; -- expand
 N DGJVALM,DGJAT,VALMY,DIR
 S VALMBCK=""
 D SEL^VALM2 G ENQ:'$O(VALMY(0)) S DGJVALM=0
 D FULL^VALM1 S VALMBCK="R"
 F  S DGJVALM=$O(VALMY(DGJVALM)) Q:'DGJVALM  D
 .D FULL^VALM1
 .S DGJAT=$G(^TMP("DGJIDX",$J,DGJVALM))
 .W !!,^TMP("DGJDEF",$J,+DGJAT,0),!
 .S (DA,DGJDFNO)=+$P(DGJAT,U,2),DIC="^VAS(393,",DR="0" D EN^DIQ,PAUSE^VALM1 I Y=""!(Y=0) S VALMBCK="R" Q
 .I $D(DGJTSEDT) D EXP2 Q
 .S DGJTYP=$P(^VAS(393.3,$P(^VAS(393,DA,0),"^",2),0),"^",1) I "^OP REPORT^DISCHARGE SUMMARY^INTERIM SUMMARY^"[DGJTYP S DGJTYP=$O(^VAS(393.3,"B",DGJTYP,0)) S DGJTAIFN=$P(^VAS(393,DA,0),"^",4),DGJTEDT="1^"_DA D EXP1
 S VALMBCK="R"
ENQ Q
EXP1 D INIT3^DGJTEE2 S VALMBG=1,VALMBCK="R"
 Q
EXP2 ;TS EDIT
 Q:'$D(^VAS(393,DA,0))  I $P(^VAS(393,DA,0),"^",2)'=$O(^VAS(393.3,"B","DISCHARGE SUMMARY",0)) D TSEDIT,EVDT^DGJTEE G TSQ
 S (X,DGJTNUM)=2 S DGJTNO="^^^"_DGJTAIFN D CK^DGJTVW1
 Q
TSEDIT S DIE="^VAS(393,",DA=DA,DR=".07;.09;.1" D ^DIE Q
TSQ S VALMBG=1,VALMBCK="R" Q
PAT1 ; -- change pat
 D FULL^VALM1 S VALMBG=1,VALMBCK="R"
 K X,DGJCPSR1,DGJCPSR2 I $D(XQORNOD(0)) S X=$P($P(XQORNOD(0),U,4),"=",2)
 S DGJCPDFN=DFN,DGJCPNOD=DGJTNODE S:$D(DGJTSR1) DGJCPSR1=DGJTSR1 S:$D(DGJTSR2) DGJCPSR2=DGJTSR2
 I $G(DGJTSR1)=1 S DGJCPTX=DGJTX
 K DGJTSR1,DGJTSR2
 D PAT^DGJTEE
 I Y<0!(DGJTFG=1)!('$D(DGJTSR1)&('$D(DGJTSR2))) S:DGJTAIFN]"" DGJTX=DGJCPTX,DGJTOA(DGJTX)=DGJTAIFN_"^"_$P(^DGPM(DGJTAIFN,0),"^",1) S (DFN,DGJTPT)=DGJCPDFN,DGJTNODE=DGJCPNOD D  G PATQ
 .S:$D(DGJCPSR1) DGJTSR1=DGJCPSR1 S:$D(DGJCPSR2) DGJTSR2=DGJCPSR2
 .W !!,*7,"Patient has not been changed."
 .W ! S DIR(0)="E" D ^DIR K DIR
 .S DGJTFG=0 S VALMBCK="R"
 D HDR^DGJTEE
PATQ Q
SETG1 I $D(DGJTREC) I "^OP REPORT^DISCHARGE SUMMARY^INTERIM SUMMARY^"'[($P(^VAS(393.3,$P(DGJTADN,"^",2),0),"^")) Q
 S DGJTCAT=$P(^VAS(393.3,DGJTYP,0),"^",6)
 S DGJCNT1=DGJCNT1+1
 I '$D(DGJCAT(DGJTCAT)) D CATSET
 S X="",DGJCNT=DGJCNT+1,VALMCNT=VALMCNT+1
 S X=$$SETSTR(DGJCNT1,X,1,3)
 S DGJVAL=$P(DGJTADN,"^",2)
 S X=$$SETSTR($$LOWER($P($G(^VAS(393.3,+DGJVAL,0)),"^")),X,+$S($D(DGJTREC):TC,1:DC),+$S($D(DGJTREC):TW,1:DW))
 S X=$$SETSTR($$LOWER($P($G(^VA(200,+$P(DGJTADN,"^",14),0)),"^")),X,+PC,+PW)
 S X=$$SETSTR($$LOWER($P($G(^DG(393.2,+$P(DGJTADN,"^",11),0)),"^")),X,+SC,+SW)
 S DGX=$P($G(^VAS(393.3,+DGJVAL,0)),"^",6),DGX=$P($G(^VAS(393.41,+DGX,0)),"^") I DGX]"" S X=$$SETSTR($$LOWER(DGX),X,+CC,+CW)
 I $P(DGJTADN,"^",3)]"" S DGX=$P(DGJTADN,"^",3) I DGX]"" S X=$$SETSTR($$LOWER($$FTIME^VALM1(DGX)),X,+EC,+EW)
 S ^TMP("DGJDEF",$J,DGJCNT,0)=X,^TMP("DGJDEF",$J,"IDX",VALMCNT,DGJCNT1)=""
 S ^TMP("DGJIDX",$J,DGJCNT1)=VALMCNT_"^"_IFN
 Q
CATSET ;CATEGORY HEADING
 S DGJCNT=DGJCNT+1,VALMCNT=VALMCNT+1
 S DGJCAT(DGJTCAT)=DGJCNT
 S X=""
 S X=$$SETSTR(" ",X,1,3) D TMP
 S X="",DGJCNT=DGJCNT+1,VALMCNT=VALMCNT+1
 S DGJVAL=$P(^VAS(393.41,DGJTCAT,0),"^",1)
 S DGJVAL1=$L(DGJVAL) S DGJVAL1=(80-DGJVAL1)/2 S DGJVAL1=DGJVAL1\1 S X=$$SETSTR(" ",X,1,DGJVAL1)
 S X=$$SETSTR(DGJVAL,X,DGJVAL1,25) D TMP
 S X="",DGJCNT=DGJCNT+1,VALMCNT=VALMCNT+1
 S X=$$SETSTR(" ",X,1,3) D TMP
 Q
TMP S ^TMP("DGJDEF",$J,DGJCNT,0)=X,^TMP("DGJDEF",$J,"IDX",VALMCNT,DGJCNT1)=""
 S ^TMP("DGJIDX",$J,DGJCNT1)=VALMCNT_"^"_IFN
 Q
