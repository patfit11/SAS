**********************************************************	
**** Load the data into SAS
**********************************************************;

libname ads534 "/folders/myfolders/ADS534/data";
	data work.lowbwtone;
	set ads534.lowbwtone;
	run;
	
	
**********************************************************	
****1(b) Fit the Logistic Regression Model for apgar5
**********************************************************;
proc logistic data=lowbwtone;
	model grmhem = apgar5;
	run;
	
proc logistic data=lowbwtone descending;
	model grmhem = apgar5;
	run;
	
proc logistic data=lowbwtone ;
	model grmhem (event='1') = apgar5;
	run;
	
data lowbwtone;
	set lowbwtone;
	beta1=exp(-0.2496);
	run;
proc print data=lowbwtone (obs=1); var beta1; run;
	

**********************************************************	
****1(c) Predicted probability of hemorrhage for apgar5 = 3
**********************************************************;
data lowbwtone;
	set lowbwtone;
	prob=exp(-0.3037-0.2496*3);
	run;
proc print data=lowbwtone (obs=1); var prob; run;


**********************************************************	
****1(e) Estimated odds ratio of suffering hemorrhage associated with 3 units increase in apgar5
**********************************************************;
data lowbwtone;
	set lowbwtone;
	beta1=exp(3*-0.2496);
	run;
proc print data=lowbwtone (obs=1); var beta1; run;


**********************************************************	
****1(g) Fit the Logistic Regression Model for tox
**********************************************************;
proc logistic data=lowbwtone;
	model grmhem = tox;
	run;
	
proc logistic data=lowbwtone descending;
	model grmhem = tox;
	run;
	
proc logistic data=lowbwtone ;
	model grmhem (event='1') = tox;
	run;
	
data lowbwtone;
	set lowbwtone;
	beta2=exp(-1.4604);
	run;
proc print data=lowbwtone (obs=1); var beta2; run;


**********************************************************	
****1(h) Regression model where tox = 1 (i.e. tox is present)
**********************************************************;
data lowbwtone;
	set lowbwtone;
	prob=exp(-1.5353-1.4604);
	run;
proc print data=lowbwtone (obs=1); var prob; run;







**********************************************************	
****2(a/b) Fit the Logistic Regression Model for (null) apgar = 0
**********************************************************;	
proc logistic data=lowbwtone;
	model grmhem (event="1") = apgar5/clparm=wald clodds=wald;
	run;
	
	
**********************************************************	
****2(c) Fit the Logistic Regression Model for 1 unit increase in apgar5
**********************************************************;	
proc genmod data=lowbwtone descending;
	class tox;
	model grmhem = tox / error=bin link=logit type3;
	run;
	
	
	
	
	
**********************************************************	
**** Load the data into SAS
**********************************************************;

libname ads534 "/folders/myfolders/ADS534/data";
	data work.icu;
	set ads534.icu;
	run;
	

**********************************************************	
**** Set up dummy variables
**********************************************************;
data icu_2;
	set work.icu;
	if race=2 then race2=1;
	else race2=0;
	if race=3 then race3=1;
	else race3=0;
	run;


**********************************************************	
****3(a) Fit the Logistic Regression Model
**********************************************************;
proc logistic data=icu_2;
	model sta (event='1') = crn race2 race3;
	run;
		

**********************************************************	
****3(b) Fit the Logistic Regression Model
**********************************************************;
proc logistic data=icu_2;
	model sta (event='1') = age crn sex race2 race3;
	run;


**********************************************************	
****3(d) Use above equation, see R code
**********************************************************;


**********************************************************	
****3(e/f) Fit the Logistic Regression Model with interaction term
**********************************************************;
proc logistic data=icu_2;
	model sta (event='1') = age sex crn race2 race3 crn*sex;
	oddsratio "OR1" crn / at(sex=1);
	oddsratio "OR2" crn / at(sex=0);
	run;
	
	
**********************************************************	
****3(h) Fit the Logistic Regression Model for 1 unit increase in apgar5
**********************************************************;	
proc genmod data=icu_2 descending;
	class race2 race3;
	model sta = age sex crn race2 race3 crn*sex / error=bin link=logit type3;
	contrast "test1" sex 1 crn*sex 1;
	run;