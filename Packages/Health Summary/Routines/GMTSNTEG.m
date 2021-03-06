GMTSNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;OCT 20, 1995@15:13:16
 ;;2.7;Health Summary;;Oct 20, 1995
 ;;7.2;OCT 20, 1995@15:13:16
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 G CONT^GMTSNTE0
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
GMTS ;;9747615
GMTS1 ;;9107723
GMTS2 ;;1686893
GMTSADH ;;7009924
GMTSADH1 ;;9118153
GMTSADH2 ;;8921291
GMTSADH3 ;;4175388
GMTSADH4 ;;2108172
GMTSADHC ;;7616551
GMTSADOR ;;5770178
GMTSALG ;;13299334
GMTSALGB ;;3649701
GMTSAMIE ;;2215141
GMTSCI ;;980795
GMTSCM ;;6771561
GMTSCW ;;8466205
GMTSDA ;;7935436
GMTSDCB ;;3376310
GMTSDD ;;5832737
GMTSDEM ;;8355003
GMTSDEMB ;;1645478
GMTSDGA ;;3278741
GMTSDGA1 ;;7480178
GMTSDGA2 ;;5406373
GMTSDGC1 ;;5335387
GMTSDGC2 ;;3280399
GMTSDGCH ;;6109698
GMTSDGD ;;2236947
GMTSDGH ;;2898086
GMTSDGP ;;5958742
GMTSDS ;;2014917
GMTSDSB ;;1887589
GMTSDVR ;;9357098
GMTSENV ;;527430
GMTSFH ;;6355772
GMTSI001 ;;6797667
GMTSI002 ;;8625906
GMTSI003 ;;7915035
GMTSI004 ;;7496079
GMTSI005 ;;9611811
GMTSI006 ;;9190966
GMTSI007 ;;7703599
GMTSI008 ;;4005876
GMTSI009 ;;3932193
GMTSI00A ;;827350
GMTSI00B ;;8455149
GMTSI00C ;;7584757
GMTSI00D ;;8910779
GMTSI00E ;;7448609
GMTSI00F ;;2867454
GMTSI00G ;;8852473
GMTSI00H ;;8717091
GMTSI00I ;;8773516
GMTSI00J ;;9224995
GMTSI00K ;;9276724
GMTSI00L ;;8906270
GMTSI00M ;;8948291
GMTSI00N ;;8903831
GMTSI00O ;;9109697
GMTSI00P ;;8788001
GMTSI00Q ;;9144600
GMTSI00R ;;8661231
GMTSI00S ;;9040355
GMTSI00T ;;8440721
GMTSI00U ;;8849266
GMTSI00V ;;8597654
GMTSI00W ;;8347201
GMTSI00X ;;8589121
GMTSI00Y ;;2513711
GMTSI00Z ;;951613
GMTSI010 ;;12236555
GMTSI011 ;;10099099
GMTSI012 ;;10044917
GMTSI013 ;;6048930
GMTSI014 ;;6222248
GMTSI015 ;;6848123
GMTSI016 ;;8673195
GMTSI017 ;;7578064
GMTSI018 ;;6048832
GMTSI019 ;;5845546
GMTSI01A ;;7616684
GMTSI01B ;;7997413
GMTSI01C ;;4992646
GMTSI01D ;;899861
GMTSINI1 ;;4982983
GMTSINI2 ;;5232640
GMTSINI3 ;;16807836
GMTSINI4 ;;3357812
GMTSINI5 ;;773825
GMTSINIS ;;2215261
GMTSINIT ;;10511864
GMTSLOAD ;;5796287
GMTSLRA ;;6876199
GMTSLRAE ;;11147933
GMTSLRB ;;2250319
GMTSLRBE ;;3672773
GMTSLRC ;;3788772
GMTSLRCE ;;5397241
GMTSLRCP ;;12992921
GMTSLREE ;;6175432
GMTSLREM ;;5357355
GMTSLRM ;;10576209
GMTSLRM1 ;;5092747
GMTSLRMB ;;8141523
GMTSLRME ;;7612887
GMTSLRMX ;;7993355
GMTSLROB ;;1646167
GMTSLROE ;;6516628
GMTSLROS ;;2358998
GMTSLRPE ;;6517490
GMTSLRS ;;4721162
GMTSLRS7 ;;7478778
GMTSLRSC ;;7505823
GMTSLRSE ;;3321038
GMTSLRT ;;2843052
GMTSLRTE ;;1320704
GMTSLTR ;;2903951
GMTSLTR2 ;;3282162
GMTSMCMA ;;7527516
GMTSMCPZ ;;3705188
GMTSMCZZ ;;5276229
GMTSMHPE ;;8497501
GMTSO001 ;;8057336
GMTSO002 ;;6065150
GMTSO003 ;;7512952
GMTSO004 ;;7684644
GMTSO005 ;;7812945
GMTSO006 ;;7948804
GMTSO007 ;;7635764
GMTSO008 ;;7443333
GMTSO009 ;;7739191
GMTSO010 ;;7582026
GMTSO011 ;;8030504
GMTSO012 ;;8409618
GMTSO013 ;;7775470
GMTSO014 ;;7954689
GMTSO015 ;;7423432
GMTSO016 ;;7911113
GMTSO017 ;;7145833
GMTSO018 ;;7647663
GMTSO019 ;;7562703
GMTSO020 ;;7805175
GMTSO021 ;;7281432
GMTSO022 ;;7825234
GMTSO023 ;;7784074
GMTSO024 ;;725714
GMTSONI1 ;;1703362
GMTSONI2 ;;82866
GMTSONI3 ;;10576628
GMTSONIT ;;935085
GMTSORC ;;4886475
GMTSPCD ;;3405698
GMTSPD ;;5306590
GMTSPD2 ;;1434592
GMTSPDX ;;6721830
