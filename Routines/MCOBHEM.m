MCOBHEM ; GENERATED FROM 'MCARHEMBRPR' PRINT TEMPLATE (#1030) ; 06/25/01 ; (FILE 694, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(1030,"DXS")
 S I(0)="^MCAR(694,",J(0)=694
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE: "
 X DXS(1,9.4) S X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):DIP(7),DIP(8):X) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INDICATION(S) FOR PERFORMANCE: "
 S I(1)=12,J(1)=694.057 F D1=0:0 Q:$O(^MCAR(694,D0,12,D1))'>0  X:$D(DSC(694.057)) DSC(694.057) S D1=$O(^(D1)) Q:D1'>0  D:$X>37 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(694,D0,12,D1,0)) D T Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(694.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,100)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROVISIONAL DIAGNOSIS(ES):"
 S I(1)=10,J(1)=694.038 F D1=0:0 Q:$O(^MCAR(694,D0,10,D1))'>0  X:$D(DSC(694.038)) DSC(694.038) S D1=$O(^(D1)) Q:D1'>0  D:$X>32 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(694,D0,10,D1,0)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=79 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
B1R ;
 S X=$G(^MCAR(694,D0,1)) D N:$X>6 Q:'DN  S DIWL=7,DIWR=76 S Y=$P(X,U,2) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "CELLULARITY: "
 S X=$G(^MCAR(694,D0,1)) S Y=$P(X,U,3) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>4 Q:'DN  W ?4 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(3,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "FINAL DIAGNOSIS(ES): "
 S I(1)=8,J(1)=694.035 F D1=0:0 Q:$O(^MCAR(694,D0,8,D1))'>0  X:$D(DSC(694.035)) DSC(694.035) S D1=$O(^(D1)) Q:D1'>0  D:$X>27 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(694,D0,8,D1,0)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=79 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
C1R ;
 S I(1)=3,J(1)=694.041 F D1=0:0 Q:$O(^MCAR(694,D0,3,D1))'>0  S D1=$O(^(D1)) D:$X>81 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(694,D0,3,D1,0)) S DIWL=7,DIWR=76 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(694,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 D N:$X>9 Q:'DN  S DIWL=10,DIWR=79 S Y=$P(X,U,2) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?9 S MCFILE=694 D DISP^MCMAG K DIP K:DN Y
 W ?20 K MCFILE K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!