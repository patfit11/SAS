/* Load the data into SAS */
libname ads534 "/folders/myfolders/ADS534/data";
	data work.hersdata;
	set ads534.hersdata;
	run;

	
/* Exclude the missing data */
data hers;
	set work.hersdata;
	if ldl ~=. and bmi ~=. and age ~=.;
	run;

	
/* Question 1.1 */
/* Determine the whether BMI or Age are useful for explaining 
variability of LDL based on the pre-defined model */
proc reg data=work.hers;
	model ldl = bmi age;
	run;





/* Question 1.2 
/* We've determined at least one of BMI or Age is useful for explaining 
the variability in LDL.  Now we will determine which of the two (or if both) 
are useful.  First we will do this via the t-test */
proc reg data=work.hers;
	model ldl = bmi age;
	run;
	
/* Now we will use the partial F test and compare SSR from the linear model 
with BMI and the linear model without BMI.
First with BMI */
proc reg data=work.hers;
	model ldl = bmi age/clb;
	run;
	
/* Now without BMI */
proc reg data=work.hers;
	model ldl = age/clb;
	run;
	
/* Now we will use the partial F test with the 'test' statement
This is a streamlined version of what was just done */
proc reg data=work.hers;
	model ldl = bmi age;
	test1: test bmi;
	run;





/* Question 1.3
First create the interaction term for Statins*BMI */
data hers1;
	set hers;
	interaction=bmi*statins;
	run;

/* Create the full model (including the interaction term) */
proc reg data=work.hers1;
	model ldl = statins bmi interaction age smoking drinkany nonwhite;
	run;
	
/* Create the reduced model without BMI or BMI*Statins */
proc reg data=work.hers1;
	model ldl = statins age smoking drinkany nonwhite;
	run;
	
/* Now we will use the partial F test with the 'test' statement
Test for our null: beta2 = beta3 = 0 vs alternative: beta2, beta3 not equal to 0 
given the other predictors in the model */
proc reg data=work.hers1;
	model ldl = statins bmi interaction age smoking drinkany nonwhite;
	test2: test bmi, interaction;
	run;
	
/* Now we will use the 'test' statement to determine whether BMI is 
significantly associated with LDL for people receiving Statin
Test for our null: beta2 + beta3 = 0 vs alternative: beta2 + beta3 not equal to 0 
given the other predictors in the model */
proc reg data=work.hers1;
	model ldl = statins bmi interaction age smoking drinkany nonwhite;
	test3: test bmi + interaction;
	run;
