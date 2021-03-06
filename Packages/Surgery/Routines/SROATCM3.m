SROATCM3 ;BIR/SJA - STUFF TRANMISSION IN ^TMP ;05/11/10
 ;;3.0; Surgery ;**125,135,153,164,166,174**;24 Jun 93;Build 8
 N SRDISP,NYUK S SRDISP="",NYUK=$P(SRRES(1),U,2),SRA(209.1)=$G(^SRF(SRTN,209.1)),SRA(207.1)=$G(^SRF(SRTN,207.1)),SRA(205)=$G(^SRF(SRTN,205)),SRA(208)=$G(^SRF(SRTN,208))
 I NYUK'="" D
 .S SRDISP=$S(NYUK="BOARDING HOUSE":16,NYUK="COMMUNITY HOSPITAL":6,NYUK="COMMUNITY NURSING HOME":8,NYUK="FOSTER HOME":14,NYUK="HALFWAY HOUSE":15,NYUK="HOME-BASED PRIMARY CARE (HBPC)":20,1:NYUK)
 .Q:SRDISP'=NYUK  S SRDISP=$S(NYUK="HOSPICE CARE":22,NYUK="MILITARY HOSPITAL":3,NYUK="NURSE CARE CONTD ANOTHER COMM ":10,NYUK="NURSING CARE CONT AT SAME NURS":9,NYUK="OTHER FEDERAL HOSPITAL":4,1:NYUK)
 .Q:SRDISP'=NYUK  S SRDISP=$S(NYUK="OTHER GOVERNMENT HOSPITAL":5,NYUK="OTHER PLACEMENT/UNKNOWN (NOT S":19,NYUK="PENAL INSTITUTION":17,NYUK="REFER MEDICARE HOME HEALTH CAR":25,NYUK="REFER OTHER AGENCY-PD HOME HEA":26,1:NYUK)
 .Q:SRDISP'=NYUK  S SRDISP=$S(NYUK="REFER VA-PD HOME/COMMUNITY HEA":24,NYUK="RESIDENTIAL HOTEL/RESIDENT (IE":18,NYUK="RESPITE CARE":23,NYUK="RETURN TO COMMUNITY-INDEPENDEN":1,NYUK="SPINAL CORD INJURY-VACO APPROV":21,1:NYUK)
 .Q:SRDISP'=NYUK  S SRDISP=$S(NYUK="STATE HOME":11,NYUK="STATE HOME":13,NYUK="VA DOMICILLARY":12,NYUK="VA MEDICAL CENTER":2,NYUK="VA NURSING HOME CARE UNIT (NHC":7,1:"")
 ;
LN26 S SHEMP=$E(SHEMP,1,11)_" 26"_$J(SRDISP,2)_$J($P(SRA(206),"^",13),2)_$J($P(SRA(206),"^",15),2)_$J("",2)_$J($P(SRA(207),"^",27),2)_$J($P(SRA(209),"^"),2)_$J($P(SRA(209),"^",2),2)
 S SHEMP=SHEMP_$J($P(SRA(209),"^",3),2)_$J($P(SRA(209),"^",4),2)_$J($P(SRA(209),"^",5),2)_$J($P(SRA(209),"^",6),3)_$J($P(SRA(209),"^",7),3)_$J($P(SRA(209),"^",8),3)_$J($P(SRA(209),"^",9),2)_$J($P(SRA(209),"^",10),2)
 S X=$P(SRA(206),"^",42),Y="" F I=1:1:5 S Y=Y_$P(X,",",I)
 S SHEMP=SHEMP_$J($P(SRA(209),"^",11),2)_$J(Y,5)
 S X=$P(SRA(209),"^",12) S:X="" X="N" S SHEMP=SHEMP_$J(X,2)
 ; CT Surgery Consult Date and cause for delay & Primary Cause for Delay
 S SHEMP=SHEMP_$J("",9)
 S ^TMP("SRA",$J,SRAMNUM,SRACNT,0)=SHEMP,SRACNT=SRACNT+1
LN27 ;Line #27 - Other Cardiac Procedures
 S SHEMP=$E(SHEMP,1,11)_" 27"_$TR($E($G(SRA(209.1)),1,65),",","^")
 S ^TMP("SRA",$J,SRAMNUM,SRACNT,0)=SHEMP,SRACNT=SRACNT+1
LN28 ;Lines 28 - New fields added in 2006 update
 S SHEMP=$E(SHEMP,1,11)_" 28"_$J($P(SRA(209),"^",13),2)_$J($P(SRA(209),"^",14),2)_$J($P(SRA(207.1),"^",2),2)_$J($P(SRA(201),"^",28),6)_$J($P(SRA(202.1),"^"),7)
 S SHEMP=SHEMP_$J($P(SRA(201),"^",29),5)_$J($P(SRA(202.1),"^",2),7)
 S ^TMP("SRA",$J,SRAMNUM,SRACNT,0)=SHEMP,SRACNT=SRACNT+1
 Q
