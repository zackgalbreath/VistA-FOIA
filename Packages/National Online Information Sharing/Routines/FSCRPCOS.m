FSCRPCOS ;SLC/STAFF-NOIS RPC Sort ;2/10/97  14:47
 ;;1.1;NOIS;;Sep 06, 1998
 ;
SORT(IN,OUT) ; from FSCRPX (RPCSort)
 ; SORT(seq #) = zero node of field
 ; SORT(sort seq #,"D") = ""  (exists if field is to be sorted in descending order)
 N CALL,CHECK,CNT,DA,DESCEND,DIC,DIQ,DR,FLD,GBL,LASTCNT,LEN,LINE,LNUM,NUM,SORT,TMPSORT,TYPE,VAL,VALUE K DIQ,SORT,VALUE
 S NUM=0 F  S NUM=$O(^TMP("FSCRPC",$J,"INPUT",NUM)) Q:NUM<1  S LINE=^(NUM) D
 .S SORT(NUM)=$P(LINE,U,2,99)
 .I $P(LINE,U)="D" S SORT(NUM,"D")=""
 I '$O(SORT(0)) Q
 S DESCEND="" K ^TMP("FSC SORT",$J)
 F CNT=1:1 Q:'$D(SORT(CNT))  S LASTCNT=CNT I $D(SORT(CNT,"D")) S DESCEND=DESCEND_CNT_","
 S LEN=60\LASTCNT
 S DR="",CNT=0 F  S CNT=$O(SORT(CNT)) Q:CNT<1  S DR=DR_$P(SORT(CNT),U,8)_";"
 S DIC=7100,DIQ="VALUE",DIQ(0)="IE"
 S CALL=0 F  S CALL=$O(^TMP("FSC CURRENT LIST",$J,"C",CALL)) Q:CALL<1  D
 .S DA=CALL K VALUE D EN^DIQ1
 .S GBL="^TMP(""FSC SORT"",$J",CNT=0 F  S CNT=$O(SORT(CNT)) Q:CNT<1  D
 ..S FLD=$P(SORT(CNT),U,8),TYPE=$P(SORT(CNT),U,3)
 ..S VAL=VALUE(7100,CALL,FLD,$S(TYPE["D":"I",1:"E"))
 ..D
 ...I TYPE["D"!(TYPE["N") S VAL=$S(VAL'<1:+VAL,$E(VAL)'=".":+VAL,VAL?1P1N.N:"0"_VAL,1:+VAL) I DESCEND[(CNT_",") S VAL=9999999-VAL Q
 ...S VAL=$$UP^XLFSTR(VAL) I DESCEND[(CNT_",") S VAL=$TR(VAL,"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ","9876543210ZYXWVUTSRQPONMLKJIHGFEDCBA")
 ..S VAL=""""_$S(DESCEND[(CNT_",")&'$L(VAL):"Z",1:" ")_$E(VAL,1,LEN)_""""
 ..S GBL=GBL_","_VAL
 ..I '$O(SORT(CNT)) S GBL=GBL_","_CALL_")" S @GBL=CALL
 K ^TMP("FSC CURRENT LIST",$J),DIC,DIQ,VALUE
 S LNUM=0
 S TMPSORT="^TMP(""FSC SORT"",$J)",CHECK="^TMP(""FSC SORT"","_$J_",""z"""
 F  S TMPSORT=$Q(@TMPSORT)  Q:TMPSORT]CHECK  S CALL=@TMPSORT D
 .S LNUM=LNUM+1
 .S (^TMP("FSCRPC",$J,"OUTPUT",LNUM),^TMP("FSC CURRENT LIST",$J,LNUM+1000))=CALL_U_$$SHORT^FSCRPXUS(CALL,DUZ)
 .S ^TMP("FSC CURRENT LIST",$J,"C",CALL)=LNUM+1000
 K ^TMP("FSC SORT",$J)
 Q
