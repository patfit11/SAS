################################################################################################
#### This code is for Statistical Modelling HW 7
## Created: June 20, 2019
## Edited: January 17, 2020
################################################################################################


#### probability of apgar5 score=3
0.34906/(1+0.34906)

#### probability of tox=1
0.05/(1+0.05)

#### odds ratio of crn
exp(1.3213)

#### odds ratio of 1 year increase and 10 year increase
exp(0.0191)
exp(10*0.0191)

####3d
#### calculate estimated prob of death for ICU patient age=50, sex=female, crn=yes, race=black
a <- -2.599 + 50*0.0191 + 1.3213 + 0.6333 - 0.1224
a
b <- exp(a)
c <- 1+exp(a)
b/c

#### 3e
#### odds ratio for female and male
exp(1.0695+0.4094)
exp(1.0695)

#### 3i
exp(1.0695)

####3j
#### calculate estimated prob of death for ICU patient age=50, sex=female, crn=yes, race=black
a <- -2.4714 + 50*0.0193 + 0.3956 + 1.0695 - 0.1253 + 0.4094
a
b <- exp(a)
c <- 1+exp(a)
b/c
