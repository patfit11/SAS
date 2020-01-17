################################################################################################
#### This code is for Statistical Modelling HW 4
## Created: May 31, 2019
## Edited: January 17, 2020
################################################################################################



"(a)"
sst <- 910.19994
sse <- 399.22424
ssr <- sst-sse
ssr



"(b)"
"interaction terms - age sex smoking"
p <- 3
"total number of observations"
n <- 800
msr <- ssr/p
msr
mse <- sse/(n-p-1)
mse



"(c)"
F <- msr/mse
F
"need to calculate the p-value still"



"(e)"
rsq <- 1-sse/sst
rsq
rsqa <- 1-((n-1)/(n-p-1))*(sse/sst)
rsqa


"(h)"
ssth <- 910.19994
sseh <- 357.19885
ssrh <- ssth-sseh
ssrh

"interaction terms - age sex smoking g=1 g=2"
ph <- 5
"total number of observations"
nh <- 799
msrh <- ssrh/ph
msrh
mseh <- sseh/(nh-ph-1)
mseh

Fh <- msrh/mseh
Fh

"(i)"
rsqh <- 1-sseh/ssth
rsqh
rsqah <- 1-((nh-1)/(nh-ph-1))*(sseh/ssth)
rsqah


"(k)"
Fk <- ((ssrh-ssr)/2)/mseh
Fk


"(m)"
sg1 <- 0.29427/0.10132
sg1
sg2 <- 0.58779/0.16486
sg2

"(o)"
Fo <- 1.41408/0.44195
Fo