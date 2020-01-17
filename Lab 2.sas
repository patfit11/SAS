/* Load the data */
libname ads534 "/folders/myfolders/ADS534/data";
	data work.cf2;
	set ads534.cf2;
	run;


/* Creates a frequency table for FEV2 = 1, 2, 3 */
proc freq data=work.cf2;
	table fev2;
	run;
	

/* Creates new columns for the dummy variables */
data cf2two;
	set work.cf2;
	if fev2=2 then I2=1; else I2=0;
	if fev2=3 then I3=1; else I3=0;
	run;
	
	
/* Runs the mlr model for pemax based on the values FEV2 takes on 
(2 and 3 - 1 is beta0) */
proc reg data=cf2two;
	model pemax=I2 I3/clb;
	run;


/* CONFOUNDING by looking at the associations between 3 variables directly
Pearson Correlation for two continuous variables */
proc corr data=work.cf2;
	var age;
	with pemax;
	run;
	
	
/* ANOVA for categorical (FEV2 1/2/3) and continuous variables (pemax) */
proc anova data=work.cf2;
	class fev2;
	model pemax=fev2;
	run;	
proc anova data=work.cf2;
	class fev2;
	model age=fev2;
	run;
	
	
/* CONFOUNDING by controlling the regression 
Simple linear regression - first for age */
proc reg data=work.cf2;
	model pemax=age;
	run;
	
	
/* Now control for FEV2 using the dummy variables I2 / I3 created 
earlier in the new data cf2two */
proc reg data=work.cf2two;
	model pemax=age I2 I3;
	run;


/* INTERACTIONS need to create the interaction terms */
data cf2too;
	set cf2two;
	age_fev2_2=age*I2;
	age_fev2_3=age*I3;
	run;
	
/* fit the model using the new interaction terms along with the 
dummy terms we created earlier for one mega mlr */
proc reg data=cf2too;
	model pemax=age I2 I3 age_fev2_2 age_fev2_3/clb;
	run;
	
	
/* Create graph */
proc sgplot data=cf2too;
	scatter X = age scatter Y = pemax;
	run;
	
ods noproctitle;
ods graphics / imagemap=on;

proc reg data=ADS534.CF2 alpha=0.05 plots(only)=(diagnostics residuals 
		observedbypredicted);
	model PEmax=Age FEV2 /;
	run;
quit;
	