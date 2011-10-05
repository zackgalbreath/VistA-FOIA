LEXILGU ; ISL Save/Restore User Defaults           ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 Q
SD ; Save User Defaults from ^GMPT
 Q:'$D(^GMPT(757.2))
 K ^TMP("LEXDEF",757.01) N LEXDA,LEXN,LEXD,LEXTMP,LEXC,LEXQ
 S (LEXTMP,LEXDA)=0 F  S LEXDA=$O(^GMPT(757.2,LEXDA)) Q:+LEXDA=0  D
 . Q:'$D(^GMPT(757.2,LEXDA,200))  S LEXQ="^GMPT(757.2,"_LEXDA_",200)",LEXC="^GMPT(757.2,"_LEXDA_",200"
 . F  S LEXQ=$Q(@LEXQ) Q:LEXQ'[LEXC  D
 . . S LEXTMP=LEXTMP+1
 . . S LEXN=LEXQ,LEXD=@LEXQ
 . . S LEXN=$$SW("^GMPT(","^LEXT(",LEXN),LEXN=$$SW("GMP","LEX",LEXN)
 . . S LEXD=$$SW("^GMPTU","^LEXU",LEXD),LEXD=$$SW("^GMPT","^LEXT",LEXD),LEXD=$$SW("GMP","LEX",LEXD)
 . . S ^TMP("LEXDEF",757.01,LEXTMP,0)=LEXN,^TMP("LEXDEF",757.01,LEXTMP,1)=LEXD
 S LEXQ="^GMPT(757.2,""AUD"")",LEXC="^GMPT(757.2,""AUD"""
 F  S LEXQ=$Q(@LEXQ) Q:LEXQ'[LEXC  D
 . S LEXTMP=LEXTMP+1
 . S LEXN=LEXQ,LEXD=@LEXQ
 . S LEXN=$$SW("^GMPT(","^LEXT(",LEXN),LEXN=$$SW("GMP","LEX",LEXN)
 . S LEXD=$$SW("^GMPTU","^LEXU",LEXD),LEXD=$$SW("^GMPT","^LEXT",LEXD),LEXD=$$SW("GMP","LEX",LEXD)
 . S ^TMP("LEXDEF",757.01,LEXTMP,0)=LEXN,^TMP("LEXDEF",757.01,LEXTMP,1)=LEXD
 Q
RD ; Restore User Defaults into ^LEXT
 Q:'$D(^TMP("LEXDEF",757.01))  N LEXN,LEXD,LEXC S LEXC=0
 F  S LEXC=$O(^TMP("LEXDEF",757.01,LEXC)) Q:+LEXC=0  D
 . S LEXN=$G(^TMP("LEXDEF",757.01,LEXC,0)) Q:LEXN=""
 . S LEXD=$G(^TMP("LEXDEF",757.01,LEXC,1)),@LEXN=LEXD
 Q
DF ; Delete user defaults in temporary storage - ^TMP("LEXDEF")
 K ^TMP("LEXDEF",757.01) Q
RI ; Re-index ^LEXT
 Q:$D(^TMP("LEXIDX","STOP"))  N DA S DA=999999999 Q:+($O(^LEXT(757.2,DA)))'=0
 F  S DA=$O(^LEXT(757.2,DA)) Q:DA=""!($D(^TMP("LEXIDX","STOP")))  K ^LEXT(757.2,DA)
 N DA,LEXP3,LEXP4 S (LEXP3,LEXP4,DA)=0 F  S DA=$O(^LEXT(757.2,DA)) Q:+DA=0!($D(^TMP("LEXIDX","STOP")))  S LEXP3=DA,LEXP4=LEXP4+1,(DIK,DIC)="^LEXT(757.2," D IX1^DIK
 I LEXP3>0,LEXP4>0,$D(^LEXT(757.2,0)) S $P(^LEXT(757.2,0),"^",3)=LEXP3,$P(^LEXT(757.2,0),"^",4)=LEXP4
 Q
SW(LEXF,LEXT,LEXS) ; Switch "GMPT" with "LEX"
 Q:'$L($G(LEXF)) "" Q:'$L($G(LEXT)) "" Q:'$L($G(LEXS)) ""
 F  Q:LEXS'[LEXF  S LEXS=$P(LEXS,LEXF,1)_LEXT_$P(LEXS,LEXF,2)
 Q LEXS