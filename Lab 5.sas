**********************************************************	
**** Load the data into SAS
**********************************************************;

libname ads534 "/folders/myfolders/ADS534/data";
	data work.hersdataone;
	set ads534.hersdataone;
	run;
	
*Exclude the missing data;
data hers;
	set work.hersdataone;
	if ldl ~=. and bmi ~=. and age ~=.;
	run;


**********************************************************	
**** 1.1	Model selection using adjusted-Rsquared
**********************************************************;
*First create the interaction term for Statins*BMI;
data hers1;
	set hers;
	int=bmi*statins;
	run;

*Create the full model (including the interaction term);
proc reg data=work.hers1;
	model ldl = bmi age statins smoking drinkany nonwhite diabetes physact int;
	run;


proc reg data=work.hers1  outest=var_select_aic;
	model ldl = bmi age statins smoking drinkany nonwhite diabetes physact int/selection=adjrsq;
	run;



**********************************************************	
**** 1.2	Model selection using AIC
**********************************************************;

proc reg data=work.hers1 outest=var_select_aic;
	model ldl = bmi age statins smoking drinkany nonwhite diabetes physact int/selection=adjrsq aic;
	run;
	
*check the variable selection results to find the variable name for AIC;
proc contents data=var_select_aic;
	run;
	
*sort the variable selection results by AIC (from the lowest to the highest);
proc sort data=var_select_aic;
	by _AIC_;
	run;
	
*print the results -- the first row is the model with the lowest AIC;
proc print data=var_select_aic;
	run;



**********************************************************	
**** 1.3	Forward selection
**********************************************************;

proc reg data=hers1;
	model ldl = bmi age statins smoking drinkany nonwhite diabetes physact int/selection=forward slentry=0.05;
	run;



**********************************************************	
**** 1.4	Backward selection
**********************************************************;

proc reg data=hers1;
	model ldl = bmi age statins smoking drinkany nonwhite diabetes physact int/selection=backward slstay=0.05;
	run;



**********************************************************	
**** 1.5	Stepwise model selection
**********************************************************;

proc reg data=hers1;
	model ldl = bmi age statins smoking drinkany nonwhite diabetes physact int/selection=stepwise slentry=0.05 slstay=0.05;
	run;
	
	