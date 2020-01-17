**********************************************************	
****(3) Load the data into SAS
**********************************************************;

libname ads534 "/folders/myfolders/ADS534/data";
	data work.satisfaction;
	set ads534.satisfaction;
	run;
	
**********************************************************	
****(3) Fit the Regression Model
**********************************************************;

proc reg data=work.satisfaction;
	model y = x1 x2 x3;
	run;

**********************************************************
* (3)a	store the output of the regression for further use 
& plot just the Predicted Values vs Studentized Residuals 
**********************************************************;

proc reg data=work.satisfaction;
	model y = x1 x2 x3;
	output out=lres cookd=cookdistance dffits=dffitsest predicted=ypred student=stud residual=r h=leverage rstudent=sr;
	run;

proc plot data=lres;
	plot sr*ypred;
	run;

**********************************************************
* (3)b	create q-q plots of our studentized residuals using 
the variables previously defined ^
**********************************************************;
	
proc univariate data=lres plots;
	var sr;
	qqplot sr/normal;
	run;


**********************************************************
* (3)c	print entire table of values
**********************************************************;

proc print data=lres; 
	run;
	
* obtain the leverage points and print only those calculated 
leverage points 2(p+1)/n = 2*4/46 = 0.174;
proc plot data=lres;
	plot leverage*ypred;
	run;
data threec;
	set lres;
	if abs(leverage)>0.174;
	proc print data=threec;
	run;
	

**********************************************************	
* (3)d	table of the leverage points
**********************************************************;

data threed;
	set lres;
	where abs(sr)>1.79;
	proc print data=threed;
	run;
	
*see R code for percentiles;
	
	
**********************************************************
****(4) Load the data into SAS
**********************************************************;

libname ads534 "/folders/myfolders/ADS534/data";
	data work.cigarette;
	set ads534.cigarette;
	run;
	

***********************************************************
(4)a	find the highest Rsquared value of all possible models
**********************************************************;

proc reg data=work.cigarette outest=var_select_aic;
	model sales = age hs income black female price/selection=adjrsq;
	output out=lres predicted=predicted student=names cookd=cookd h=leverage rstudent=rstudent dffits=dffits;
	run;


**********************************************************
(4)b	build best linear regression model for per capita 
sale of cigarettes in a given state using AIC
**********************************************************;

proc reg data=work.cigarette outest=var_select_aic;
	model sales = age hs income black female price/selection=adjrsq aic;
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
(4)c	check for outliers in Studentized Residuals plot
**********************************************************

proc plot data=lres;
	plot rstudent*predicted;
	run;
	
*print entire table;
proc print data=lres;
	run;
	
*identify outliers based on Studentized Residuals;
data fourc;
	set lres;
	where abs(rstudent)>2.5;
	proc print data=fourc;
	run;

**********************************************************
(4)d	delete outliers and repeat (4)a
**********************************************************

*first delete outliers;
data fourd;
	set lres;
	where abs(rstudent)<2.5;
	proc print data=fourd;
	run;

*check that the outliers were removed;	
proc plot data=fourd; 
	plot rstudent*predicted;
	run;
	
proc reg data=fourd outest=var_select_aic;
	model sales = age hs income black female price/selection=adjrsq;
	output out=lres predicted=predicted student=names cookd=cookd h=leverage rstudent=rstudent dffits=dffits;
	run;


**********************************************************
(4)e	delete outliers and repeat (4)b
**********************************************************;

proc reg data=fourd outest=var_select_aictwo;
	model sales = age hs income black female price/selection=adjrsq aic;
	run;
	
*check the variable selection results to find the variable name for AIC;
proc contents data=var_select_aictwo;
	run;
	
*sort the variable selection results by AIC (from the lowest to the highest);
proc sort data=var_select_aictwo;
	by _AIC_;
	run;
	
*print the results -- the first row is the model with the lowest AIC;
proc print data=var_select_aictwo;
	run;

**********************************************************
(4)f	use SSE of final model (4)e to numerically calculate AIC
**********************************************************;

*run regression for selected model;
proc reg data=fourd;
	model sales = hs income female price;
	run;
	
*go to R code for AIC calculation;


**********************************************************
(4)g	interpret coefficients Age and Black from (4)e
**********************************************************;

*these variables aren't in the model;

**********************************************************
(4)h	delete outliers, forward selection procedure 
(p-value<0.10) to find model
**********************************************************;

proc reg data=fourd;
	model sales = age hs income black female price/selection=forward slentry=0.1;
	run;

**********************************************************
(4)i	delete outliers, use backward elimination 
(p-value<0.10) as staying criterion to find model
**********************************************************;

proc reg data=fourd;
	model sales = age hs income black female price/selection=backward slstay=0.1;
	run;

**********************************************************
(4)j	delete outliers, use stepwise selection procedure 
(p-value<0.10) as entry and staying criterions to find model
**********************************************************;

proc reg data=fourd;
	model sales = age hs income black female price/selection=stepwise slentry=0.1 slstay=0.1;
	run;




	