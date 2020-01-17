****Load the data into SAS
libname ads534 "/folders/myfolders/ADS534/data";
	data work.patsat;
	set ads534.patsat;
	run;
	
libname ads534 "/folders/myfolders/ADS534/data";
	data work.pollution;
	set ads534.pollution;
	run;
	
	
/* Create new interaction variable */
data newpollution;
	set work.pollution;
	interaction = caps*so2;
	run;

/* Runs the mlr model for nn based on the independent variables 
caps, so2, and the interaction there-between */
proc reg data=newpollution;
	model nn=caps so2 interaction;
	run;

	
/* Fit model for CAP individually and then for both of the 
independent variables together */
/* first, caps */
proc reg data=work.pollution;
	model nn=caps;
	run;
/* second cap and so2 */
proc reg data=work.pollution;
	model nn=caps so2;
	run;
	

/* Two-Sample t-test for healthy animals (no s02) */
proc ttest data=work.pollution;
	freq caps;
	var nn;
	run;
/* Two-Sample t-test for animals exposed to bronchitis */
proc ttest data=work.pollution;
	freq so2;
	var nn;
	run;
	
/* Chi-Square test two categorical variables beta-1 and beta-2 */
proc freq data=work.pollution;
	table caps*so2 / chisq;
	run;
	
	
	
/* Fit model for interaction effect for beta-1 + beta-3 = 0 */
proc reg data=newpollution;
	model nn = caps so2 interaction;
	test1: test caps+interaction=0;
	run;
	
	
	
/* fitting the regression model for satisfaction(Y) based on 
age(X1), severity(X2), and anxiety(X3) */
proc reg data=patsat;
	model y=x1 x2 x3/;
	run;
	
	
/* 95% confidence interval for satisfaction(Y) based on the 
estimates X1=35, X2=45, and X3=2.2 */
data patsat1;
	input y x1 x2 x3;
	datalines;
	. 35 45 2.2
	;
	
data patsat2;
	set patsat1 work.patsat;
	run;
	
proc print data=patsat2;
run;
	
proc reg data=patsat2;
	model y=x1 x2 x3/clm;
	run;
	
