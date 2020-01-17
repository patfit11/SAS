libname ads534 "/folders/myfolders/ADS534/data";
	data work.lbw;
	set ads534.lbw;
	run;
	
	
	
	
proc univariate;
	data work.lbw;
	run;
	



proc reg data=work.lbw;
	model gestage=headcirc;
	run;
	
	
	

title 'Scatterplot - Two Vraiables';
proc sgscatter data = work.lbw;
	plot gestage*headcirc;
	title 'Gestational Age (weeks) vs Baby Head Circumference (cm)';
run;



data subsetgestage33;
   set work.lbw;
   if gestage=33;
; 

proc print data=subsetgestage33;
   title 'Gestage = 33 Weeks';
run;




proc means data=subsetgestage33;
	var headcirc;
	run;
	
	
	

proc reg data=subsetgestage33;
	model gestage=headcirc;
	run;
	
	
	