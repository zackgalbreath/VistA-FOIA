DVBHQR12 ;ALB/JLU;ROUTINE FOR C&P AND BIRLS ;8/28/91
 ;;4.0;HINQ;**32,35,49**;03/25/92 
 ; PROCESSING THE C&P RECORD AND THEN THE BIRLS RECORD
 ;
DEDBL ; The deduction balance segment "E" and "F"
EDEDBL S $P(DVBDBE,U,1)=$E(X,1),$P(DVBDBE,U,2)=$E(X,2,3)
 S $P(DVBDBE,U,3)=$E(X,4)
 S DVBV1=$E(X,5,10) I DVBV1?5N1A!(DVBV1["{") S DVBV2=6 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBDBE,U,4)=+$E(DVBV1,1,4)_"."_$E(DVBV1,5,6)
 S DVBV1=$E(X,11,18) I DVBV1?7N1A!(DVBV1["{") S DVBV2=6 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S DVBP(5)=+$E(DVBV1,1,6)_"."_$E(DVBV1,7,8)_U
 S DVBV1=$E(X,19,25) I DVBV1?6N1A!(DVBV1["{") S DVBV2=7 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBDBE,U,6)=+$E(DVBV1,1,5)_"."_$E(DVBV1,6,7),$P(DVBDBE,U,7)=$E(X,26,27)
 S $P(DVBDBE,U,8)=$E(X,28,29),$P(DVBDBE,U,9)=$E(X,30)
 S L=31 D RON
 ;
FDEDBL S $P(DVBDBF,U,1)=$E(X,1),$P(DVBDBF,U,2)=$E(X,2,3)
 S $P(DVBDBF,U,3)=$E(X,4)
 S DVBV1=$E(X,5,12) I DVBV1?7N1A!(DVBV1["{") S DVBV2=8 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBDBF,U,4)=+$E(DVBV1,1,6)_"."_$E(DVBV1,7,8),$P(DVBDBF,U,5)=$E(X,13,14)
 S $P(DVBDBF,U,6)=$E(X,15)
 S L=16 D RON
 ;
REF ;REFERENCE-NUMBER-DATA.
 S $P(DVBREF,U,1)=$E(X,1,9),$P(DVBREF,U,2)=$E(X,10,18)
 S $P(DVBREF,U,3)=$E(X,19,27)
 S L=28 D RON
 ;make a call to INC^DVBHQR13, as the future segments will no longer be
 ;included in the VBA response message after DVB*4*49
 G INC^DVBHQR13
 ;
FUT ;DVB*4*49 - the call to G INC^DVBHQR13 is made in REF, and this code 
 ;will be skipped
 ;FUTURE DATA.
 ;A-TYPE-FUTURE-DATA:
 S DVBP(3)="A"_"^"_9_"^"
 F XX=1:8:65 S DVBP(3)=DVBP(3)_$E(X,XX,XX+7)_"^"
 S L=XX+8 D RON
 ;E/F-TYPE-FUTURE-DATA:
 D FUTE,FUTF
 ;
RON S X=$E(X,L,999),LX=$L(X),LY=254-LX I $D(X(2)),(LX+$L(X(2)))<256 S X=X_X(2) K X(2) D RON1 Q
 I $D(X(2)) S X=X_$E(X(2),1,LY),X(2)=$E(X(2),LY+1,999) Q
 Q
 ;
RON1 F Z1=3:1:99 I $D(X(Z1)),'$D(X(Z1-1)) S X(Z1-1)=X(Z1) K X(Z1) Q:'$O(X(Z1))
 QUIT
 ;
FUTE ;future segment type E
 S $P(DVBFUE,U)=$E(X,1)
 S $P(DVBFUE,U,2)=$E(X,2,9),$P(DVBFUE,U,3)=$E(X,10)
 S DVBV1=$E(X,11,16)
 I DVBV1?5N1A!(DVBV1["{") S DVBV2=6 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBFUE,U,4)=+$E(DVBV1,1,4)_"."_$E(DVBV1,5,6),$P(DVBFUE,U,5)=$E(X,17)
 S $P(DVBFUE,U,6)=$E(X,18,19),$P(DVBFUE,U,7)=$E(X,20,21)
 S $P(DVBFUE,U,8)=$E(X,22,23),$P(DVBFUE,U,9)=$E(24,25)
 S $P(DVBFUE,U,10)=$E(X,26),$P(DVBFUE,U,11)=$E(X,27)
 S $P(DVBFUE,U,12)=$E(X,28,32),$P(DVBFUE,U,13)=$E(X,33,34)
 S $P(DVBFUE,U,14)=$E(X,35),$P(DVBFUE,U,15)=$E(X,36)
 S $P(DVBFUE,U,16)=$E(X,37),$P(DVBFUE,U,17)=$E(X,38,40)
 S L=41 D RON
 I $P(DVBFUE,U,3) D LONGE
 E  S L=31 D RON
 Q
 ;
LONGE S LP1=18
 F LP=1:6:25 S DVBV1=$E(X,LP,LP+5) D LONCH S $P(DVBFUE,U,LP1)=+$E(DVBV1,1,4)_"."_$E(DVBV1,5,6),LP1=LP1+1
 S L=31 D RON
 Q
 ;
LONCH I DVBV1?5N1A!(DVBV1["{") S DVBV2=6 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 Q
 ;
FUTF ;F subsegment of the future segment.
 S $P(DVBFUF,U)=$E(X,1)
 S $P(DVBFUF,U,2)=$E(X,2,9),$P(DVBFUF,U,3)=$E(X,10)
 S $P(DVBFUF,U,4)=$E(X,11,18),$P(DVBFUF,U,5)=$E(X,19,26)
 S $P(DVBFUF,U,6)=$E(X,27),$P(DVBFUF,U,7)=$E(X,28)
 S $P(DVBFUF,U,8)=$E(X,29),$P(DVBFUF,U,9)=$E(X,30,31)
 S $P(DVBFUF,U,10)=$E(X,32),$P(DVBFUF,U,11)=$E(X,33)
 S DVBV1=$E(X,34)
 I DVBV1?1A!(DVBV1["{") S DVBV2=1 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBFUF,U,12)=DVBV1
 S DVBV1=$E(X,35)
 I DVBV1?1A!(DVBV1["{") S DVBV2=1 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBFUF,U,13)=DVBV1
 S $P(DVBFUF,U,14)=$E(X,36)
 S L=37 D RON
 S DVBV1=$E(X,1,2)
 I DVBV1?1N1A!(DVBV1["{") S DVBV2=2 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBFUF,U,15)=DVBV1
 S $P(DVBFUF,U,16)=$E(X,3,5),$P(DVBFUF,U,17)=$E(X,6,9)
 S $P(DVBFUF,U,18)=$E(X,10,11),$P(DVBFUF,U,19)=$E(X,12,15)
 S $P(DVBFUF,U,20)=$E(X,16,17),$P(DVBFUF,U,21)=$E(X,18,21)
 S $P(DVBFUF,U,22)=$E(X,22,23),$P(DVBFUF,U,23)=$E(X,24,27)
 S $P(DVBFUF,U,24)=$E(X,28,29),$P(DVBFUF,U,25)=$E(X,30,33)
 S $P(DVBFUF,U,26)=$E(X,34,35),$P(DVBFUF,U,27)=$E(X,36,39)
 S $P(DVBFUF,U,28)=$E(X,40,41),$P(DVBFUF,U,29)=$E(X,42,44)
 S L=45 D RON
 Q
