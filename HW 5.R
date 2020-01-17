################################################################################################
#### This code is for Statistical Modelling HW 4
## Created: June 312, 2019
## Edited: January 17, 2020
################################################################################################





#### 3(d)
#### find the 20% and 50% percentile for comparison between Cook's Distance and F(p+1, n-p-1)
threedone <- qf(0.2, df1=4, df2=42)
threedone
threedtwo <- qf(0.5, df1=4, df2=42)
threedtwo


#### 4(f)
#### manual AIC calculation
sse <- 10773
n <- 49
p <- 4
aic <- 49*log(sse/n)+2*(p+1)
aic