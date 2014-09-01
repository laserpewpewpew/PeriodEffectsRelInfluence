#####################################################################
# Period Effects on Christian Right Influence over Republican Party #
#####################################################################
library(foreign)
library(stargazer)
library(XML)
library(MASS)
library(sandwich)
library(lmtest)

anesdata <- read.dta("anes_cdf.dta")
anesdata$anesyear <- anesdata$VCF0004

mydata <- anesdata[anesdata$anesyear>=2000,]

mydata$polknowl[mydata$VCF0050b=="5. Very low"] <- 0
mydata$polknowl[mydata$VCF0050b=="4. Fairly low"] <- 1
mydata$polknowl[mydata$VCF0050b=="3. Average"] <- 2
mydata$polknowl[mydata$VCF0050b=="2. Fairly high"] <- 3
mydata$polknowl[mydata$VCF0050b=="1. Very high"] <- 4
mydata$polknowl[mydata$VCF0050b=="0. no Post IW; abbrev. Post IW (1984)"] <- NA
mydata$polknowl[mydata$VCF0050b=="9. NA"] <- NA

mydata$age <- mydata$VCF0101
mydata$agecohort <- mydata$VCF0103

mydata$female[mydata$VCF0104=="2. Female"] <- 1
mydata$female[mydata$VCF0104=="1. Male"] <- 0

mydata$white <- 0
mydata$white[mydata$VCF0106a=="1. White"] <- 1
mydata$white[mydata$VCF0106a=="0. DK; NA; no Pre IW; short-form 'new' Cross Section"] <- NA

mydata$hispanic <- 0
mydata$hispanic[mydata$VCF0107=="1. Yes, Mexican-American, Chicano"] <- 1
mydata$hispanic[mydata$VCF0107=="2. Yes, Puerto Rican"] <- 1
mydata$hispanic[mydata$VCF0107=="3. Yes, other Hispanic"] <- 1
mydata$hispanic[mydata$VCF0107=="4. Yes, Hispanic but DK/NA type"] <- 1
mydata$hispanic[mydata$VCF0107=="9. NA if Hispanic"] <- NA
mydata$hispanic[mydata$VCF0107=="8. DK if Hispanic"] <- NA

mydata$educ[mydata$VCF0110=="1. Grade school or less (0-8 grades)"] <- 0
mydata$educ[mydata$VCF0110=="2. High school (12 grades or fewer, incl. non-college"] <- 1
mydata$educ[mydata$VCF0110=="3. Some college (13 grades or more but no degree;"] <- 2
mydata$educ[mydata$VCF0110=="4. College or advanced degree (no cases 1948)"] <- 3
##see vcf0140

# 11 secession states: AL, AR, FL, GA, LA, MS, NC, SC, TN, TX, VA
mydata$south[mydata$VCF0113=="1. South"] <- 1
mydata$south[mydata$VCF0113=="2. Nonsouth"] <- 0

mydata$incpercentile[mydata$VCF0114=="1. 0 to 16 percentile"] <- 0
mydata$incpercentile[mydata$VCF0114=="2. 17 to 33 percentile"] <- 1
mydata$incpercentile[mydata$VCF0114=="3. 34 to 67 percentile"] <- 2
mydata$incpercentile[mydata$VCF0114=="4. 68 to 95 percentile"] <- 3
mydata$incpercentile[mydata$VCF0114=="5. 96 to 100 percentile"] <- 4
mydata$incpercentile[is.na(mydata$VCF0114)] <- NA

mydata$employed <- 0
mydata$employed[mydata$VCF0116=="1. Working now"] <- 1
mydata$employed[mydata$VCF0116=="9. NA; DK"] <- NA


