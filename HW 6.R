################################################################################################
#### This code is for Statistical Modelling HW 4
## Created: June 15, 2019
## Edited: January 17, 2020
################################################################################################


#### calculate expected cell counts
#### (row i total x column j total)/(total count in table)
a <- 896*1227/2628
a
b <- 896*615/2628
b
c <- 903*1227/2628
c
d <- 903*615/2628
d


#### hypothesis of independence between row and column variables
#### calculate the expected cell count for the two cells in the column for women
FXyes <- ((36+9)*(36+63))/(9+36+39+63)
FXyes
FXno <- ((63+39)*(36+63))/(9+36+39+63)
FXno


#### build the contingency table
symptom <- matrix(c(9, 36, 39, 63),ncol=2,byrow=TRUE)
colnames(symptom) <- c("Male","Female")
rownames(symptom) <- c("Yes","No")
symptom <- as.table(symmptom)
symptom


#### chi-square test statistic for this data
chisq.test(symptom)


#### build the contingency table with totals
symptom <- matrix(c(9, 36, 45, 39, 63, 102, 48, 99, 147),ncol=3,byrow=TRUE)
colnames(symptom) <- c("Male","Female","Total")
rownames(symptom) <- c("Yes","No","Total")
symptom <- as.table(symptom)
symptom


#### calculate odds for males and females to have symptom X
malesone <- 9/48
malestwo <- 1-malesone
males <- malesone/malestwo
males
femalesone <- 36/99
femalestwo <- 1-femalesone
females <- femalesone/femalestwo
females
or <- males/females
or


#### calculate 95% CI for the LOG of OR
log_estimated_odds <- log(or)
standard_error_log_of_or <- sqrt((1/9)+(1/36)+(1/39)+(1/63))
ci_log_low <- log_estimated_odds-1.96*standard_error_log_of_or
ci_log_high <- log_estimated_odds+1.96*standard_error_log_of_or
paste(ci_log_low, ci_log_high)

#### calculate 95% CI for OR
ci_low <- exp(ci_log_low)
ci_high <- exp(ci_log_high)
paste(ci_low, ci_high)
