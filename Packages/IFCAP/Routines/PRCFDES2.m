PRCFDES2 ;WISC/LEM-ESIG MAINTENANCE ROUTINE ;1/19/93  1:05 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ROUTINE FOR MAINTAINING FIELD 62 (COMPLETED BY ELEC SIG), FILE 421.5
DECODE(LEVEL0) ;Extrinsic Function to return hashed electronic sig to readable form.
 ;returns "" if unsuccessful
 NEW RECORD2,RECORD21,VERSION,PERSON,SIG,CHECKSUM
 ;get record and check version
 S RECORD2=$G(^PRCF(421.5,LEVEL0,2)) I RECORD2="" QUIT ""
 S RECORD21=$G(^PRCF(421.5,LEVEL0,2.1))
 S VERSION=$P(RECORD21,"^",3)
 S PERSON=+$P(RECORD2,"^",11)
 I VERSION'="",VERSION'=1 Q ""
 S SIG=$P(RECORD2,"^",13)
D1 ;decode e signature for version 1
 S RECORD=$G(^PRCF(421.5,LEVEL0,0))
 S RECORD1=$G(^PRCF(421.5,LEVEL0,1))
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECORD,RECORD1))
 QUIT $$DECODE^PRCUESIG(SIG,PERSON,CHECKSUM)
ENCODE(LEVEL0,USERNUM,Y) ;Encode e signature for version 1 only
 ;Parameter passing entry point
 NEW SIGBLOCK,CHECKSUM,OLDUSER
 NEW RECORD,RECORD1,RECORD2,RECORD21
 ;get record
 S USERNUM=+USERNUM
 I USERNUM=0 S Y=-3 QUIT  ;-3 no user num available
 S SIGBLOCK=$P($G(^VA(200,USERNUM,20)),"^",2)
 I SIGBLOCK="" S Y=-2 QUIT  ;-2 no sigblock in file 200
 S RECORD=$G(^PRCF(421.5,LEVEL0,0))
 S RECORD1=$G(^PRCF(421.5,LEVEL0,1))
 S RECORD2=$G(^PRCF(421.5,LEVEL0,2))
 S RECORD21=$G(^PRCF(421.5,LEVEL0,2.1))
 I RECORD="" S Y=-1 QUIT  ;-1 no transaction record
 I $P(RECORD2,"^",13)'="" S Y=-4 QUIT  ;-4 cannot re-sign record
 S OLDUSER=+$P(RECORD2,"^",11)
 I OLDUSER=0 S $P(RECORD2,"^",11)=USERNUM
 I OLDUSER>0 S USERNUM=OLDUSER
 S:$P(RECORD21,"^",6)="" $P(RECORD21,"^",6)=$$NOW^PRCUESIG
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECORD,RECORD1))
 S $P(RECORD2,"^",13)=$$ENCODE^PRCUESIG(SIGBLOCK,USERNUM,CHECKSUM)
 S $P(RECORD21,"^",3,4)="1^"_$$SUM^PRCUESIG(SIGBLOCK)
 S ^PRCF(421.5,LEVEL0,2)=RECORD2
 S ^PRCF(421.5,LEVEL0,2.1)=RECORD21
 S Y=1 QUIT
REMOVE(LEVEL0) ;Entry point to remove e signature from record
 ;NOT an extrinsic function
 NEW RECORD2,RECORD21,I
 S RECORD2=$G(^PRCF(421.5,LEVEL0,2))
 S RECORD21=$G(^PRCF(421.5,LEVEL0,2.1))
 F I=11,13 S $P(RECORD2,"^",I)=""
 F I=4,6 S $P(RECORD21,"^",I)=""
 S ^PRCF(421.5,LEVEL0,2)=RECORD2
 S ^PRCF(421.5,LEVEL0,2.1)=RECORD21
 QUIT
VERIFY(LEVEL0)      ;extrinsic function to verify version 1 signature.  Returns 1 if valid, 0 if not valid
 NEW RECORD21,VERSION,SIGBLOCK
 ;get record variables
 S RECORD21=$G(^PRCF(421.5,LEVEL0,2.1))
 S VERSION=$P(RECORD21,"^",3),SIGBLOCK=$P(RECORD21,"^",4)
 I VERSION_SIGBLOCK="" QUIT 1
 QUIT ($$SUM^PRCUESIG($$DECODE(LEVEL0))=SIGBLOCK)
STRING(X,X1)          ;Build String of critical fields
 NEW RECORD,RECORD1
 Q $P(X,"^",1)_"^"_$P(X,"^",3)_"^"_$P(X,"^",4)_"^"_$P(X,"^",8)_"^"_$P(X,"^",15)_"^"_$P(X1,"^",3)
