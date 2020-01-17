/* Load the data into SAS
had to change the name from patsat-1 to pat */
libname ads534 "/folders/myfolders/ADS534/data";
	data work.pat;
	set ads534.pat;
	run;
	
	
	
/* Create the mlr model */
proc reg data=work.pat;
	model y = x1 x2 x3/clm;
	run;

/* Test whether X3 given X1 and X2 are in the model */
proc reg data=work.pat;
	model y= x1 x2 x3;
	test: test2 x2, x3;
	run;
	
