OCXDI00P ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI00Q
 ;
 Q
 ;
DATA ;
 ;
 ;;RSUM^11222.211^32012.301^2148.71^54864.391^11205.211^33105.301^11222.211^19637.231^2148.71^12929.201^42663.361^14607.201^11194.211^4884.111^9276.191^3292.91^11239.211^7628.141^88849.551^19637.231^88900.551
 ;;RSUM^33105.301^83735.531^20903.231^113778.621^32012.301^113836.621^30755.291^108006.601^20297.231^2148.71^25954.271^11194.211^12109.181^11239.211^7628.141^88849.551^19637.231^88900.551^33105.301^83735.531
 ;;RSUM^29464.271^2148.71^20446.241^11194.211^8392.151^11239.211^7628.141^88849.551^19637.231^88900.551^33105.301^83735.531^24939.251^2148.71^22384.251^11194.211^9610.161^11239.211^5796.121^78614.521^15217.201
 ;;RSUM^78662.521^15217.201^73782.501^9792.161^113778.621^32012.301^113836.621^26266.271^108006.601^28455.271^2148.71^34835.311^11194.211^18218.221^9276.191^8349.151^11239.211^7628.141^78614.521^15217.201
 ;;RSUM^78662.521^15217.201^73782.501^33332.301^2148.71^38095.341^11194.211^20911.251^9276.191^7931.151^11239.211^5675.121^78614.521^15217.201^78662.521^15217.201^73782.501^42325.331^2148.71^12912.201^37223.331
 ;;RSUM^74241.461^11183.211^48456.371^11200.211^19637.231^25177.321^1363.61^22225.301^8392.151^22251.301^10806.171^22277.301^4873.111^25200.321^1369.61^22248.301^4884.111^22274.301^533.41^150.21
 ;;RND^OCXRU009^APR 30,1999 at 15:07
 ;;RTN^OCXRU00A^APR 30,1999 at 15:07
 ;;RSUM^150.21^324.31^150.21^8084.141^150.21^150.21^24215.261^190137.791^105365.591^150.21^150.21^150.21^194.21^150.21^1224.61^150.21^10115.161^22300.301^2130.71^25223.321^1375.61^22271.301^12109.181^22297.301
 ;;RSUM^6872.131^22323.301^7831.141^25246.321^1381.61^22294.301^20911.251^22320.301^10955.171^2148.71^85914.491^11183.211^57897.401^11200.211^19637.231^25177.321^1363.61^22225.301^8392.151^22251.301^10806.171
 ;;RSUM^22277.301^4873.111^25200.321^1369.61^22248.301^4884.111^22274.301^10115.161^22300.301^2130.71^25223.321^1375.61^22271.301^12109.181^22297.301^6872.131^22323.301^7831.141^25246.321^1381.61^22294.301
 ;;RSUM^20911.251^22320.301^11840.181^2148.71^12895.201^30370.301^19609.231^11172.211^7831.141^25146.321^6362.131^25174.321^18456.221^22194.301^48456.371^25169.321^9851.161^25197.321^18456.221^22217.301^57897.401
 ;;RSUM^25167.321^1363.61^22215.301^6362.131^22241.301^34841.301^22345.301^121270.541^25190.321^1369.61^22238.301^9851.161^22264.301^34841.301^22368.301^485346.1051^2148.71^12878.201^533.41^150.21
 ;;RND^OCXRU00A^APR 30,1999 at 15:07
 ;;RTN^OCXRU00B^APR 30,1999 at 15:30
 ;;RSUM^150.21^324.31^150.21^8084.141^150.21^150.21^24215.261^190137.791^105365.591^150.21^5292.121^150.21^194.21^150.21^1224.61^150.21^25246.321^1381.61^22294.301^35740.321^22320.301^7464.141^22346.301^2109.81
 ;;RSUM^25269.321^1387.61^22317.301^29626.301^22343.301^10955.171^2148.71^36255.341^11183.211^19272.251^11200.211^19637.231^25177.321^1363.61^22225.301^35740.321^22251.301^10827.171^22277.301^3184.101^25200.321
 ;;RSUM^1369.61^22248.301^29626.301^22274.301^10955.171^2148.71^48988.371^11183.211^28603.281^11200.211^19637.231^25177.321^1363.61^22225.301^8392.151^22251.301^10806.171^22277.301^4873.111^25200.321^1369.61
 ;;RSUM^22248.301^4884.111^22274.301^10115.161^22300.301^2130.71^25269.321^1387.61^22317.301^11940.181^22343.301^10955.171^2148.71^58678.421^11183.211^36340.331^11200.211^19637.231^25292.321^1393.61^22340.301
 ;;RSUM^29626.301^22366.301^11840.181^2148.71^58946.421^11183.211^36518.331^11200.211^19637.231^25246.321^1381.61^22294.301^29774.301^22320.301^11840.181^2148.71^34322.331^11183.211^17843.241^11200.211^19637.231
 ;;RSUM^25246.321^1381.61^22294.301^35888.321^22320.301^7464.141^22346.301^2081.81^25269.321^1387.61^22317.301^29774.301^22343.301^10955.171^2148.71^49739.421^11183.211^29597.331^11200.211^19637.231^25246.321
 ;;RSUM^1381.61^22294.301^35888.321^22320.301^10827.171^22346.301^3230.101^25269.321^1387.61^22317.301^35888.321^22343.301^7464.141^22369.301^2121.81^25292.321^1393.61^22340.301^29774.301^22366.301^10955.171
 ;;RSUM^2148.71^36557.341^11183.211^19466.251^11200.211^19637.231^25177.321^1363.61^22225.301^35888.321^22251.301^10827.171^22277.301^3196.101^25200.321^1369.61^22248.301^29774.301^22274.301^10955.171^2148.71
 ;1;
 ;