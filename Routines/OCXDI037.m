OCXDI037 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXDIAG
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXDIAG",$J,$O(^TMP("OCXDIAG",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXDI038
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^RADIOLOGY ORDER CANCELLED
 ;;R^"860.2:","860.21:2",.01,"E"
 ;;D^DISCONTINUED
 ;;R^"860.2:","860.21:2",1,"E"
 ;;D^RADIOLOGY ORDER DISCONTINUED
 ;;R^"860.2:","860.21:3",.01,"E"
 ;;D^ON HOLD
 ;;R^"860.2:","860.21:3",1,"E"
 ;;D^RADIOLOGY ORDER PUT ON-HOLD
 ;;R^"860.2:","860.21:4",.01,"E"
 ;;D^CANCELED BY NON-ORIG ORDERER
 ;;R^"860.2:","860.21:4",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:4",1,"E"
 ;;D^CANCELED BY NON-ORIG ORDERING PROVIDER
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^CANCELLED AND CANCELED BY NON-ORIG ORDERER
 ;;R^"860.2:","860.22:1",3,"E"
 ;;D^IMAGING REQUEST CANCEL/HELD
 ;;R^"860.2:","860.22:1",5,"E"
 ;;D^Imaging request canceled: |ORDER TEXT (51 CHARS)|
 ;;R^"860.2:","860.22:2",.01,"E"
 ;;D^2
 ;;R^"860.2:","860.22:2",1,"E"
 ;;D^ON HOLD AND CANCELED BY NON-ORIG ORDERER
 ;;R^"860.2:","860.22:2",3,"E"
 ;;D^IMAGING REQUEST CANCEL/HELD
 ;;R^"860.2:","860.22:2",5,"E"
 ;;D^Imaging request held: |ORDER TEXT (51 CHARS)|
 ;;R^"860.2:","860.22:3",.01,"E"
 ;;D^3
 ;;R^"860.2:","860.22:3",1,"E"
 ;;D^DISCONTINUED AND CANCELED BY NON-ORIG ORDERER
 ;;R^"860.2:","860.22:3",3,"E"
 ;;D^IMAGING REQUEST CANCEL/HELD
 ;;R^"860.2:","860.22:3",5,"E"
 ;;D^Imaging request discontinued: |ORDER TEXT (51 CHARS)|
 ;;EOR^
 ;;KEY^860.2:^SERVICE ORDER REQUIRES CHART SIGNATURE
 ;;R^"860.2:",.01,"E"
 ;;D^SERVICE ORDER REQUIRES CHART SIGNATURE
 ;;R^"860.2:","860.21:1",.01,"E"
 ;;D^SERVICE
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^SERVICE ORDER REQUIRES CHART SIGNATURE
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^SERVICE
 ;;R^"860.2:","860.22:1",3,"E"
 ;;D^SERVICE ORDER REQ CHART SIGN
 ;;R^"860.2:","860.22:1",5,"E"
 ;;D^Service order - requires chart signature.
 ;;EOR^
 ;;KEY^860.2:^STAT RESULTS AVAILABLE
 ;;R^"860.2:",.01,"E"
 ;;D^STAT RESULTS AVAILABLE
 ;;R^"860.2:","860.21:1",.01,"E"
 ;;D^STAT IMAGING RESULT
 ;;R^"860.2:","860.21:1",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^STAT IMAGING RESULT
 ;;R^"860.2:","860.21:2",.01,"E"
 ;;D^STAT LAB RESULT
 ;;R^"860.2:","860.21:2",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:2",1,"E"
 ;;D^STAT LAB RESULT
 ;;R^"860.2:","860.21:3",.01,"E"
 ;;D^STAT CONSULT RESULT
 ;;R^"860.2:","860.21:3",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:3",1,"E"
 ;;D^STAT CONSULT RESULT
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^STAT LAB RESULT
 ;;R^"860.2:","860.22:1",3,"E"
 ;;D^STAT RESULTS
 ;;R^"860.2:","860.22:1",5,"E"
 ;;D^STAT lab results: [|ORDERABLE ITEM NAME|]
 ;;R^"860.2:","860.22:2",.01,"E"
 ;;D^2
 ;;R^"860.2:","860.22:2",1,"E"
 ;;D^STAT IMAGING RESULT
 ;;R^"860.2:","860.22:2",3,"E"
 ;;D^STAT RESULTS
 ;;R^"860.2:","860.22:2",5,"E"
 ;;D^STAT imaging results: |ORDERABLE ITEM LOCAL TEXT|
 ;;R^"860.2:","860.22:3",.01,"E"
 ;;D^3
 ;;R^"860.2:","860.22:3",1,"E"
 ;;D^STAT CONSULT RESULT
 ;;R^"860.2:","860.22:3",3,"E"
 ;;D^STAT RESULTS
 ;;R^"860.2:","860.22:3",5,"E"
 ;;D^STAT consult results: |ORDERABLE ITEM LOCAL TEXT|
 ;;EOR^
 ;;KEY^860.2:^PATIENT DISCHARGE
 ;;R^"860.2:",.01,"E"
 ;;D^PATIENT DISCHARGE
 ;;R^"860.2:","860.21:1",.01,"E"
 ;;D^DISCHARGE
 ;;R^"860.2:","860.21:1",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^PATIENT DISCHARGE
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^DISCHARGE
 ;;R^"860.2:","860.22:1",3,"E"
 ;;D^DISCHARGE
 ;;R^"860.2:","860.22:1",5,"E"
 ;;D^Discharged on |PATIENT MOVEMENT DATE CURRENT|
 ;;EOR^
 ;;KEY^860.2:^ORDER REQUIRES CO-SIGNATURE
 ;;R^"860.2:",.01,"E"
 ;;D^ORDER REQUIRES CO-SIGNATURE
 ;;R^"860.2:","860.21:1",.01,"E"
 ;;D^COSIG
 ;;R^"860.2:","860.21:1",1,"E"
 ;;D^ORDER REQUIRES CO-SIGNATURE
 ;;R^"860.2:","860.22:1",.01,"E"
 ;;D^1
 ;;R^"860.2:","860.22:1",1,"E"
 ;;D^COSIG
 ;;R^"860.2:","860.22:1",3,"E"
 ;;D^ORDER REQUIRES CO-SIGNATURE
 ;;R^"860.2:","860.22:1",5,"E"
 ;;D^Order requires a co-signature
 ;;EOR^
 ;;KEY^860.2:^ORDERER FLAGGED RESULTS AVAILABLE
 ;;R^"860.2:",.01,"E"
 ;;D^ORDERER FLAGGED RESULTS AVAILABLE
 ;;R^"860.2:","860.21:3",.01,"E"
 ;;D^ORDER FLAGGED FOR RESULTS
 ;;R^"860.2:","860.21:3",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:3",1,"E"
 ;;D^ORDER FLAGGED FOR RESULTS
 ;;R^"860.2:","860.21:4",.01,"E"
 ;;D^LAB RESULT
 ;;R^"860.2:","860.21:4",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:4",1,"E"
 ;;D^HL7 FINAL LAB RESULT
 ;;R^"860.2:","860.21:6",.01,"E"
 ;;D^IMAGING RESULT
 ;;R^"860.2:","860.21:6",.02,"E"
 ;;D^SIMPLE DEFINITION
 ;;R^"860.2:","860.21:6",1,"E"
 ;;D^HL7 FINAL IMAGING RESULT
 ;;R^"860.2:","860.21:7",.01,"E"
 ;;D^CONSULT RESULT
 ;;R^"860.2:","860.21:7",.02,"E"
 ;1;
 ;