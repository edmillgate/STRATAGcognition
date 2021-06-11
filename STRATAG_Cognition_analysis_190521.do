********************************************************************************************************************************************************
********************************************************************************************************************************************************
********************************************************************************************************************************************************
*******************************  STRATA-G: Cognitive analysis (19th May 2021) 	Edward Millgate, IoPPN, King's College London **************************
********************************************************************************************************************************************************
********************************************************************************************************************************************************
********************************************************************************************************************************************************


**Please note that numerical values 1-7 and names for cognitive domains are used interchangeably in this document 


********************************************************
********Summary statistics for tables and main text*****
********************************************************

*No. of TR/NTR per cohort
tab cohortstrata strataeitherever
*Diagnosis 
tab diagnosisBLstrata02
tab diagnosisBLstrata01

*Generating missing binary variables for cognitive domains
gen exec1mis = 0
replace exec1mis = 1 if missing(execfunctionz1)

gen atten2mis = 0
replace atten2mis = 1 if missing(attenworkspeedz2)

gen IQ3mis = 0
replace IQ3mis = 1 if missing(IQcogfuncz3)

gen visual4mis = 0
replace visual4mis = 1 if missing(visualspatmemz4)

gen verbal5mis = 0
replace verbal5mis = 1 if missing(verbintellz5)

gen verbal6mis = 0
replace verbal6mis = 1 if missing(verbmemz6)

gen visual7mis = 0
replace visual7mis = 1 if missing(visuaspatintellz7)

********************************************************************************************************************************************************
**Restricting sample only to those with one cognitive datapoint in one domain (i.e. the cognition dataset)

*clear all
*use "/Users/edwardmillgate/Desktop/stratamasterdatabase_18052021.dta"

*drop if execfunctionz1 == . & attenworkspeedz2 == .& IQcogfuncz3 == . & visualspatmemz4 == . & verbintellz5 ==. & verbmemz6==. & visuaspatintellz7==. 

*Cogntive data only dataset (N = 1,327)
********************************************************************************************************************************************************

clear all 
use "/Users/edwardmillgate/Desktop/cognition_18052021.dta"


*Summaries of cognitive between TR/NTR groups (table in supplementary; Table S.3.1)
bysort strataeitherever: su execfunctionz1
bysort strataeitherever: su attenworkspeedz2
bysort strataeitherever: su IQcogfuncz3
bysort strataeitherever: su visualspatmemz4
bysort strataeitherever: su verbintellz5
bysort strataeitherever: su verbmemz6
bysort strataeitherever: su visuaspatintellz7


*Summary(covariate/demographic/clinical) statistics for Table 3
bysort strataeitherever: su rf_baseline 
bysort strataeitherever: su rf_onset
tab strataeitherever rf_gender
bysort strataeitherever: su rf_dup
bysort strataeitherever: su lengthfollowup
bysort strataeitherever: su rf_saps
bysort strataeitherever: su rf_sans
tab strataeitherever rf_ethnicity02
tab strataeitherever rf_modeonset02

*Proportion of missing data for Table 3
mdesc rf_baseline rf_onset rf_gender rf_dup lengthfollowup rf_saps rf_sans rf_ethnicity02 rf_modeonset02



********************************************************************************************************************************************************
*********************************************************************** MICE modelling ***************************************************************** 
********************************************************************************************************************************************************
*Step 1:
*Prepare dataset with variables for MICE

**Additional code which provides explanation on choice of auxillary varaibles for MICE mode see code lines 825 to 1087 (i.e. last section of code file)


clear all 
use "/Users/edwardmillgate/Desktop/cognition_18052021.dta"
keep idstrata cohort cohortstrata strataclozeverbinary strataeitherever lengthfollowup rf_baseline rf_onset rf_dup rf_gender rf_bmi rf_livingcurr rf_cannabis rf_alcohol rf_saps rf_sans cohortstrata02 rf_ethnicity02 rf_modeonset02 diagnosisBLstrata02 execfunctionz1 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 attenworkspeedz2 visuaspatintellz7
save "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"



********************************************************************************************************************************************************
*Step 2: 
*Checking for best iteration number
********************************************************************************************************************************************************

*imputation model: 10 iterations


clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

mi impute chained (regress) execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(10) rseed(1000) force savetrace(new10imputations)
   

*imputation model: 15 iterations

clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

mi impute chained (regress) execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(15) rseed(1000) force savetrace(new15imputations)


*imputation model: 20 iterations

clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

mi impute chained (regress) execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force savetrace(new20imputations)



**Selecting the best iteration

*10 iterations model

use new10imputations, replace
reshape wide *mean *sd, i(iter) j(m)
tsset iter
*convergence only allows to plot under 100 means, so the * ones are all 100, and the runable code is missing the 2nd mean estimation. However, check with Sophie in case this needs to be random?
*tsline execfunctionz1_mean1 execfunctionz1_mean5 execfunctionz1_mean10 execfunctionz1_mean15 execfunctionz1_mean20 execfunctionz1_mean25 execfunctionz1_mean30 execfunctionz1_mean35 execfunctionz1_mean40 execfunctionz1_mean45 execfunctionz1_mean50 execfunctionz1_mean55 execfunctionz1_mean60 execfunctionz1_mean65 execfunctionz1_mean70 execfunctionz1_mean75 execfunctionz1_mean80 execfunctionz1_mean85 execfunctionz1_mean90 execfunctionz1_mean95 execfunctionz1_mean100

*tsline execfunctionz1_mean1 execfunctionz1_mean2 execfunctionz1_mean3 execfunctionz1_mean4 execfunctionz1_mean5 execfunctionz1_mean6 execfunctionz1_mean7 execfunctionz1_mean8 execfunctionz1_mean9 execfunctionz1_mean10 execfunctionz1_mean11 execfunctionz1_mean12 execfunctionz1_mean13 execfunctionz1_mean14 execfunctionz1_mean15 execfunctionz1_mean16 execfunctionz1_mean17 execfunctionz1_mean18 execfunctionz1_mean19 execfunctionz1_mean20 execfunctionz1_mean21 execfunctionz1_mean22 execfunctionz1_mean23 execfunctionz1_mean24 execfunctionz1_mean25 execfunctionz1_mean26 execfunctionz1_mean27 execfunctionz1_mean28 execfunctionz1_mean29 execfunctionz1_mean30 execfunctionz1_mean31 execfunctionz1_mean32 execfunctionz1_mean33 execfunctionz1_mean34 execfunctionz1_mean35 execfunctionz1_mean36 execfunctionz1_mean37 execfunctionz1_mean38 execfunctionz1_mean39 execfunctionz1_mean40 execfunctionz1_mean41 execfunctionz1_mean42 execfunctionz1_mean43 execfunctionz1_mean44 execfunctionz1_mean45 execfunctionz1_mean46 execfunctionz1_mean47 execfunctionz1_mean48 execfunctionz1_mean49 execfunctionz1_mean50 execfunctionz1_mean51 execfunctionz1_mean52 execfunctionz1_mean53 execfunctionz1_mean54 execfunctionz1_mean55 execfunctionz1_mean56 execfunctionz1_mean57 execfunctionz1_mean58 execfunctionz1_mean59 execfunctionz1_mean60 execfunctionz1_mean61 execfunctionz1_mean62 execfunctionz1_mean63 execfunctionz1_mean64 execfunctionz1_mean65 execfunctionz1_mean66 execfunctionz1_mean67 execfunctionz1_mean68 execfunctionz1_mean69 execfunctionz1_mean70 execfunctionz1_mean71 execfunctionz1_mean72 execfunctionz1_mean73 execfunctionz1_mean74 execfunctionz1_mean75 execfunctionz1_mean76 execfunctionz1_mean77 execfunctionz1_mean78 execfunctionz1_mean79 execfunctionz1_mean80 execfunctionz1_mean81 execfunctionz1_mean82 execfunctionz1_mean83 execfunctionz1_mean84 execfunctionz1_mean85 execfunctionz1_mean86 execfunctionz1_mean87 execfunctionz1_mean88 execfunctionz1_mean89 execfunctionz1_mean90 execfunctionz1_mean91 execfunctionz1_mean92 execfunctionz1_mean93 execfunctionz1_mean94 execfunctionz1_mean95 execfunctionz1_mean96 execfunctionz1_mean97 execfunctionz1_mean98 execfunctionz1_mean99 execfunctionz1_mean100
tsline execfunctionz1_mean1  execfunctionz1_mean2 execfunctionz1_mean3 execfunctionz1_mean4 execfunctionz1_mean5 execfunctionz1_mean6 execfunctionz1_mean7 execfunctionz1_mean8 execfunctionz1_mean9 execfunctionz1_mean10 execfunctionz1_mean11 execfunctionz1_mean12 execfunctionz1_mean13 execfunctionz1_mean14 execfunctionz1_mean15 execfunctionz1_mean16 execfunctionz1_mean17 execfunctionz1_mean18 execfunctionz1_mean19 execfunctionz1_mean20 execfunctionz1_mean21 execfunctionz1_mean22 execfunctionz1_mean23 execfunctionz1_mean24 execfunctionz1_mean25 execfunctionz1_mean26 execfunctionz1_mean27 execfunctionz1_mean28 execfunctionz1_mean29 execfunctionz1_mean30 execfunctionz1_mean31 execfunctionz1_mean32 execfunctionz1_mean33 execfunctionz1_mean34 execfunctionz1_mean35 execfunctionz1_mean36 execfunctionz1_mean37 execfunctionz1_mean38 execfunctionz1_mean39 execfunctionz1_mean40 execfunctionz1_mean41 execfunctionz1_mean42 execfunctionz1_mean43 execfunctionz1_mean44 execfunctionz1_mean45 execfunctionz1_mean46 execfunctionz1_mean47 execfunctionz1_mean48 execfunctionz1_mean49 execfunctionz1_mean50 execfunctionz1_mean51 execfunctionz1_mean52 execfunctionz1_mean53 execfunctionz1_mean54 execfunctionz1_mean55 execfunctionz1_mean56 execfunctionz1_mean57 execfunctionz1_mean58 execfunctionz1_mean59 execfunctionz1_mean60 execfunctionz1_mean61 execfunctionz1_mean62 execfunctionz1_mean63 execfunctionz1_mean64 execfunctionz1_mean65 execfunctionz1_mean66 execfunctionz1_mean67 execfunctionz1_mean68 execfunctionz1_mean69 execfunctionz1_mean70 execfunctionz1_mean71 execfunctionz1_mean72 execfunctionz1_mean73 execfunctionz1_mean74 execfunctionz1_mean75 execfunctionz1_mean76 execfunctionz1_mean77 execfunctionz1_mean78 execfunctionz1_mean79 execfunctionz1_mean80 execfunctionz1_mean81 execfunctionz1_mean82 execfunctionz1_mean83 execfunctionz1_mean84 execfunctionz1_mean85 execfunctionz1_mean86 execfunctionz1_mean87 execfunctionz1_mean88 execfunctionz1_mean89 execfunctionz1_mean90 execfunctionz1_mean91 execfunctionz1_mean92 execfunctionz1_mean93 execfunctionz1_mean94 execfunctionz1_mean95 execfunctionz1_mean96 execfunctionz1_mean97 execfunctionz1_mean98 execfunctionz1_mean99, ytitle("Mean of Executive function")
tsline execfunctionz1_sd1 execfunctionz1_sd2 execfunctionz1_sd3 execfunctionz1_sd4 execfunctionz1_sd5 execfunctionz1_sd6 execfunctionz1_sd7 execfunctionz1_sd8 execfunctionz1_sd9 execfunctionz1_sd10 execfunctionz1_sd11 execfunctionz1_sd12 execfunctionz1_sd13 execfunctionz1_sd14 execfunctionz1_sd15 execfunctionz1_sd16 execfunctionz1_sd17 execfunctionz1_sd18 execfunctionz1_sd19 execfunctionz1_sd20 execfunctionz1_sd21 execfunctionz1_sd22 execfunctionz1_sd23 execfunctionz1_sd24 execfunctionz1_sd25 execfunctionz1_sd26 execfunctionz1_sd27 execfunctionz1_sd28 execfunctionz1_sd29 execfunctionz1_sd30 execfunctionz1_sd31 execfunctionz1_sd32 execfunctionz1_sd33 execfunctionz1_sd34 execfunctionz1_sd35 execfunctionz1_sd36 execfunctionz1_sd37 execfunctionz1_sd38 execfunctionz1_sd39 execfunctionz1_sd40 execfunctionz1_sd41 execfunctionz1_sd42 execfunctionz1_sd43 execfunctionz1_sd44 execfunctionz1_sd45 execfunctionz1_sd46 execfunctionz1_sd47 execfunctionz1_sd48 execfunctionz1_sd49 execfunctionz1_sd50 execfunctionz1_sd51 execfunctionz1_sd52 execfunctionz1_sd53 execfunctionz1_sd54 execfunctionz1_sd55 execfunctionz1_sd56 execfunctionz1_sd57 execfunctionz1_sd58 execfunctionz1_sd59 execfunctionz1_sd60 execfunctionz1_sd61 execfunctionz1_sd62 execfunctionz1_sd63 execfunctionz1_sd64 execfunctionz1_sd65 execfunctionz1_sd66 execfunctionz1_sd67 execfunctionz1_sd68 execfunctionz1_sd69 execfunctionz1_sd70 execfunctionz1_sd71 execfunctionz1_sd72 execfunctionz1_sd73 execfunctionz1_sd74 execfunctionz1_sd75 execfunctionz1_sd76 execfunctionz1_sd77 execfunctionz1_sd78 execfunctionz1_sd79 execfunctionz1_sd80 execfunctionz1_sd81 execfunctionz1_sd82 execfunctionz1_sd83 execfunctionz1_sd84 execfunctionz1_sd85 execfunctionz1_sd86 execfunctionz1_sd87 execfunctionz1_sd88 execfunctionz1_sd89 execfunctionz1_sd90 execfunctionz1_sd91 execfunctionz1_sd92 execfunctionz1_sd93 execfunctionz1_sd94 execfunctionz1_sd95 execfunctionz1_sd96 execfunctionz1_sd97 execfunctionz1_sd98 execfunctionz1_sd99, ytitle("SD of Ecexutive function")

*tsline attenworkspeedz2_mean1 attenworkspeedz2_mean2 attenworkspeedz2_mean3 attenworkspeedz2_mean4 attenworkspeedz2_mean5 attenworkspeedz2_mean6 attenworkspeedz2_mean7 attenworkspeedz2_mean8 attenworkspeedz2_mean9 attenworkspeedz2_mean10 attenworkspeedz2_mean11 attenworkspeedz2_mean12 attenworkspeedz2_mean13 attenworkspeedz2_mean14 attenworkspeedz2_mean15 attenworkspeedz2_mean16 attenworkspeedz2_mean17 attenworkspeedz2_mean18 attenworkspeedz2_mean19 attenworkspeedz2_mean20 attenworkspeedz2_mean21 attenworkspeedz2_mean22 attenworkspeedz2_mean23 attenworkspeedz2_mean24 attenworkspeedz2_mean25 attenworkspeedz2_mean26 attenworkspeedz2_mean27 attenworkspeedz2_mean28 attenworkspeedz2_mean29 attenworkspeedz2_mean30 attenworkspeedz2_mean31 attenworkspeedz2_mean32 attenworkspeedz2_mean33 attenworkspeedz2_mean34 attenworkspeedz2_mean35 attenworkspeedz2_mean36 attenworkspeedz2_mean37 attenworkspeedz2_mean38 attenworkspeedz2_mean39 attenworkspeedz2_mean40 attenworkspeedz2_mean41 attenworkspeedz2_mean42 attenworkspeedz2_mean43 attenworkspeedz2_mean44 attenworkspeedz2_mean45 attenworkspeedz2_mean46 attenworkspeedz2_mean47 attenworkspeedz2_mean48 attenworkspeedz2_mean49 attenworkspeedz2_mean50 attenworkspeedz2_mean51 attenworkspeedz2_mean52 attenworkspeedz2_mean53 attenworkspeedz2_mean54 attenworkspeedz2_mean55 attenworkspeedz2_mean56 attenworkspeedz2_mean57 attenworkspeedz2_mean58 attenworkspeedz2_mean59 attenworkspeedz2_mean60 attenworkspeedz2_mean61 attenworkspeedz2_mean62 attenworkspeedz2_mean63 attenworkspeedz2_mean64 attenworkspeedz2_mean65 attenworkspeedz2_mean66 attenworkspeedz2_mean67 attenworkspeedz2_mean68 attenworkspeedz2_mean69 attenworkspeedz2_mean70 attenworkspeedz2_mean71 attenworkspeedz2_mean72 attenworkspeedz2_mean73 attenworkspeedz2_mean74 attenworkspeedz2_mean75 attenworkspeedz2_mean76 attenworkspeedz2_mean77 attenworkspeedz2_mean78 attenworkspeedz2_mean79 attenworkspeedz2_mean80 attenworkspeedz2_mean81 attenworkspeedz2_mean82 attenworkspeedz2_mean83 attenworkspeedz2_mean84 attenworkspeedz2_mean85 attenworkspeedz2_mean86 attenworkspeedz2_mean87 attenworkspeedz2_mean88 attenworkspeedz2_mean89 attenworkspeedz2_mean90 attenworkspeedz2_mean91 attenworkspeedz2_mean92 attenworkspeedz2_mean93 attenworkspeedz2_mean94 attenworkspeedz2_mean95 attenworkspeedz2_mean96 attenworkspeedz2_mean97 attenworkspeedz2_mean98 attenworkspeedz2_mean99 attenworkspeedz2_mean100
tsline attenworkspeedz2_mean1 attenworkspeedz2_mean2 attenworkspeedz2_mean3 attenworkspeedz2_mean4 attenworkspeedz2_mean5 attenworkspeedz2_mean6 attenworkspeedz2_mean7 attenworkspeedz2_mean8 attenworkspeedz2_mean9 attenworkspeedz2_mean10 attenworkspeedz2_mean11 attenworkspeedz2_mean12 attenworkspeedz2_mean13 attenworkspeedz2_mean14 attenworkspeedz2_mean15 attenworkspeedz2_mean16 attenworkspeedz2_mean17 attenworkspeedz2_mean18 attenworkspeedz2_mean19 attenworkspeedz2_mean20 attenworkspeedz2_mean21 attenworkspeedz2_mean22 attenworkspeedz2_mean23 attenworkspeedz2_mean24 attenworkspeedz2_mean25 attenworkspeedz2_mean26 attenworkspeedz2_mean27 attenworkspeedz2_mean28 attenworkspeedz2_mean29 attenworkspeedz2_mean30 attenworkspeedz2_mean31 attenworkspeedz2_mean32 attenworkspeedz2_mean33 attenworkspeedz2_mean34 attenworkspeedz2_mean35 attenworkspeedz2_mean36 attenworkspeedz2_mean37 attenworkspeedz2_mean38 attenworkspeedz2_mean39 attenworkspeedz2_mean40 attenworkspeedz2_mean41 attenworkspeedz2_mean42 attenworkspeedz2_mean43 attenworkspeedz2_mean44 attenworkspeedz2_mean45 attenworkspeedz2_mean46 attenworkspeedz2_mean47 attenworkspeedz2_mean48 attenworkspeedz2_mean49 attenworkspeedz2_mean50 attenworkspeedz2_mean51 attenworkspeedz2_mean52 attenworkspeedz2_mean53 attenworkspeedz2_mean54 attenworkspeedz2_mean55 attenworkspeedz2_mean56 attenworkspeedz2_mean57 attenworkspeedz2_mean58 attenworkspeedz2_mean59 attenworkspeedz2_mean60 attenworkspeedz2_mean61 attenworkspeedz2_mean62 attenworkspeedz2_mean63 attenworkspeedz2_mean64 attenworkspeedz2_mean65 attenworkspeedz2_mean66 attenworkspeedz2_mean67 attenworkspeedz2_mean68 attenworkspeedz2_mean69 attenworkspeedz2_mean70 attenworkspeedz2_mean71 attenworkspeedz2_mean72 attenworkspeedz2_mean73 attenworkspeedz2_mean74 attenworkspeedz2_mean75 attenworkspeedz2_mean76 attenworkspeedz2_mean77 attenworkspeedz2_mean78 attenworkspeedz2_mean79 attenworkspeedz2_mean80 attenworkspeedz2_mean81 attenworkspeedz2_mean82 attenworkspeedz2_mean83 attenworkspeedz2_mean84 attenworkspeedz2_mean85 attenworkspeedz2_mean86 attenworkspeedz2_mean87 attenworkspeedz2_mean88 attenworkspeedz2_mean89 attenworkspeedz2_mean90 attenworkspeedz2_mean91 attenworkspeedz2_mean92 attenworkspeedz2_mean93 attenworkspeedz2_mean94 attenworkspeedz2_mean95 attenworkspeedz2_mean96 attenworkspeedz2_mean97 attenworkspeedz2_mean98 attenworkspeedz2_mean99, ytitle("Mean of Attention, wokring memory & processing speed")
tsline attenworkspeedz2_sd1 attenworkspeedz2_sd2 attenworkspeedz2_sd3 attenworkspeedz2_sd4 attenworkspeedz2_sd5 attenworkspeedz2_sd6 attenworkspeedz2_sd7 attenworkspeedz2_sd8 attenworkspeedz2_sd9 attenworkspeedz2_sd10 attenworkspeedz2_sd11 attenworkspeedz2_sd12 attenworkspeedz2_sd13 attenworkspeedz2_sd14 attenworkspeedz2_sd15 attenworkspeedz2_sd16 attenworkspeedz2_sd17 attenworkspeedz2_sd18 attenworkspeedz2_sd19 attenworkspeedz2_sd20 attenworkspeedz2_sd21 attenworkspeedz2_sd22 attenworkspeedz2_sd23 attenworkspeedz2_sd24 attenworkspeedz2_sd25 attenworkspeedz2_sd26 attenworkspeedz2_sd27 attenworkspeedz2_sd28 attenworkspeedz2_sd29 attenworkspeedz2_sd30 attenworkspeedz2_sd31 attenworkspeedz2_sd32 attenworkspeedz2_sd33 attenworkspeedz2_sd34 attenworkspeedz2_sd35 attenworkspeedz2_sd36 attenworkspeedz2_sd37 attenworkspeedz2_sd38 attenworkspeedz2_sd39 attenworkspeedz2_sd40 attenworkspeedz2_sd41 attenworkspeedz2_sd42 attenworkspeedz2_sd43 attenworkspeedz2_sd44 attenworkspeedz2_sd45 attenworkspeedz2_sd46 attenworkspeedz2_sd47 attenworkspeedz2_sd48 attenworkspeedz2_sd49 attenworkspeedz2_sd50 attenworkspeedz2_sd51 attenworkspeedz2_sd52 attenworkspeedz2_sd53 attenworkspeedz2_sd54 attenworkspeedz2_sd55 attenworkspeedz2_sd56 attenworkspeedz2_sd57 attenworkspeedz2_sd58 attenworkspeedz2_sd59 attenworkspeedz2_sd60 attenworkspeedz2_sd61 attenworkspeedz2_sd62 attenworkspeedz2_sd63 attenworkspeedz2_sd64 attenworkspeedz2_sd65 attenworkspeedz2_sd66 attenworkspeedz2_sd67 attenworkspeedz2_sd68 attenworkspeedz2_sd69 attenworkspeedz2_sd70 attenworkspeedz2_sd71 attenworkspeedz2_sd72 attenworkspeedz2_sd73 attenworkspeedz2_sd74 attenworkspeedz2_sd75 attenworkspeedz2_sd76 attenworkspeedz2_sd77 attenworkspeedz2_sd78 attenworkspeedz2_sd79 attenworkspeedz2_sd80 attenworkspeedz2_sd81 attenworkspeedz2_sd82 attenworkspeedz2_sd83 attenworkspeedz2_sd84 attenworkspeedz2_sd85 attenworkspeedz2_sd86 attenworkspeedz2_sd87 attenworkspeedz2_sd88 attenworkspeedz2_sd89 attenworkspeedz2_sd90 attenworkspeedz2_sd91 attenworkspeedz2_sd92 attenworkspeedz2_sd93 attenworkspeedz2_sd94 attenworkspeedz2_sd95 attenworkspeedz2_sd96 attenworkspeedz2_sd97 attenworkspeedz2_sd98 attenworkspeedz2_sd99, ytitle("SD of Attention, wokring memory & processing speed")


*tsline IQcogfuncz3_mean1 IQcogfuncz3_mean2 IQcogfuncz3_mean3 IQcogfuncz3_mean4 IQcogfuncz3_mean5 IQcogfuncz3_mean6 IQcogfuncz3_mean7 IQcogfuncz3_mean8 IQcogfuncz3_mean9 IQcogfuncz3_mean10 IQcogfuncz3_mean11 IQcogfuncz3_mean12 IQcogfuncz3_mean13 IQcogfuncz3_mean14 IQcogfuncz3_mean15 IQcogfuncz3_mean16 IQcogfuncz3_mean17 IQcogfuncz3_mean18 IQcogfuncz3_mean19 IQcogfuncz3_mean20 IQcogfuncz3_mean21 IQcogfuncz3_mean22 IQcogfuncz3_mean23 IQcogfuncz3_mean24 IQcogfuncz3_mean25 IQcogfuncz3_mean26 IQcogfuncz3_mean27 IQcogfuncz3_mean28 IQcogfuncz3_mean29 IQcogfuncz3_mean30 IQcogfuncz3_mean31 IQcogfuncz3_mean32 IQcogfuncz3_mean33 IQcogfuncz3_mean34 IQcogfuncz3_mean35 IQcogfuncz3_mean36 IQcogfuncz3_mean37 IQcogfuncz3_mean38 IQcogfuncz3_mean39 IQcogfuncz3_mean40 IQcogfuncz3_mean41 IQcogfuncz3_mean42 IQcogfuncz3_mean43 IQcogfuncz3_mean44 IQcogfuncz3_mean45 IQcogfuncz3_mean46 IQcogfuncz3_mean47 IQcogfuncz3_mean48 IQcogfuncz3_mean49 IQcogfuncz3_mean50 IQcogfuncz3_mean51 IQcogfuncz3_mean52 IQcogfuncz3_mean53 IQcogfuncz3_mean54 IQcogfuncz3_mean55 IQcogfuncz3_mean56 IQcogfuncz3_mean57 IQcogfuncz3_mean58 IQcogfuncz3_mean59 IQcogfuncz3_mean60 IQcogfuncz3_mean61 IQcogfuncz3_mean62 IQcogfuncz3_mean63 IQcogfuncz3_mean64 IQcogfuncz3_mean65 IQcogfuncz3_mean66 IQcogfuncz3_mean67 IQcogfuncz3_mean68 IQcogfuncz3_mean69 IQcogfuncz3_mean70 IQcogfuncz3_mean71 IQcogfuncz3_mean72 IQcogfuncz3_mean73 IQcogfuncz3_mean74 IQcogfuncz3_mean75 IQcogfuncz3_mean76 IQcogfuncz3_mean77 IQcogfuncz3_mean78 IQcogfuncz3_mean79 IQcogfuncz3_mean80 IQcogfuncz3_mean81 IQcogfuncz3_mean82 IQcogfuncz3_mean83 IQcogfuncz3_mean84 IQcogfuncz3_mean85 IQcogfuncz3_mean86 IQcogfuncz3_mean87 IQcogfuncz3_mean88 IQcogfuncz3_mean89 IQcogfuncz3_mean90 IQcogfuncz3_mean91 IQcogfuncz3_mean92 IQcogfuncz3_mean93 IQcogfuncz3_mean94 IQcogfuncz3_mean95 IQcogfuncz3_mean96 IQcogfuncz3_mean97 IQcogfuncz3_mean98 IQcogfuncz3_mean99 IQcogfuncz3_mean100
tsline IQcogfuncz3_mean1  IQcogfuncz3_mean2 IQcogfuncz3_mean3 IQcogfuncz3_mean4 IQcogfuncz3_mean5 IQcogfuncz3_mean6 IQcogfuncz3_mean7 IQcogfuncz3_mean8 IQcogfuncz3_mean9 IQcogfuncz3_mean10 IQcogfuncz3_mean11 IQcogfuncz3_mean12 IQcogfuncz3_mean13 IQcogfuncz3_mean14 IQcogfuncz3_mean15 IQcogfuncz3_mean16 IQcogfuncz3_mean17 IQcogfuncz3_mean18 IQcogfuncz3_mean19 IQcogfuncz3_mean20 IQcogfuncz3_mean21 IQcogfuncz3_mean22 IQcogfuncz3_mean23 IQcogfuncz3_mean24 IQcogfuncz3_mean25 IQcogfuncz3_mean26 IQcogfuncz3_mean27 IQcogfuncz3_mean28 IQcogfuncz3_mean29 IQcogfuncz3_mean30 IQcogfuncz3_mean31 IQcogfuncz3_mean32 IQcogfuncz3_mean33 IQcogfuncz3_mean34 IQcogfuncz3_mean35 IQcogfuncz3_mean36 IQcogfuncz3_mean37 IQcogfuncz3_mean38 IQcogfuncz3_mean39 IQcogfuncz3_mean40 IQcogfuncz3_mean41 IQcogfuncz3_mean42 IQcogfuncz3_mean43 IQcogfuncz3_mean44 IQcogfuncz3_mean45 IQcogfuncz3_mean46 IQcogfuncz3_mean47 IQcogfuncz3_mean48 IQcogfuncz3_mean49 IQcogfuncz3_mean50 IQcogfuncz3_mean51 IQcogfuncz3_mean52 IQcogfuncz3_mean53 IQcogfuncz3_mean54 IQcogfuncz3_mean55 IQcogfuncz3_mean56 IQcogfuncz3_mean57 IQcogfuncz3_mean58 IQcogfuncz3_mean59 IQcogfuncz3_mean60 IQcogfuncz3_mean61 IQcogfuncz3_mean62 IQcogfuncz3_mean63 IQcogfuncz3_mean64 IQcogfuncz3_mean65 IQcogfuncz3_mean66 IQcogfuncz3_mean67 IQcogfuncz3_mean68 IQcogfuncz3_mean69 IQcogfuncz3_mean70 IQcogfuncz3_mean71 IQcogfuncz3_mean72 IQcogfuncz3_mean73 IQcogfuncz3_mean74 IQcogfuncz3_mean75 IQcogfuncz3_mean76 IQcogfuncz3_mean77 IQcogfuncz3_mean78 IQcogfuncz3_mean79 IQcogfuncz3_mean80 IQcogfuncz3_mean81 IQcogfuncz3_mean82 IQcogfuncz3_mean83 IQcogfuncz3_mean84 IQcogfuncz3_mean85 IQcogfuncz3_mean86 IQcogfuncz3_mean87 IQcogfuncz3_mean88 IQcogfuncz3_mean89 IQcogfuncz3_mean90 IQcogfuncz3_mean91 IQcogfuncz3_mean92 IQcogfuncz3_mean93 IQcogfuncz3_mean94 IQcogfuncz3_mean95 IQcogfuncz3_mean96 IQcogfuncz3_mean97 IQcogfuncz3_mean98 IQcogfuncz3_mean99, ytitle(Mean of IQ/general congnitive function)
tsline IQcogfuncz3_sd1  IQcogfuncz3_sd2 IQcogfuncz3_sd3 IQcogfuncz3_sd4 IQcogfuncz3_sd5 IQcogfuncz3_sd6 IQcogfuncz3_sd7 IQcogfuncz3_sd8 IQcogfuncz3_sd9 IQcogfuncz3_sd10 IQcogfuncz3_sd11 IQcogfuncz3_sd12 IQcogfuncz3_sd13 IQcogfuncz3_sd14 IQcogfuncz3_sd15 IQcogfuncz3_sd16 IQcogfuncz3_sd17 IQcogfuncz3_sd18 IQcogfuncz3_sd19 IQcogfuncz3_sd20 IQcogfuncz3_sd21 IQcogfuncz3_sd22 IQcogfuncz3_sd23 IQcogfuncz3_sd24 IQcogfuncz3_sd25 IQcogfuncz3_sd26 IQcogfuncz3_sd27 IQcogfuncz3_sd28 IQcogfuncz3_sd29 IQcogfuncz3_sd30 IQcogfuncz3_sd31 IQcogfuncz3_sd32 IQcogfuncz3_sd33 IQcogfuncz3_sd34 IQcogfuncz3_sd35 IQcogfuncz3_sd36 IQcogfuncz3_sd37 IQcogfuncz3_sd38 IQcogfuncz3_sd39 IQcogfuncz3_sd40 IQcogfuncz3_sd41 IQcogfuncz3_sd42 IQcogfuncz3_sd43 IQcogfuncz3_sd44 IQcogfuncz3_sd45 IQcogfuncz3_sd46 IQcogfuncz3_sd47 IQcogfuncz3_sd48 IQcogfuncz3_sd49 IQcogfuncz3_sd50 IQcogfuncz3_sd51 IQcogfuncz3_sd52 IQcogfuncz3_sd53 IQcogfuncz3_sd54 IQcogfuncz3_sd55 IQcogfuncz3_sd56 IQcogfuncz3_sd57 IQcogfuncz3_sd58 IQcogfuncz3_sd59 IQcogfuncz3_sd60 IQcogfuncz3_sd61 IQcogfuncz3_sd62 IQcogfuncz3_sd63 IQcogfuncz3_sd64 IQcogfuncz3_sd65 IQcogfuncz3_sd66 IQcogfuncz3_sd67 IQcogfuncz3_sd68 IQcogfuncz3_sd69 IQcogfuncz3_sd70 IQcogfuncz3_sd71 IQcogfuncz3_sd72 IQcogfuncz3_sd73 IQcogfuncz3_sd74 IQcogfuncz3_sd75 IQcogfuncz3_sd76 IQcogfuncz3_sd77 IQcogfuncz3_sd78 IQcogfuncz3_sd79 IQcogfuncz3_sd80 IQcogfuncz3_sd81 IQcogfuncz3_sd82 IQcogfuncz3_sd83 IQcogfuncz3_sd84 IQcogfuncz3_sd85 IQcogfuncz3_sd86 IQcogfuncz3_sd87 IQcogfuncz3_sd88 IQcogfuncz3_sd89 IQcogfuncz3_sd90 IQcogfuncz3_sd91 IQcogfuncz3_sd92 IQcogfuncz3_sd93 IQcogfuncz3_sd94 IQcogfuncz3_sd95 IQcogfuncz3_sd96 IQcogfuncz3_sd97 IQcogfuncz3_sd98 IQcogfuncz3_sd99, ytitle(SD of IQ/general cognitive function)

*tsline visualspatmemz4_mean1 visualspatmemz4_mean2 visualspatmemz4_mean3 visualspatmemz4_mean4 visualspatmemz4_mean5 visualspatmemz4_mean6 visualspatmemz4_mean7 visualspatmemz4_mean8 visualspatmemz4_mean9 visualspatmemz4_mean10 visualspatmemz4_mean11 visualspatmemz4_mean12 visualspatmemz4_mean13 visualspatmemz4_mean14 visualspatmemz4_mean15 visualspatmemz4_mean16 visualspatmemz4_mean17 visualspatmemz4_mean18 visualspatmemz4_mean19 visualspatmemz4_mean20 visualspatmemz4_mean21 visualspatmemz4_mean22 visualspatmemz4_mean23 visualspatmemz4_mean24 visualspatmemz4_mean25 visualspatmemz4_mean26 visualspatmemz4_mean27 visualspatmemz4_mean28 visualspatmemz4_mean29 visualspatmemz4_mean30 visualspatmemz4_mean31 visualspatmemz4_mean32 visualspatmemz4_mean33 visualspatmemz4_mean34 visualspatmemz4_mean35 visualspatmemz4_mean36 visualspatmemz4_mean37 visualspatmemz4_mean38 visualspatmemz4_mean39 visualspatmemz4_mean40 visualspatmemz4_mean41 visualspatmemz4_mean42 visualspatmemz4_mean43 visualspatmemz4_mean44 visualspatmemz4_mean45 visualspatmemz4_mean46 visualspatmemz4_mean47 visualspatmemz4_mean48 visualspatmemz4_mean49 visualspatmemz4_mean50 visualspatmemz4_mean51 visualspatmemz4_mean52 visualspatmemz4_mean53 visualspatmemz4_mean54 visualspatmemz4_mean55 visualspatmemz4_mean56 visualspatmemz4_mean57 visualspatmemz4_mean58 visualspatmemz4_mean59 visualspatmemz4_mean60 visualspatmemz4_mean61 visualspatmemz4_mean62 visualspatmemz4_mean63 visualspatmemz4_mean64 visualspatmemz4_mean65 visualspatmemz4_mean66 visualspatmemz4_mean67 visualspatmemz4_mean68 visualspatmemz4_mean69 visualspatmemz4_mean70 visualspatmemz4_mean71 visualspatmemz4_mean72 visualspatmemz4_mean73 visualspatmemz4_mean74 visualspatmemz4_mean75 visualspatmemz4_mean76 visualspatmemz4_mean77 visualspatmemz4_mean78 visualspatmemz4_mean79 visualspatmemz4_mean80 visualspatmemz4_mean81 visualspatmemz4_mean82 visualspatmemz4_mean83 visualspatmemz4_mean84 visualspatmemz4_mean85 visualspatmemz4_mean86 visualspatmemz4_mean87 visualspatmemz4_mean88 visualspatmemz4_mean89 visualspatmemz4_mean90 visualspatmemz4_mean91 visualspatmemz4_mean92 visualspatmemz4_mean93 visualspatmemz4_mean94 visualspatmemz4_mean95 visualspatmemz4_mean96 visualspatmemz4_mean97 visualspatmemz4_mean98 visualspatmemz4_mean99 visualspatmemz4_mean100
tsline visualspatmemz4_mean1 visualspatmemz4_mean2 visualspatmemz4_mean3 visualspatmemz4_mean4 visualspatmemz4_mean5 visualspatmemz4_mean6 visualspatmemz4_mean7 visualspatmemz4_mean8 visualspatmemz4_mean9 visualspatmemz4_mean10 visualspatmemz4_mean11 visualspatmemz4_mean12 visualspatmemz4_mean13 visualspatmemz4_mean14 visualspatmemz4_mean15 visualspatmemz4_mean16 visualspatmemz4_mean17 visualspatmemz4_mean18 visualspatmemz4_mean19 visualspatmemz4_mean20 visualspatmemz4_mean21 visualspatmemz4_mean22 visualspatmemz4_mean23 visualspatmemz4_mean24 visualspatmemz4_mean25 visualspatmemz4_mean26 visualspatmemz4_mean27 visualspatmemz4_mean28 visualspatmemz4_mean29 visualspatmemz4_mean30 visualspatmemz4_mean31 visualspatmemz4_mean32 visualspatmemz4_mean33 visualspatmemz4_mean34 visualspatmemz4_mean35 visualspatmemz4_mean36 visualspatmemz4_mean37 visualspatmemz4_mean38 visualspatmemz4_mean39 visualspatmemz4_mean40 visualspatmemz4_mean41 visualspatmemz4_mean42 visualspatmemz4_mean43 visualspatmemz4_mean44 visualspatmemz4_mean45 visualspatmemz4_mean46 visualspatmemz4_mean47 visualspatmemz4_mean48 visualspatmemz4_mean49 visualspatmemz4_mean50 visualspatmemz4_mean51 visualspatmemz4_mean52 visualspatmemz4_mean53 visualspatmemz4_mean54 visualspatmemz4_mean55 visualspatmemz4_mean56 visualspatmemz4_mean57 visualspatmemz4_mean58 visualspatmemz4_mean59 visualspatmemz4_mean60 visualspatmemz4_mean61 visualspatmemz4_mean62 visualspatmemz4_mean63 visualspatmemz4_mean64 visualspatmemz4_mean65 visualspatmemz4_mean66 visualspatmemz4_mean67 visualspatmemz4_mean68 visualspatmemz4_mean69 visualspatmemz4_mean70 visualspatmemz4_mean71 visualspatmemz4_mean72 visualspatmemz4_mean73 visualspatmemz4_mean74 visualspatmemz4_mean75 visualspatmemz4_mean76 visualspatmemz4_mean77 visualspatmemz4_mean78 visualspatmemz4_mean79 visualspatmemz4_mean80 visualspatmemz4_mean81 visualspatmemz4_mean82 visualspatmemz4_mean83 visualspatmemz4_mean84 visualspatmemz4_mean85 visualspatmemz4_mean86 visualspatmemz4_mean87 visualspatmemz4_mean88 visualspatmemz4_mean89 visualspatmemz4_mean90 visualspatmemz4_mean91 visualspatmemz4_mean92 visualspatmemz4_mean93 visualspatmemz4_mean94 visualspatmemz4_mean95 visualspatmemz4_mean96 visualspatmemz4_mean97 visualspatmemz4_mean98 visualspatmemz4_mean99, ytitle("Mean of Visual-spatial memory")
tsline visualspatmemz4_sd1 visualspatmemz4_sd2 visualspatmemz4_sd3 visualspatmemz4_sd4 visualspatmemz4_sd5 visualspatmemz4_sd6 visualspatmemz4_sd7 visualspatmemz4_sd8 visualspatmemz4_sd9 visualspatmemz4_sd10 visualspatmemz4_sd11 visualspatmemz4_sd12 visualspatmemz4_sd13 visualspatmemz4_sd14 visualspatmemz4_sd15 visualspatmemz4_sd16 visualspatmemz4_sd17 visualspatmemz4_sd18 visualspatmemz4_sd19 visualspatmemz4_sd20 visualspatmemz4_sd21 visualspatmemz4_sd22 visualspatmemz4_sd23 visualspatmemz4_sd24 visualspatmemz4_sd25 visualspatmemz4_sd26 visualspatmemz4_sd27 visualspatmemz4_sd28 visualspatmemz4_sd29 visualspatmemz4_sd30 visualspatmemz4_sd31 visualspatmemz4_sd32 visualspatmemz4_sd33 visualspatmemz4_sd34 visualspatmemz4_sd35 visualspatmemz4_sd36 visualspatmemz4_sd37 visualspatmemz4_sd38 visualspatmemz4_sd39 visualspatmemz4_sd40 visualspatmemz4_sd41 visualspatmemz4_sd42 visualspatmemz4_sd43 visualspatmemz4_sd44 visualspatmemz4_sd45 visualspatmemz4_sd46 visualspatmemz4_sd47 visualspatmemz4_sd48 visualspatmemz4_sd49 visualspatmemz4_sd50 visualspatmemz4_sd51 visualspatmemz4_sd52 visualspatmemz4_sd53 visualspatmemz4_sd54 visualspatmemz4_sd55 visualspatmemz4_sd56 visualspatmemz4_sd57 visualspatmemz4_sd58 visualspatmemz4_sd59 visualspatmemz4_sd60 visualspatmemz4_sd61 visualspatmemz4_sd62 visualspatmemz4_sd63 visualspatmemz4_sd64 visualspatmemz4_sd65 visualspatmemz4_sd66 visualspatmemz4_sd67 visualspatmemz4_sd68 visualspatmemz4_sd69 visualspatmemz4_sd70 visualspatmemz4_sd71 visualspatmemz4_sd72 visualspatmemz4_sd73 visualspatmemz4_sd74 visualspatmemz4_sd75 visualspatmemz4_sd76 visualspatmemz4_sd77 visualspatmemz4_sd78 visualspatmemz4_sd79 visualspatmemz4_sd80 visualspatmemz4_sd81 visualspatmemz4_sd82 visualspatmemz4_sd83 visualspatmemz4_sd84 visualspatmemz4_sd85 visualspatmemz4_sd86 visualspatmemz4_sd87 visualspatmemz4_sd88 visualspatmemz4_sd89 visualspatmemz4_sd90 visualspatmemz4_sd91 visualspatmemz4_sd92 visualspatmemz4_sd93 visualspatmemz4_sd94 visualspatmemz4_sd95 visualspatmemz4_sd96 visualspatmemz4_sd97 visualspatmemz4_sd98 visualspatmemz4_sd99, ytitle("SD of Visual-spatial memory")

*tsline verbintellz5_mean1 verbintellz5_mean2 verbintellz5_mean3 verbintellz5_mean4 verbintellz5_mean5 verbintellz5_mean6 verbintellz5_mean7 verbintellz5_mean8 verbintellz5_mean9 verbintellz5_mean10 verbintellz5_mean11 verbintellz5_mean12 verbintellz5_mean13 verbintellz5_mean14 verbintellz5_mean15 verbintellz5_mean16 verbintellz5_mean17 verbintellz5_mean18 verbintellz5_mean19 verbintellz5_mean20 verbintellz5_mean21 verbintellz5_mean22 verbintellz5_mean23 verbintellz5_mean24 verbintellz5_mean25 verbintellz5_mean26 verbintellz5_mean27 verbintellz5_mean28 verbintellz5_mean29 verbintellz5_mean30 verbintellz5_mean31 verbintellz5_mean32 verbintellz5_mean33 verbintellz5_mean34 verbintellz5_mean35 verbintellz5_mean36 verbintellz5_mean37 verbintellz5_mean38 verbintellz5_mean39 verbintellz5_mean40 verbintellz5_mean41 verbintellz5_mean42 verbintellz5_mean43 verbintellz5_mean44 verbintellz5_mean45 verbintellz5_mean46 verbintellz5_mean47 verbintellz5_mean48 verbintellz5_mean49 verbintellz5_mean50 verbintellz5_mean51 verbintellz5_mean52 verbintellz5_mean53 verbintellz5_mean54 verbintellz5_mean55 verbintellz5_mean56 verbintellz5_mean57 verbintellz5_mean58 verbintellz5_mean59 verbintellz5_mean60 verbintellz5_mean61 verbintellz5_mean62 verbintellz5_mean63 verbintellz5_mean64 verbintellz5_mean65 verbintellz5_mean66 verbintellz5_mean67 verbintellz5_mean68 verbintellz5_mean69 verbintellz5_mean70 verbintellz5_mean71 verbintellz5_mean72 verbintellz5_mean73 verbintellz5_mean74 verbintellz5_mean75 verbintellz5_mean76 verbintellz5_mean77 verbintellz5_mean78 verbintellz5_mean79 verbintellz5_mean80 verbintellz5_mean81 verbintellz5_mean82 verbintellz5_mean83 verbintellz5_mean84 verbintellz5_mean85 verbintellz5_mean86 verbintellz5_mean87 verbintellz5_mean88 verbintellz5_mean89 verbintellz5_mean90 verbintellz5_mean91 verbintellz5_mean92 verbintellz5_mean93 verbintellz5_mean94 verbintellz5_mean95 verbintellz5_mean96 verbintellz5_mean97 verbintellz5_mean98 verbintellz5_mean99 verbintellz5_mean100
tsline verbintellz5_mean1 verbintellz5_mean2 verbintellz5_mean3 verbintellz5_mean4 verbintellz5_mean5 verbintellz5_mean6 verbintellz5_mean7 verbintellz5_mean8 verbintellz5_mean9 verbintellz5_mean10 verbintellz5_mean11 verbintellz5_mean12 verbintellz5_mean13 verbintellz5_mean14 verbintellz5_mean15 verbintellz5_mean16 verbintellz5_mean17 verbintellz5_mean18 verbintellz5_mean19 verbintellz5_mean20 verbintellz5_mean21 verbintellz5_mean22 verbintellz5_mean23 verbintellz5_mean24 verbintellz5_mean25 verbintellz5_mean26 verbintellz5_mean27 verbintellz5_mean28 verbintellz5_mean29 verbintellz5_mean30 verbintellz5_mean31 verbintellz5_mean32 verbintellz5_mean33 verbintellz5_mean34 verbintellz5_mean35 verbintellz5_mean36 verbintellz5_mean37 verbintellz5_mean38 verbintellz5_mean39 verbintellz5_mean40 verbintellz5_mean41 verbintellz5_mean42 verbintellz5_mean43 verbintellz5_mean44 verbintellz5_mean45 verbintellz5_mean46 verbintellz5_mean47 verbintellz5_mean48 verbintellz5_mean49 verbintellz5_mean50 verbintellz5_mean51 verbintellz5_mean52 verbintellz5_mean53 verbintellz5_mean54 verbintellz5_mean55 verbintellz5_mean56 verbintellz5_mean57 verbintellz5_mean58 verbintellz5_mean59 verbintellz5_mean60 verbintellz5_mean61 verbintellz5_mean62 verbintellz5_mean63 verbintellz5_mean64 verbintellz5_mean65 verbintellz5_mean66 verbintellz5_mean67 verbintellz5_mean68 verbintellz5_mean69 verbintellz5_mean70 verbintellz5_mean71 verbintellz5_mean72 verbintellz5_mean73 verbintellz5_mean74 verbintellz5_mean75 verbintellz5_mean76 verbintellz5_mean77 verbintellz5_mean78 verbintellz5_mean79 verbintellz5_mean80 verbintellz5_mean81 verbintellz5_mean82 verbintellz5_mean83 verbintellz5_mean84 verbintellz5_mean85 verbintellz5_mean86 verbintellz5_mean87 verbintellz5_mean88 verbintellz5_mean89 verbintellz5_mean90 verbintellz5_mean91 verbintellz5_mean92 verbintellz5_mean93 verbintellz5_mean94 verbintellz5_mean95 verbintellz5_mean96 verbintellz5_mean97 verbintellz5_mean98 verbintellz5_mean99, ytitle("Mean of Verbal Intelligence")
tsline verbintellz5_sd1 verbintellz5_sd2 verbintellz5_sd3 verbintellz5_sd4 verbintellz5_sd5 verbintellz5_sd6 verbintellz5_sd7 verbintellz5_sd8 verbintellz5_sd9 verbintellz5_sd10 verbintellz5_sd11 verbintellz5_sd12 verbintellz5_sd13 verbintellz5_sd14 verbintellz5_sd15 verbintellz5_sd16 verbintellz5_sd17 verbintellz5_sd18 verbintellz5_sd19 verbintellz5_sd20 verbintellz5_sd21 verbintellz5_sd22 verbintellz5_sd23 verbintellz5_sd24 verbintellz5_sd25 verbintellz5_sd26 verbintellz5_sd27 verbintellz5_sd28 verbintellz5_sd29 verbintellz5_sd30 verbintellz5_sd31 verbintellz5_sd32 verbintellz5_sd33 verbintellz5_sd34 verbintellz5_sd35 verbintellz5_sd36 verbintellz5_sd37 verbintellz5_sd38 verbintellz5_sd39 verbintellz5_sd40 verbintellz5_sd41 verbintellz5_sd42 verbintellz5_sd43 verbintellz5_sd44 verbintellz5_sd45 verbintellz5_sd46 verbintellz5_sd47 verbintellz5_sd48 verbintellz5_sd49 verbintellz5_sd50 verbintellz5_sd51 verbintellz5_sd52 verbintellz5_sd53 verbintellz5_sd54 verbintellz5_sd55 verbintellz5_sd56 verbintellz5_sd57 verbintellz5_sd58 verbintellz5_sd59 verbintellz5_sd60 verbintellz5_sd61 verbintellz5_sd62 verbintellz5_sd63 verbintellz5_sd64 verbintellz5_sd65 verbintellz5_sd66 verbintellz5_sd67 verbintellz5_sd68 verbintellz5_sd69 verbintellz5_sd70 verbintellz5_sd71 verbintellz5_sd72 verbintellz5_sd73 verbintellz5_sd74 verbintellz5_sd75 verbintellz5_sd76 verbintellz5_sd77 verbintellz5_sd78 verbintellz5_sd79 verbintellz5_sd80 verbintellz5_sd81 verbintellz5_sd82 verbintellz5_sd83 verbintellz5_sd84 verbintellz5_sd85 verbintellz5_sd86 verbintellz5_sd87 verbintellz5_sd88 verbintellz5_sd89 verbintellz5_sd90 verbintellz5_sd91 verbintellz5_sd92 verbintellz5_sd93 verbintellz5_sd94 verbintellz5_sd95 verbintellz5_sd96 verbintellz5_sd97 verbintellz5_sd98 verbintellz5_sd99, ytitle("SD of Verbal Intelligence")

*tsline verbmemz6_mean1 verbmemz6_mean2 verbmemz6_mean3 verbmemz6_mean4 verbmemz6_mean5 verbmemz6_mean6 verbmemz6_mean7 verbmemz6_mean8 verbmemz6_mean9 verbmemz6_mean10 verbmemz6_mean11 verbmemz6_mean12 verbmemz6_mean13 verbmemz6_mean14 verbmemz6_mean15 verbmemz6_mean16 verbmemz6_mean17 verbmemz6_mean18 verbmemz6_mean19 verbmemz6_mean20 verbmemz6_mean21 verbmemz6_mean22 verbmemz6_mean23 verbmemz6_mean24 verbmemz6_mean25 verbmemz6_mean26 verbmemz6_mean27 verbmemz6_mean28 verbmemz6_mean29 verbmemz6_mean30 verbmemz6_mean31 verbmemz6_mean32 verbmemz6_mean33 verbmemz6_mean34 verbmemz6_mean35 verbmemz6_mean36 verbmemz6_mean37 verbmemz6_mean38 verbmemz6_mean39 verbmemz6_mean40 verbmemz6_mean41 verbmemz6_mean42 verbmemz6_mean43 verbmemz6_mean44 verbmemz6_mean45 verbmemz6_mean46 verbmemz6_mean47 verbmemz6_mean48 verbmemz6_mean49 verbmemz6_mean50 verbmemz6_mean51 verbmemz6_mean52 verbmemz6_mean53 verbmemz6_mean54 verbmemz6_mean55 verbmemz6_mean56 verbmemz6_mean57 verbmemz6_mean58 verbmemz6_mean59 verbmemz6_mean60 verbmemz6_mean61 verbmemz6_mean62 verbmemz6_mean63 verbmemz6_mean64 verbmemz6_mean65 verbmemz6_mean66 verbmemz6_mean67 verbmemz6_mean68 verbmemz6_mean69 verbmemz6_mean70 verbmemz6_mean71 verbmemz6_mean72 verbmemz6_mean73 verbmemz6_mean74 verbmemz6_mean75 verbmemz6_mean76 verbmemz6_mean77 verbmemz6_mean78 verbmemz6_mean79 verbmemz6_mean80 verbmemz6_mean81 verbmemz6_mean82 verbmemz6_mean83 verbmemz6_mean84 verbmemz6_mean85 verbmemz6_mean86 verbmemz6_mean87 verbmemz6_mean88 verbmemz6_mean89 verbmemz6_mean90 verbmemz6_mean91 verbmemz6_mean92 verbmemz6_mean93 verbmemz6_mean94 verbmemz6_mean95 verbmemz6_mean96 verbmemz6_mean97 verbmemz6_mean98 verbmemz6_mean99 verbmemz6_mean100
tsline verbmemz6_mean1 verbmemz6_mean2 verbmemz6_mean3 verbmemz6_mean4 verbmemz6_mean5 verbmemz6_mean6 verbmemz6_mean7 verbmemz6_mean8 verbmemz6_mean9 verbmemz6_mean10 verbmemz6_mean11 verbmemz6_mean12 verbmemz6_mean13 verbmemz6_mean14 verbmemz6_mean15 verbmemz6_mean16 verbmemz6_mean17 verbmemz6_mean18 verbmemz6_mean19 verbmemz6_mean20 verbmemz6_mean21 verbmemz6_mean22 verbmemz6_mean23 verbmemz6_mean24 verbmemz6_mean25 verbmemz6_mean26 verbmemz6_mean27 verbmemz6_mean28 verbmemz6_mean29 verbmemz6_mean30 verbmemz6_mean31 verbmemz6_mean32 verbmemz6_mean33 verbmemz6_mean34 verbmemz6_mean35 verbmemz6_mean36 verbmemz6_mean37 verbmemz6_mean38 verbmemz6_mean39 verbmemz6_mean40 verbmemz6_mean41 verbmemz6_mean42 verbmemz6_mean43 verbmemz6_mean44 verbmemz6_mean45 verbmemz6_mean46 verbmemz6_mean47 verbmemz6_mean48 verbmemz6_mean49 verbmemz6_mean50 verbmemz6_mean51 verbmemz6_mean52 verbmemz6_mean53 verbmemz6_mean54 verbmemz6_mean55 verbmemz6_mean56 verbmemz6_mean57 verbmemz6_mean58 verbmemz6_mean59 verbmemz6_mean60 verbmemz6_mean61 verbmemz6_mean62 verbmemz6_mean63 verbmemz6_mean64 verbmemz6_mean65 verbmemz6_mean66 verbmemz6_mean67 verbmemz6_mean68 verbmemz6_mean69 verbmemz6_mean70 verbmemz6_mean71 verbmemz6_mean72 verbmemz6_mean73 verbmemz6_mean74 verbmemz6_mean75 verbmemz6_mean76 verbmemz6_mean77 verbmemz6_mean78 verbmemz6_mean79 verbmemz6_mean80 verbmemz6_mean81 verbmemz6_mean82 verbmemz6_mean83 verbmemz6_mean84 verbmemz6_mean85 verbmemz6_mean86 verbmemz6_mean87 verbmemz6_mean88 verbmemz6_mean89 verbmemz6_mean90 verbmemz6_mean91 verbmemz6_mean92 verbmemz6_mean93 verbmemz6_mean94 verbmemz6_mean95 verbmemz6_mean96 verbmemz6_mean97 verbmemz6_mean98 verbmemz6_mean99, ytitle("Mean of Verbal Memory")
tsline verbmemz6_sd1 verbmemz6_sd2 verbmemz6_sd3 verbmemz6_sd4 verbmemz6_sd5 verbmemz6_sd6 verbmemz6_sd7 verbmemz6_sd8 verbmemz6_sd9 verbmemz6_sd10 verbmemz6_sd11 verbmemz6_sd12 verbmemz6_sd13 verbmemz6_sd14 verbmemz6_sd15 verbmemz6_sd16 verbmemz6_sd17 verbmemz6_sd18 verbmemz6_sd19 verbmemz6_sd20 verbmemz6_sd21 verbmemz6_sd22 verbmemz6_sd23 verbmemz6_sd24 verbmemz6_sd25 verbmemz6_sd26 verbmemz6_sd27 verbmemz6_sd28 verbmemz6_sd29 verbmemz6_sd30 verbmemz6_sd31 verbmemz6_sd32 verbmemz6_sd33 verbmemz6_sd34 verbmemz6_sd35 verbmemz6_sd36 verbmemz6_sd37 verbmemz6_sd38 verbmemz6_sd39 verbmemz6_sd40 verbmemz6_sd41 verbmemz6_sd42 verbmemz6_sd43 verbmemz6_sd44 verbmemz6_sd45 verbmemz6_sd46 verbmemz6_sd47 verbmemz6_sd48 verbmemz6_sd49 verbmemz6_sd50 verbmemz6_sd51 verbmemz6_sd52 verbmemz6_sd53 verbmemz6_sd54 verbmemz6_sd55 verbmemz6_sd56 verbmemz6_sd57 verbmemz6_sd58 verbmemz6_sd59 verbmemz6_sd60 verbmemz6_sd61 verbmemz6_sd62 verbmemz6_sd63 verbmemz6_sd64 verbmemz6_sd65 verbmemz6_sd66 verbmemz6_sd67 verbmemz6_sd68 verbmemz6_sd69 verbmemz6_sd70 verbmemz6_sd71 verbmemz6_sd72 verbmemz6_sd73 verbmemz6_sd74 verbmemz6_sd75 verbmemz6_sd76 verbmemz6_sd77 verbmemz6_sd78 verbmemz6_sd79 verbmemz6_sd80 verbmemz6_sd81 verbmemz6_sd82 verbmemz6_sd83 verbmemz6_sd84 verbmemz6_sd85 verbmemz6_sd86 verbmemz6_sd87 verbmemz6_sd88 verbmemz6_sd89 verbmemz6_sd90 verbmemz6_sd91 verbmemz6_sd92 verbmemz6_sd93 verbmemz6_sd94 verbmemz6_sd95 verbmemz6_sd96 verbmemz6_sd97 verbmemz6_sd98 verbmemz6_sd99, ytitle("SD of Verbal Memory")

*tsline visuaspatintellz7_mean1 visuaspatintellz7_mean2 visuaspatintellz7_mean3 visuaspatintellz7_mean4 visuaspatintellz7_mean5 visuaspatintellz7_mean6 visuaspatintellz7_mean7 visuaspatintellz7_mean8 visuaspatintellz7_mean9 visuaspatintellz7_mean10 visuaspatintellz7_mean11 visuaspatintellz7_mean12 visuaspatintellz7_mean13 visuaspatintellz7_mean14 visuaspatintellz7_mean15 visuaspatintellz7_mean16 visuaspatintellz7_mean17 visuaspatintellz7_mean18 visuaspatintellz7_mean19 visuaspatintellz7_mean20 visuaspatintellz7_mean21 visuaspatintellz7_mean22 visuaspatintellz7_mean23 visuaspatintellz7_mean24 visuaspatintellz7_mean25 visuaspatintellz7_mean26 visuaspatintellz7_mean27 visuaspatintellz7_mean28 visuaspatintellz7_mean29 visuaspatintellz7_mean30 visuaspatintellz7_mean31 visuaspatintellz7_mean32 visuaspatintellz7_mean33 visuaspatintellz7_mean34 visuaspatintellz7_mean35 visuaspatintellz7_mean36 visuaspatintellz7_mean37 visuaspatintellz7_mean38 visuaspatintellz7_mean39 visuaspatintellz7_mean40 visuaspatintellz7_mean41 visuaspatintellz7_mean42 visuaspatintellz7_mean43 visuaspatintellz7_mean44 visuaspatintellz7_mean45 visuaspatintellz7_mean46 visuaspatintellz7_mean47 visuaspatintellz7_mean48 visuaspatintellz7_mean49 visuaspatintellz7_mean50 visuaspatintellz7_mean51 visuaspatintellz7_mean52 visuaspatintellz7_mean53 visuaspatintellz7_mean54 visuaspatintellz7_mean55 visuaspatintellz7_mean56 visuaspatintellz7_mean57 visuaspatintellz7_mean58 visuaspatintellz7_mean59 visuaspatintellz7_mean60 visuaspatintellz7_mean61 visuaspatintellz7_mean62 visuaspatintellz7_mean63 visuaspatintellz7_mean64 visuaspatintellz7_mean65 visuaspatintellz7_mean66 visuaspatintellz7_mean67 visuaspatintellz7_mean68 visuaspatintellz7_mean69 visuaspatintellz7_mean70 visuaspatintellz7_mean71 visuaspatintellz7_mean72 visuaspatintellz7_mean73 visuaspatintellz7_mean74 visuaspatintellz7_mean75 visuaspatintellz7_mean76 visuaspatintellz7_mean77 visuaspatintellz7_mean78 visuaspatintellz7_mean79 visuaspatintellz7_mean80 visuaspatintellz7_mean81 visuaspatintellz7_mean82 visuaspatintellz7_mean83 visuaspatintellz7_mean84 visuaspatintellz7_mean85 visuaspatintellz7_mean86 visuaspatintellz7_mean87 visuaspatintellz7_mean88 visuaspatintellz7_mean89 visuaspatintellz7_mean90 visuaspatintellz7_mean91 visuaspatintellz7_mean92 visuaspatintellz7_mean93 visuaspatintellz7_mean94 visuaspatintellz7_mean95 visuaspatintellz7_mean96 visuaspatintellz7_mean97 visuaspatintellz7_mean98 visuaspatintellz7_mean99 visuaspatintellz7_mean100
tsline visuaspatintellz7_mean1 visuaspatintellz7_mean2 visuaspatintellz7_mean3 visuaspatintellz7_mean4 visuaspatintellz7_mean5 visuaspatintellz7_mean6 visuaspatintellz7_mean7 visuaspatintellz7_mean8 visuaspatintellz7_mean9 visuaspatintellz7_mean10 visuaspatintellz7_mean11 visuaspatintellz7_mean12 visuaspatintellz7_mean13 visuaspatintellz7_mean14 visuaspatintellz7_mean15 visuaspatintellz7_mean16 visuaspatintellz7_mean17 visuaspatintellz7_mean18 visuaspatintellz7_mean19 visuaspatintellz7_mean20 visuaspatintellz7_mean21 visuaspatintellz7_mean22 visuaspatintellz7_mean23 visuaspatintellz7_mean24 visuaspatintellz7_mean25 visuaspatintellz7_mean26 visuaspatintellz7_mean27 visuaspatintellz7_mean28 visuaspatintellz7_mean29 visuaspatintellz7_mean30 visuaspatintellz7_mean31 visuaspatintellz7_mean32 visuaspatintellz7_mean33 visuaspatintellz7_mean34 visuaspatintellz7_mean35 visuaspatintellz7_mean36 visuaspatintellz7_mean37 visuaspatintellz7_mean38 visuaspatintellz7_mean39 visuaspatintellz7_mean40 visuaspatintellz7_mean41 visuaspatintellz7_mean42 visuaspatintellz7_mean43 visuaspatintellz7_mean44 visuaspatintellz7_mean45 visuaspatintellz7_mean46 visuaspatintellz7_mean47 visuaspatintellz7_mean48 visuaspatintellz7_mean49 visuaspatintellz7_mean50 visuaspatintellz7_mean51 visuaspatintellz7_mean52 visuaspatintellz7_mean53 visuaspatintellz7_mean54 visuaspatintellz7_mean55 visuaspatintellz7_mean56 visuaspatintellz7_mean57 visuaspatintellz7_mean58 visuaspatintellz7_mean59 visuaspatintellz7_mean60 visuaspatintellz7_mean61 visuaspatintellz7_mean62 visuaspatintellz7_mean63 visuaspatintellz7_mean64 visuaspatintellz7_mean65 visuaspatintellz7_mean66 visuaspatintellz7_mean67 visuaspatintellz7_mean68 visuaspatintellz7_mean69 visuaspatintellz7_mean70 visuaspatintellz7_mean71 visuaspatintellz7_mean72 visuaspatintellz7_mean73 visuaspatintellz7_mean74 visuaspatintellz7_mean75 visuaspatintellz7_mean76 visuaspatintellz7_mean77 visuaspatintellz7_mean78 visuaspatintellz7_mean79 visuaspatintellz7_mean80 visuaspatintellz7_mean81 visuaspatintellz7_mean82 visuaspatintellz7_mean83 visuaspatintellz7_mean84 visuaspatintellz7_mean85 visuaspatintellz7_mean86 visuaspatintellz7_mean87 visuaspatintellz7_mean88 visuaspatintellz7_mean89 visuaspatintellz7_mean90 visuaspatintellz7_mean91 visuaspatintellz7_mean92 visuaspatintellz7_mean93 visuaspatintellz7_mean94 visuaspatintellz7_mean95 visuaspatintellz7_mean96 visuaspatintellz7_mean97 visuaspatintellz7_mean98 visuaspatintellz7_mean99, ytitle("Mean of Visual-spatial intelligence")
tsline visuaspatintellz7_sd1 visuaspatintellz7_sd2 visuaspatintellz7_sd3 visuaspatintellz7_sd4 visuaspatintellz7_sd5 visuaspatintellz7_sd6 visuaspatintellz7_sd7 visuaspatintellz7_sd8 visuaspatintellz7_sd9 visuaspatintellz7_sd10 visuaspatintellz7_sd11 visuaspatintellz7_sd12 visuaspatintellz7_sd13 visuaspatintellz7_sd14 visuaspatintellz7_sd15 visuaspatintellz7_sd16 visuaspatintellz7_sd17 visuaspatintellz7_sd18 visuaspatintellz7_sd19 visuaspatintellz7_sd20 visuaspatintellz7_sd21 visuaspatintellz7_sd22 visuaspatintellz7_sd23 visuaspatintellz7_sd24 visuaspatintellz7_sd25 visuaspatintellz7_sd26 visuaspatintellz7_sd27 visuaspatintellz7_sd28 visuaspatintellz7_sd29 visuaspatintellz7_sd30 visuaspatintellz7_sd31 visuaspatintellz7_sd32 visuaspatintellz7_sd33 visuaspatintellz7_sd34 visuaspatintellz7_sd35 visuaspatintellz7_sd36 visuaspatintellz7_sd37 visuaspatintellz7_sd38 visuaspatintellz7_sd39 visuaspatintellz7_sd40 visuaspatintellz7_sd41 visuaspatintellz7_sd42 visuaspatintellz7_sd43 visuaspatintellz7_sd44 visuaspatintellz7_sd45 visuaspatintellz7_sd46 visuaspatintellz7_sd47 visuaspatintellz7_sd48 visuaspatintellz7_sd49 visuaspatintellz7_sd50 visuaspatintellz7_sd51 visuaspatintellz7_sd52 visuaspatintellz7_sd53 visuaspatintellz7_sd54 visuaspatintellz7_sd55 visuaspatintellz7_sd56 visuaspatintellz7_sd57 visuaspatintellz7_sd58 visuaspatintellz7_sd59 visuaspatintellz7_sd60 visuaspatintellz7_sd61 visuaspatintellz7_sd62 visuaspatintellz7_sd63 visuaspatintellz7_sd64 visuaspatintellz7_sd65 visuaspatintellz7_sd66 visuaspatintellz7_sd67 visuaspatintellz7_sd68 visuaspatintellz7_sd69 visuaspatintellz7_sd70 visuaspatintellz7_sd71 visuaspatintellz7_sd72 visuaspatintellz7_sd73 visuaspatintellz7_sd74 visuaspatintellz7_sd75 visuaspatintellz7_sd76 visuaspatintellz7_sd77 visuaspatintellz7_sd78 visuaspatintellz7_sd79 visuaspatintellz7_sd80 visuaspatintellz7_sd81 visuaspatintellz7_sd82 visuaspatintellz7_sd83 visuaspatintellz7_sd84 visuaspatintellz7_sd85 visuaspatintellz7_sd86 visuaspatintellz7_sd87 visuaspatintellz7_sd88 visuaspatintellz7_sd89 visuaspatintellz7_sd90 visuaspatintellz7_sd91 visuaspatintellz7_sd92 visuaspatintellz7_sd93 visuaspatintellz7_sd94 visuaspatintellz7_sd95 visuaspatintellz7_sd96 visuaspatintellz7_sd97 visuaspatintellz7_sd98 visuaspatintellz7_sd99, ytitle("SD of Visual-spatial intelligence")


*QQPlot 

qqplot execfunctionz1_mean1 execfunctionz1_mean100, name(g1)
qqplot  attenworkspeedz2_mean1  attenworkspeedz2_mean100, name(g2)
qqplot IQcogfuncz3_mean1 IQcogfuncz3_mean100, name(g3)
qqplot visualspatmemz4_mean1 visualspatmemz4_mean100, name(g4)
qqplot verbintellz5_mean1 verbintellz5_mean100, name(g5)
qqplot verbmemz6_mean1 verbmemz6_mean100, name(g6)
qqplot visuaspatintellz7_mean1 visuaspatintellz7_mean100, name(g7)

graph combine g1 g2 g3 g4 g5 g6 g7



qqplot execfunctionz1_sd1 execfunctionz1_sd100, name(s1)
qqplot  attenworkspeedz2_sd1  attenworkspeedz2_sd100, name(s2)
qqplot IQcogfuncz3_sd1 IQcogfuncz3_sd100, name(s3)
qqplot visualspatmemz4_sd1 visualspatmemz4_sd100, name(s4)
qqplot verbintellz5_sd1 verbintellz5_sd100, name(s5)
qqplot verbmemz6_sd1 verbmemz6_sd100, name(s6)
qqplot visuaspatintellz7_sd1 visuaspatintellz7_sd100, name(s7)

graph combine s1 s2 s3 s4 s5 s6 s7






*15 iterations model 

use new15imputations, replace
reshape wide *mean *sd, i(iter) j(m)
tsset iter
*convergence only allows to plot under 100 means, so the * ones are all 100, and the runable code is missing the 2nd mean estimation. However, check with Sophie in case this needs to be random?
*tsline execfunctionz1_mean1 execfunctionz1_mean5 execfunctionz1_mean10 execfunctionz1_mean15 execfunctionz1_mean20 execfunctionz1_mean25 execfunctionz1_mean30 execfunctionz1_mean35 execfunctionz1_mean40 execfunctionz1_mean45 execfunctionz1_mean50 execfunctionz1_mean55 execfunctionz1_mean60 execfunctionz1_mean65 execfunctionz1_mean70 execfunctionz1_mean75 execfunctionz1_mean80 execfunctionz1_mean85 execfunctionz1_mean90 execfunctionz1_mean95 execfunctionz1_mean100

*tsline execfunctionz1_mean1 execfunctionz1_mean2 execfunctionz1_mean3 execfunctionz1_mean4 execfunctionz1_mean5 execfunctionz1_mean6 execfunctionz1_mean7 execfunctionz1_mean8 execfunctionz1_mean9 execfunctionz1_mean10 execfunctionz1_mean11 execfunctionz1_mean12 execfunctionz1_mean13 execfunctionz1_mean14 execfunctionz1_mean15 execfunctionz1_mean16 execfunctionz1_mean17 execfunctionz1_mean18 execfunctionz1_mean19 execfunctionz1_mean20 execfunctionz1_mean21 execfunctionz1_mean22 execfunctionz1_mean23 execfunctionz1_mean24 execfunctionz1_mean25 execfunctionz1_mean26 execfunctionz1_mean27 execfunctionz1_mean28 execfunctionz1_mean29 execfunctionz1_mean30 execfunctionz1_mean31 execfunctionz1_mean32 execfunctionz1_mean33 execfunctionz1_mean34 execfunctionz1_mean35 execfunctionz1_mean36 execfunctionz1_mean37 execfunctionz1_mean38 execfunctionz1_mean39 execfunctionz1_mean40 execfunctionz1_mean41 execfunctionz1_mean42 execfunctionz1_mean43 execfunctionz1_mean44 execfunctionz1_mean45 execfunctionz1_mean46 execfunctionz1_mean47 execfunctionz1_mean48 execfunctionz1_mean49 execfunctionz1_mean50 execfunctionz1_mean51 execfunctionz1_mean52 execfunctionz1_mean53 execfunctionz1_mean54 execfunctionz1_mean55 execfunctionz1_mean56 execfunctionz1_mean57 execfunctionz1_mean58 execfunctionz1_mean59 execfunctionz1_mean60 execfunctionz1_mean61 execfunctionz1_mean62 execfunctionz1_mean63 execfunctionz1_mean64 execfunctionz1_mean65 execfunctionz1_mean66 execfunctionz1_mean67 execfunctionz1_mean68 execfunctionz1_mean69 execfunctionz1_mean70 execfunctionz1_mean71 execfunctionz1_mean72 execfunctionz1_mean73 execfunctionz1_mean74 execfunctionz1_mean75 execfunctionz1_mean76 execfunctionz1_mean77 execfunctionz1_mean78 execfunctionz1_mean79 execfunctionz1_mean80 execfunctionz1_mean81 execfunctionz1_mean82 execfunctionz1_mean83 execfunctionz1_mean84 execfunctionz1_mean85 execfunctionz1_mean86 execfunctionz1_mean87 execfunctionz1_mean88 execfunctionz1_mean89 execfunctionz1_mean90 execfunctionz1_mean91 execfunctionz1_mean92 execfunctionz1_mean93 execfunctionz1_mean94 execfunctionz1_mean95 execfunctionz1_mean96 execfunctionz1_mean97 execfunctionz1_mean98 execfunctionz1_mean99 execfunctionz1_mean100
tsline execfunctionz1_mean1  execfunctionz1_mean2 execfunctionz1_mean3 execfunctionz1_mean4 execfunctionz1_mean5 execfunctionz1_mean6 execfunctionz1_mean7 execfunctionz1_mean8 execfunctionz1_mean9 execfunctionz1_mean10 execfunctionz1_mean11 execfunctionz1_mean12 execfunctionz1_mean13 execfunctionz1_mean14 execfunctionz1_mean15 execfunctionz1_mean16 execfunctionz1_mean17 execfunctionz1_mean18 execfunctionz1_mean19 execfunctionz1_mean20 execfunctionz1_mean21 execfunctionz1_mean22 execfunctionz1_mean23 execfunctionz1_mean24 execfunctionz1_mean25 execfunctionz1_mean26 execfunctionz1_mean27 execfunctionz1_mean28 execfunctionz1_mean29 execfunctionz1_mean30 execfunctionz1_mean31 execfunctionz1_mean32 execfunctionz1_mean33 execfunctionz1_mean34 execfunctionz1_mean35 execfunctionz1_mean36 execfunctionz1_mean37 execfunctionz1_mean38 execfunctionz1_mean39 execfunctionz1_mean40 execfunctionz1_mean41 execfunctionz1_mean42 execfunctionz1_mean43 execfunctionz1_mean44 execfunctionz1_mean45 execfunctionz1_mean46 execfunctionz1_mean47 execfunctionz1_mean48 execfunctionz1_mean49 execfunctionz1_mean50 execfunctionz1_mean51 execfunctionz1_mean52 execfunctionz1_mean53 execfunctionz1_mean54 execfunctionz1_mean55 execfunctionz1_mean56 execfunctionz1_mean57 execfunctionz1_mean58 execfunctionz1_mean59 execfunctionz1_mean60 execfunctionz1_mean61 execfunctionz1_mean62 execfunctionz1_mean63 execfunctionz1_mean64 execfunctionz1_mean65 execfunctionz1_mean66 execfunctionz1_mean67 execfunctionz1_mean68 execfunctionz1_mean69 execfunctionz1_mean70 execfunctionz1_mean71 execfunctionz1_mean72 execfunctionz1_mean73 execfunctionz1_mean74 execfunctionz1_mean75 execfunctionz1_mean76 execfunctionz1_mean77 execfunctionz1_mean78 execfunctionz1_mean79 execfunctionz1_mean80 execfunctionz1_mean81 execfunctionz1_mean82 execfunctionz1_mean83 execfunctionz1_mean84 execfunctionz1_mean85 execfunctionz1_mean86 execfunctionz1_mean87 execfunctionz1_mean88 execfunctionz1_mean89 execfunctionz1_mean90 execfunctionz1_mean91 execfunctionz1_mean92 execfunctionz1_mean93 execfunctionz1_mean94 execfunctionz1_mean95 execfunctionz1_mean96 execfunctionz1_mean97 execfunctionz1_mean98 execfunctionz1_mean99, ytitle("Mean of Executive function")
tsline execfunctionz1_sd1 execfunctionz1_sd2 execfunctionz1_sd3 execfunctionz1_sd4 execfunctionz1_sd5 execfunctionz1_sd6 execfunctionz1_sd7 execfunctionz1_sd8 execfunctionz1_sd9 execfunctionz1_sd10 execfunctionz1_sd11 execfunctionz1_sd12 execfunctionz1_sd13 execfunctionz1_sd14 execfunctionz1_sd15 execfunctionz1_sd16 execfunctionz1_sd17 execfunctionz1_sd18 execfunctionz1_sd19 execfunctionz1_sd20 execfunctionz1_sd21 execfunctionz1_sd22 execfunctionz1_sd23 execfunctionz1_sd24 execfunctionz1_sd25 execfunctionz1_sd26 execfunctionz1_sd27 execfunctionz1_sd28 execfunctionz1_sd29 execfunctionz1_sd30 execfunctionz1_sd31 execfunctionz1_sd32 execfunctionz1_sd33 execfunctionz1_sd34 execfunctionz1_sd35 execfunctionz1_sd36 execfunctionz1_sd37 execfunctionz1_sd38 execfunctionz1_sd39 execfunctionz1_sd40 execfunctionz1_sd41 execfunctionz1_sd42 execfunctionz1_sd43 execfunctionz1_sd44 execfunctionz1_sd45 execfunctionz1_sd46 execfunctionz1_sd47 execfunctionz1_sd48 execfunctionz1_sd49 execfunctionz1_sd50 execfunctionz1_sd51 execfunctionz1_sd52 execfunctionz1_sd53 execfunctionz1_sd54 execfunctionz1_sd55 execfunctionz1_sd56 execfunctionz1_sd57 execfunctionz1_sd58 execfunctionz1_sd59 execfunctionz1_sd60 execfunctionz1_sd61 execfunctionz1_sd62 execfunctionz1_sd63 execfunctionz1_sd64 execfunctionz1_sd65 execfunctionz1_sd66 execfunctionz1_sd67 execfunctionz1_sd68 execfunctionz1_sd69 execfunctionz1_sd70 execfunctionz1_sd71 execfunctionz1_sd72 execfunctionz1_sd73 execfunctionz1_sd74 execfunctionz1_sd75 execfunctionz1_sd76 execfunctionz1_sd77 execfunctionz1_sd78 execfunctionz1_sd79 execfunctionz1_sd80 execfunctionz1_sd81 execfunctionz1_sd82 execfunctionz1_sd83 execfunctionz1_sd84 execfunctionz1_sd85 execfunctionz1_sd86 execfunctionz1_sd87 execfunctionz1_sd88 execfunctionz1_sd89 execfunctionz1_sd90 execfunctionz1_sd91 execfunctionz1_sd92 execfunctionz1_sd93 execfunctionz1_sd94 execfunctionz1_sd95 execfunctionz1_sd96 execfunctionz1_sd97 execfunctionz1_sd98 execfunctionz1_sd99, ytitle("SD of Ecexutive function")

*tsline attenworkspeedz2_mean1 attenworkspeedz2_mean2 attenworkspeedz2_mean3 attenworkspeedz2_mean4 attenworkspeedz2_mean5 attenworkspeedz2_mean6 attenworkspeedz2_mean7 attenworkspeedz2_mean8 attenworkspeedz2_mean9 attenworkspeedz2_mean10 attenworkspeedz2_mean11 attenworkspeedz2_mean12 attenworkspeedz2_mean13 attenworkspeedz2_mean14 attenworkspeedz2_mean15 attenworkspeedz2_mean16 attenworkspeedz2_mean17 attenworkspeedz2_mean18 attenworkspeedz2_mean19 attenworkspeedz2_mean20 attenworkspeedz2_mean21 attenworkspeedz2_mean22 attenworkspeedz2_mean23 attenworkspeedz2_mean24 attenworkspeedz2_mean25 attenworkspeedz2_mean26 attenworkspeedz2_mean27 attenworkspeedz2_mean28 attenworkspeedz2_mean29 attenworkspeedz2_mean30 attenworkspeedz2_mean31 attenworkspeedz2_mean32 attenworkspeedz2_mean33 attenworkspeedz2_mean34 attenworkspeedz2_mean35 attenworkspeedz2_mean36 attenworkspeedz2_mean37 attenworkspeedz2_mean38 attenworkspeedz2_mean39 attenworkspeedz2_mean40 attenworkspeedz2_mean41 attenworkspeedz2_mean42 attenworkspeedz2_mean43 attenworkspeedz2_mean44 attenworkspeedz2_mean45 attenworkspeedz2_mean46 attenworkspeedz2_mean47 attenworkspeedz2_mean48 attenworkspeedz2_mean49 attenworkspeedz2_mean50 attenworkspeedz2_mean51 attenworkspeedz2_mean52 attenworkspeedz2_mean53 attenworkspeedz2_mean54 attenworkspeedz2_mean55 attenworkspeedz2_mean56 attenworkspeedz2_mean57 attenworkspeedz2_mean58 attenworkspeedz2_mean59 attenworkspeedz2_mean60 attenworkspeedz2_mean61 attenworkspeedz2_mean62 attenworkspeedz2_mean63 attenworkspeedz2_mean64 attenworkspeedz2_mean65 attenworkspeedz2_mean66 attenworkspeedz2_mean67 attenworkspeedz2_mean68 attenworkspeedz2_mean69 attenworkspeedz2_mean70 attenworkspeedz2_mean71 attenworkspeedz2_mean72 attenworkspeedz2_mean73 attenworkspeedz2_mean74 attenworkspeedz2_mean75 attenworkspeedz2_mean76 attenworkspeedz2_mean77 attenworkspeedz2_mean78 attenworkspeedz2_mean79 attenworkspeedz2_mean80 attenworkspeedz2_mean81 attenworkspeedz2_mean82 attenworkspeedz2_mean83 attenworkspeedz2_mean84 attenworkspeedz2_mean85 attenworkspeedz2_mean86 attenworkspeedz2_mean87 attenworkspeedz2_mean88 attenworkspeedz2_mean89 attenworkspeedz2_mean90 attenworkspeedz2_mean91 attenworkspeedz2_mean92 attenworkspeedz2_mean93 attenworkspeedz2_mean94 attenworkspeedz2_mean95 attenworkspeedz2_mean96 attenworkspeedz2_mean97 attenworkspeedz2_mean98 attenworkspeedz2_mean99 attenworkspeedz2_mean100
tsline attenworkspeedz2_mean1 attenworkspeedz2_mean2 attenworkspeedz2_mean3 attenworkspeedz2_mean4 attenworkspeedz2_mean5 attenworkspeedz2_mean6 attenworkspeedz2_mean7 attenworkspeedz2_mean8 attenworkspeedz2_mean9 attenworkspeedz2_mean10 attenworkspeedz2_mean11 attenworkspeedz2_mean12 attenworkspeedz2_mean13 attenworkspeedz2_mean14 attenworkspeedz2_mean15 attenworkspeedz2_mean16 attenworkspeedz2_mean17 attenworkspeedz2_mean18 attenworkspeedz2_mean19 attenworkspeedz2_mean20 attenworkspeedz2_mean21 attenworkspeedz2_mean22 attenworkspeedz2_mean23 attenworkspeedz2_mean24 attenworkspeedz2_mean25 attenworkspeedz2_mean26 attenworkspeedz2_mean27 attenworkspeedz2_mean28 attenworkspeedz2_mean29 attenworkspeedz2_mean30 attenworkspeedz2_mean31 attenworkspeedz2_mean32 attenworkspeedz2_mean33 attenworkspeedz2_mean34 attenworkspeedz2_mean35 attenworkspeedz2_mean36 attenworkspeedz2_mean37 attenworkspeedz2_mean38 attenworkspeedz2_mean39 attenworkspeedz2_mean40 attenworkspeedz2_mean41 attenworkspeedz2_mean42 attenworkspeedz2_mean43 attenworkspeedz2_mean44 attenworkspeedz2_mean45 attenworkspeedz2_mean46 attenworkspeedz2_mean47 attenworkspeedz2_mean48 attenworkspeedz2_mean49 attenworkspeedz2_mean50 attenworkspeedz2_mean51 attenworkspeedz2_mean52 attenworkspeedz2_mean53 attenworkspeedz2_mean54 attenworkspeedz2_mean55 attenworkspeedz2_mean56 attenworkspeedz2_mean57 attenworkspeedz2_mean58 attenworkspeedz2_mean59 attenworkspeedz2_mean60 attenworkspeedz2_mean61 attenworkspeedz2_mean62 attenworkspeedz2_mean63 attenworkspeedz2_mean64 attenworkspeedz2_mean65 attenworkspeedz2_mean66 attenworkspeedz2_mean67 attenworkspeedz2_mean68 attenworkspeedz2_mean69 attenworkspeedz2_mean70 attenworkspeedz2_mean71 attenworkspeedz2_mean72 attenworkspeedz2_mean73 attenworkspeedz2_mean74 attenworkspeedz2_mean75 attenworkspeedz2_mean76 attenworkspeedz2_mean77 attenworkspeedz2_mean78 attenworkspeedz2_mean79 attenworkspeedz2_mean80 attenworkspeedz2_mean81 attenworkspeedz2_mean82 attenworkspeedz2_mean83 attenworkspeedz2_mean84 attenworkspeedz2_mean85 attenworkspeedz2_mean86 attenworkspeedz2_mean87 attenworkspeedz2_mean88 attenworkspeedz2_mean89 attenworkspeedz2_mean90 attenworkspeedz2_mean91 attenworkspeedz2_mean92 attenworkspeedz2_mean93 attenworkspeedz2_mean94 attenworkspeedz2_mean95 attenworkspeedz2_mean96 attenworkspeedz2_mean97 attenworkspeedz2_mean98 attenworkspeedz2_mean99, ytitle("Mean of Attention, wokring memory & processing speed")
tsline attenworkspeedz2_sd1 attenworkspeedz2_sd2 attenworkspeedz2_sd3 attenworkspeedz2_sd4 attenworkspeedz2_sd5 attenworkspeedz2_sd6 attenworkspeedz2_sd7 attenworkspeedz2_sd8 attenworkspeedz2_sd9 attenworkspeedz2_sd10 attenworkspeedz2_sd11 attenworkspeedz2_sd12 attenworkspeedz2_sd13 attenworkspeedz2_sd14 attenworkspeedz2_sd15 attenworkspeedz2_sd16 attenworkspeedz2_sd17 attenworkspeedz2_sd18 attenworkspeedz2_sd19 attenworkspeedz2_sd20 attenworkspeedz2_sd21 attenworkspeedz2_sd22 attenworkspeedz2_sd23 attenworkspeedz2_sd24 attenworkspeedz2_sd25 attenworkspeedz2_sd26 attenworkspeedz2_sd27 attenworkspeedz2_sd28 attenworkspeedz2_sd29 attenworkspeedz2_sd30 attenworkspeedz2_sd31 attenworkspeedz2_sd32 attenworkspeedz2_sd33 attenworkspeedz2_sd34 attenworkspeedz2_sd35 attenworkspeedz2_sd36 attenworkspeedz2_sd37 attenworkspeedz2_sd38 attenworkspeedz2_sd39 attenworkspeedz2_sd40 attenworkspeedz2_sd41 attenworkspeedz2_sd42 attenworkspeedz2_sd43 attenworkspeedz2_sd44 attenworkspeedz2_sd45 attenworkspeedz2_sd46 attenworkspeedz2_sd47 attenworkspeedz2_sd48 attenworkspeedz2_sd49 attenworkspeedz2_sd50 attenworkspeedz2_sd51 attenworkspeedz2_sd52 attenworkspeedz2_sd53 attenworkspeedz2_sd54 attenworkspeedz2_sd55 attenworkspeedz2_sd56 attenworkspeedz2_sd57 attenworkspeedz2_sd58 attenworkspeedz2_sd59 attenworkspeedz2_sd60 attenworkspeedz2_sd61 attenworkspeedz2_sd62 attenworkspeedz2_sd63 attenworkspeedz2_sd64 attenworkspeedz2_sd65 attenworkspeedz2_sd66 attenworkspeedz2_sd67 attenworkspeedz2_sd68 attenworkspeedz2_sd69 attenworkspeedz2_sd70 attenworkspeedz2_sd71 attenworkspeedz2_sd72 attenworkspeedz2_sd73 attenworkspeedz2_sd74 attenworkspeedz2_sd75 attenworkspeedz2_sd76 attenworkspeedz2_sd77 attenworkspeedz2_sd78 attenworkspeedz2_sd79 attenworkspeedz2_sd80 attenworkspeedz2_sd81 attenworkspeedz2_sd82 attenworkspeedz2_sd83 attenworkspeedz2_sd84 attenworkspeedz2_sd85 attenworkspeedz2_sd86 attenworkspeedz2_sd87 attenworkspeedz2_sd88 attenworkspeedz2_sd89 attenworkspeedz2_sd90 attenworkspeedz2_sd91 attenworkspeedz2_sd92 attenworkspeedz2_sd93 attenworkspeedz2_sd94 attenworkspeedz2_sd95 attenworkspeedz2_sd96 attenworkspeedz2_sd97 attenworkspeedz2_sd98 attenworkspeedz2_sd99, ytitle("SD of Attention, wokring memory & processing speed")


*tsline IQcogfuncz3_mean1 IQcogfuncz3_mean2 IQcogfuncz3_mean3 IQcogfuncz3_mean4 IQcogfuncz3_mean5 IQcogfuncz3_mean6 IQcogfuncz3_mean7 IQcogfuncz3_mean8 IQcogfuncz3_mean9 IQcogfuncz3_mean10 IQcogfuncz3_mean11 IQcogfuncz3_mean12 IQcogfuncz3_mean13 IQcogfuncz3_mean14 IQcogfuncz3_mean15 IQcogfuncz3_mean16 IQcogfuncz3_mean17 IQcogfuncz3_mean18 IQcogfuncz3_mean19 IQcogfuncz3_mean20 IQcogfuncz3_mean21 IQcogfuncz3_mean22 IQcogfuncz3_mean23 IQcogfuncz3_mean24 IQcogfuncz3_mean25 IQcogfuncz3_mean26 IQcogfuncz3_mean27 IQcogfuncz3_mean28 IQcogfuncz3_mean29 IQcogfuncz3_mean30 IQcogfuncz3_mean31 IQcogfuncz3_mean32 IQcogfuncz3_mean33 IQcogfuncz3_mean34 IQcogfuncz3_mean35 IQcogfuncz3_mean36 IQcogfuncz3_mean37 IQcogfuncz3_mean38 IQcogfuncz3_mean39 IQcogfuncz3_mean40 IQcogfuncz3_mean41 IQcogfuncz3_mean42 IQcogfuncz3_mean43 IQcogfuncz3_mean44 IQcogfuncz3_mean45 IQcogfuncz3_mean46 IQcogfuncz3_mean47 IQcogfuncz3_mean48 IQcogfuncz3_mean49 IQcogfuncz3_mean50 IQcogfuncz3_mean51 IQcogfuncz3_mean52 IQcogfuncz3_mean53 IQcogfuncz3_mean54 IQcogfuncz3_mean55 IQcogfuncz3_mean56 IQcogfuncz3_mean57 IQcogfuncz3_mean58 IQcogfuncz3_mean59 IQcogfuncz3_mean60 IQcogfuncz3_mean61 IQcogfuncz3_mean62 IQcogfuncz3_mean63 IQcogfuncz3_mean64 IQcogfuncz3_mean65 IQcogfuncz3_mean66 IQcogfuncz3_mean67 IQcogfuncz3_mean68 IQcogfuncz3_mean69 IQcogfuncz3_mean70 IQcogfuncz3_mean71 IQcogfuncz3_mean72 IQcogfuncz3_mean73 IQcogfuncz3_mean74 IQcogfuncz3_mean75 IQcogfuncz3_mean76 IQcogfuncz3_mean77 IQcogfuncz3_mean78 IQcogfuncz3_mean79 IQcogfuncz3_mean80 IQcogfuncz3_mean81 IQcogfuncz3_mean82 IQcogfuncz3_mean83 IQcogfuncz3_mean84 IQcogfuncz3_mean85 IQcogfuncz3_mean86 IQcogfuncz3_mean87 IQcogfuncz3_mean88 IQcogfuncz3_mean89 IQcogfuncz3_mean90 IQcogfuncz3_mean91 IQcogfuncz3_mean92 IQcogfuncz3_mean93 IQcogfuncz3_mean94 IQcogfuncz3_mean95 IQcogfuncz3_mean96 IQcogfuncz3_mean97 IQcogfuncz3_mean98 IQcogfuncz3_mean99 IQcogfuncz3_mean100
tsline IQcogfuncz3_mean1  IQcogfuncz3_mean2 IQcogfuncz3_mean3 IQcogfuncz3_mean4 IQcogfuncz3_mean5 IQcogfuncz3_mean6 IQcogfuncz3_mean7 IQcogfuncz3_mean8 IQcogfuncz3_mean9 IQcogfuncz3_mean10 IQcogfuncz3_mean11 IQcogfuncz3_mean12 IQcogfuncz3_mean13 IQcogfuncz3_mean14 IQcogfuncz3_mean15 IQcogfuncz3_mean16 IQcogfuncz3_mean17 IQcogfuncz3_mean18 IQcogfuncz3_mean19 IQcogfuncz3_mean20 IQcogfuncz3_mean21 IQcogfuncz3_mean22 IQcogfuncz3_mean23 IQcogfuncz3_mean24 IQcogfuncz3_mean25 IQcogfuncz3_mean26 IQcogfuncz3_mean27 IQcogfuncz3_mean28 IQcogfuncz3_mean29 IQcogfuncz3_mean30 IQcogfuncz3_mean31 IQcogfuncz3_mean32 IQcogfuncz3_mean33 IQcogfuncz3_mean34 IQcogfuncz3_mean35 IQcogfuncz3_mean36 IQcogfuncz3_mean37 IQcogfuncz3_mean38 IQcogfuncz3_mean39 IQcogfuncz3_mean40 IQcogfuncz3_mean41 IQcogfuncz3_mean42 IQcogfuncz3_mean43 IQcogfuncz3_mean44 IQcogfuncz3_mean45 IQcogfuncz3_mean46 IQcogfuncz3_mean47 IQcogfuncz3_mean48 IQcogfuncz3_mean49 IQcogfuncz3_mean50 IQcogfuncz3_mean51 IQcogfuncz3_mean52 IQcogfuncz3_mean53 IQcogfuncz3_mean54 IQcogfuncz3_mean55 IQcogfuncz3_mean56 IQcogfuncz3_mean57 IQcogfuncz3_mean58 IQcogfuncz3_mean59 IQcogfuncz3_mean60 IQcogfuncz3_mean61 IQcogfuncz3_mean62 IQcogfuncz3_mean63 IQcogfuncz3_mean64 IQcogfuncz3_mean65 IQcogfuncz3_mean66 IQcogfuncz3_mean67 IQcogfuncz3_mean68 IQcogfuncz3_mean69 IQcogfuncz3_mean70 IQcogfuncz3_mean71 IQcogfuncz3_mean72 IQcogfuncz3_mean73 IQcogfuncz3_mean74 IQcogfuncz3_mean75 IQcogfuncz3_mean76 IQcogfuncz3_mean77 IQcogfuncz3_mean78 IQcogfuncz3_mean79 IQcogfuncz3_mean80 IQcogfuncz3_mean81 IQcogfuncz3_mean82 IQcogfuncz3_mean83 IQcogfuncz3_mean84 IQcogfuncz3_mean85 IQcogfuncz3_mean86 IQcogfuncz3_mean87 IQcogfuncz3_mean88 IQcogfuncz3_mean89 IQcogfuncz3_mean90 IQcogfuncz3_mean91 IQcogfuncz3_mean92 IQcogfuncz3_mean93 IQcogfuncz3_mean94 IQcogfuncz3_mean95 IQcogfuncz3_mean96 IQcogfuncz3_mean97 IQcogfuncz3_mean98 IQcogfuncz3_mean99, ytitle(Mean of IQ/general congnitive function)
tsline IQcogfuncz3_sd1  IQcogfuncz3_sd2 IQcogfuncz3_sd3 IQcogfuncz3_sd4 IQcogfuncz3_sd5 IQcogfuncz3_sd6 IQcogfuncz3_sd7 IQcogfuncz3_sd8 IQcogfuncz3_sd9 IQcogfuncz3_sd10 IQcogfuncz3_sd11 IQcogfuncz3_sd12 IQcogfuncz3_sd13 IQcogfuncz3_sd14 IQcogfuncz3_sd15 IQcogfuncz3_sd16 IQcogfuncz3_sd17 IQcogfuncz3_sd18 IQcogfuncz3_sd19 IQcogfuncz3_sd20 IQcogfuncz3_sd21 IQcogfuncz3_sd22 IQcogfuncz3_sd23 IQcogfuncz3_sd24 IQcogfuncz3_sd25 IQcogfuncz3_sd26 IQcogfuncz3_sd27 IQcogfuncz3_sd28 IQcogfuncz3_sd29 IQcogfuncz3_sd30 IQcogfuncz3_sd31 IQcogfuncz3_sd32 IQcogfuncz3_sd33 IQcogfuncz3_sd34 IQcogfuncz3_sd35 IQcogfuncz3_sd36 IQcogfuncz3_sd37 IQcogfuncz3_sd38 IQcogfuncz3_sd39 IQcogfuncz3_sd40 IQcogfuncz3_sd41 IQcogfuncz3_sd42 IQcogfuncz3_sd43 IQcogfuncz3_sd44 IQcogfuncz3_sd45 IQcogfuncz3_sd46 IQcogfuncz3_sd47 IQcogfuncz3_sd48 IQcogfuncz3_sd49 IQcogfuncz3_sd50 IQcogfuncz3_sd51 IQcogfuncz3_sd52 IQcogfuncz3_sd53 IQcogfuncz3_sd54 IQcogfuncz3_sd55 IQcogfuncz3_sd56 IQcogfuncz3_sd57 IQcogfuncz3_sd58 IQcogfuncz3_sd59 IQcogfuncz3_sd60 IQcogfuncz3_sd61 IQcogfuncz3_sd62 IQcogfuncz3_sd63 IQcogfuncz3_sd64 IQcogfuncz3_sd65 IQcogfuncz3_sd66 IQcogfuncz3_sd67 IQcogfuncz3_sd68 IQcogfuncz3_sd69 IQcogfuncz3_sd70 IQcogfuncz3_sd71 IQcogfuncz3_sd72 IQcogfuncz3_sd73 IQcogfuncz3_sd74 IQcogfuncz3_sd75 IQcogfuncz3_sd76 IQcogfuncz3_sd77 IQcogfuncz3_sd78 IQcogfuncz3_sd79 IQcogfuncz3_sd80 IQcogfuncz3_sd81 IQcogfuncz3_sd82 IQcogfuncz3_sd83 IQcogfuncz3_sd84 IQcogfuncz3_sd85 IQcogfuncz3_sd86 IQcogfuncz3_sd87 IQcogfuncz3_sd88 IQcogfuncz3_sd89 IQcogfuncz3_sd90 IQcogfuncz3_sd91 IQcogfuncz3_sd92 IQcogfuncz3_sd93 IQcogfuncz3_sd94 IQcogfuncz3_sd95 IQcogfuncz3_sd96 IQcogfuncz3_sd97 IQcogfuncz3_sd98 IQcogfuncz3_sd99, ytitle(SD of IQ/general cognitive function)

*tsline visualspatmemz4_mean1 visualspatmemz4_mean2 visualspatmemz4_mean3 visualspatmemz4_mean4 visualspatmemz4_mean5 visualspatmemz4_mean6 visualspatmemz4_mean7 visualspatmemz4_mean8 visualspatmemz4_mean9 visualspatmemz4_mean10 visualspatmemz4_mean11 visualspatmemz4_mean12 visualspatmemz4_mean13 visualspatmemz4_mean14 visualspatmemz4_mean15 visualspatmemz4_mean16 visualspatmemz4_mean17 visualspatmemz4_mean18 visualspatmemz4_mean19 visualspatmemz4_mean20 visualspatmemz4_mean21 visualspatmemz4_mean22 visualspatmemz4_mean23 visualspatmemz4_mean24 visualspatmemz4_mean25 visualspatmemz4_mean26 visualspatmemz4_mean27 visualspatmemz4_mean28 visualspatmemz4_mean29 visualspatmemz4_mean30 visualspatmemz4_mean31 visualspatmemz4_mean32 visualspatmemz4_mean33 visualspatmemz4_mean34 visualspatmemz4_mean35 visualspatmemz4_mean36 visualspatmemz4_mean37 visualspatmemz4_mean38 visualspatmemz4_mean39 visualspatmemz4_mean40 visualspatmemz4_mean41 visualspatmemz4_mean42 visualspatmemz4_mean43 visualspatmemz4_mean44 visualspatmemz4_mean45 visualspatmemz4_mean46 visualspatmemz4_mean47 visualspatmemz4_mean48 visualspatmemz4_mean49 visualspatmemz4_mean50 visualspatmemz4_mean51 visualspatmemz4_mean52 visualspatmemz4_mean53 visualspatmemz4_mean54 visualspatmemz4_mean55 visualspatmemz4_mean56 visualspatmemz4_mean57 visualspatmemz4_mean58 visualspatmemz4_mean59 visualspatmemz4_mean60 visualspatmemz4_mean61 visualspatmemz4_mean62 visualspatmemz4_mean63 visualspatmemz4_mean64 visualspatmemz4_mean65 visualspatmemz4_mean66 visualspatmemz4_mean67 visualspatmemz4_mean68 visualspatmemz4_mean69 visualspatmemz4_mean70 visualspatmemz4_mean71 visualspatmemz4_mean72 visualspatmemz4_mean73 visualspatmemz4_mean74 visualspatmemz4_mean75 visualspatmemz4_mean76 visualspatmemz4_mean77 visualspatmemz4_mean78 visualspatmemz4_mean79 visualspatmemz4_mean80 visualspatmemz4_mean81 visualspatmemz4_mean82 visualspatmemz4_mean83 visualspatmemz4_mean84 visualspatmemz4_mean85 visualspatmemz4_mean86 visualspatmemz4_mean87 visualspatmemz4_mean88 visualspatmemz4_mean89 visualspatmemz4_mean90 visualspatmemz4_mean91 visualspatmemz4_mean92 visualspatmemz4_mean93 visualspatmemz4_mean94 visualspatmemz4_mean95 visualspatmemz4_mean96 visualspatmemz4_mean97 visualspatmemz4_mean98 visualspatmemz4_mean99 visualspatmemz4_mean100
tsline visualspatmemz4_mean1 visualspatmemz4_mean2 visualspatmemz4_mean3 visualspatmemz4_mean4 visualspatmemz4_mean5 visualspatmemz4_mean6 visualspatmemz4_mean7 visualspatmemz4_mean8 visualspatmemz4_mean9 visualspatmemz4_mean10 visualspatmemz4_mean11 visualspatmemz4_mean12 visualspatmemz4_mean13 visualspatmemz4_mean14 visualspatmemz4_mean15 visualspatmemz4_mean16 visualspatmemz4_mean17 visualspatmemz4_mean18 visualspatmemz4_mean19 visualspatmemz4_mean20 visualspatmemz4_mean21 visualspatmemz4_mean22 visualspatmemz4_mean23 visualspatmemz4_mean24 visualspatmemz4_mean25 visualspatmemz4_mean26 visualspatmemz4_mean27 visualspatmemz4_mean28 visualspatmemz4_mean29 visualspatmemz4_mean30 visualspatmemz4_mean31 visualspatmemz4_mean32 visualspatmemz4_mean33 visualspatmemz4_mean34 visualspatmemz4_mean35 visualspatmemz4_mean36 visualspatmemz4_mean37 visualspatmemz4_mean38 visualspatmemz4_mean39 visualspatmemz4_mean40 visualspatmemz4_mean41 visualspatmemz4_mean42 visualspatmemz4_mean43 visualspatmemz4_mean44 visualspatmemz4_mean45 visualspatmemz4_mean46 visualspatmemz4_mean47 visualspatmemz4_mean48 visualspatmemz4_mean49 visualspatmemz4_mean50 visualspatmemz4_mean51 visualspatmemz4_mean52 visualspatmemz4_mean53 visualspatmemz4_mean54 visualspatmemz4_mean55 visualspatmemz4_mean56 visualspatmemz4_mean57 visualspatmemz4_mean58 visualspatmemz4_mean59 visualspatmemz4_mean60 visualspatmemz4_mean61 visualspatmemz4_mean62 visualspatmemz4_mean63 visualspatmemz4_mean64 visualspatmemz4_mean65 visualspatmemz4_mean66 visualspatmemz4_mean67 visualspatmemz4_mean68 visualspatmemz4_mean69 visualspatmemz4_mean70 visualspatmemz4_mean71 visualspatmemz4_mean72 visualspatmemz4_mean73 visualspatmemz4_mean74 visualspatmemz4_mean75 visualspatmemz4_mean76 visualspatmemz4_mean77 visualspatmemz4_mean78 visualspatmemz4_mean79 visualspatmemz4_mean80 visualspatmemz4_mean81 visualspatmemz4_mean82 visualspatmemz4_mean83 visualspatmemz4_mean84 visualspatmemz4_mean85 visualspatmemz4_mean86 visualspatmemz4_mean87 visualspatmemz4_mean88 visualspatmemz4_mean89 visualspatmemz4_mean90 visualspatmemz4_mean91 visualspatmemz4_mean92 visualspatmemz4_mean93 visualspatmemz4_mean94 visualspatmemz4_mean95 visualspatmemz4_mean96 visualspatmemz4_mean97 visualspatmemz4_mean98 visualspatmemz4_mean99, ytitle("Mean of Visual-spatial memory")
tsline visualspatmemz4_sd1 visualspatmemz4_sd2 visualspatmemz4_sd3 visualspatmemz4_sd4 visualspatmemz4_sd5 visualspatmemz4_sd6 visualspatmemz4_sd7 visualspatmemz4_sd8 visualspatmemz4_sd9 visualspatmemz4_sd10 visualspatmemz4_sd11 visualspatmemz4_sd12 visualspatmemz4_sd13 visualspatmemz4_sd14 visualspatmemz4_sd15 visualspatmemz4_sd16 visualspatmemz4_sd17 visualspatmemz4_sd18 visualspatmemz4_sd19 visualspatmemz4_sd20 visualspatmemz4_sd21 visualspatmemz4_sd22 visualspatmemz4_sd23 visualspatmemz4_sd24 visualspatmemz4_sd25 visualspatmemz4_sd26 visualspatmemz4_sd27 visualspatmemz4_sd28 visualspatmemz4_sd29 visualspatmemz4_sd30 visualspatmemz4_sd31 visualspatmemz4_sd32 visualspatmemz4_sd33 visualspatmemz4_sd34 visualspatmemz4_sd35 visualspatmemz4_sd36 visualspatmemz4_sd37 visualspatmemz4_sd38 visualspatmemz4_sd39 visualspatmemz4_sd40 visualspatmemz4_sd41 visualspatmemz4_sd42 visualspatmemz4_sd43 visualspatmemz4_sd44 visualspatmemz4_sd45 visualspatmemz4_sd46 visualspatmemz4_sd47 visualspatmemz4_sd48 visualspatmemz4_sd49 visualspatmemz4_sd50 visualspatmemz4_sd51 visualspatmemz4_sd52 visualspatmemz4_sd53 visualspatmemz4_sd54 visualspatmemz4_sd55 visualspatmemz4_sd56 visualspatmemz4_sd57 visualspatmemz4_sd58 visualspatmemz4_sd59 visualspatmemz4_sd60 visualspatmemz4_sd61 visualspatmemz4_sd62 visualspatmemz4_sd63 visualspatmemz4_sd64 visualspatmemz4_sd65 visualspatmemz4_sd66 visualspatmemz4_sd67 visualspatmemz4_sd68 visualspatmemz4_sd69 visualspatmemz4_sd70 visualspatmemz4_sd71 visualspatmemz4_sd72 visualspatmemz4_sd73 visualspatmemz4_sd74 visualspatmemz4_sd75 visualspatmemz4_sd76 visualspatmemz4_sd77 visualspatmemz4_sd78 visualspatmemz4_sd79 visualspatmemz4_sd80 visualspatmemz4_sd81 visualspatmemz4_sd82 visualspatmemz4_sd83 visualspatmemz4_sd84 visualspatmemz4_sd85 visualspatmemz4_sd86 visualspatmemz4_sd87 visualspatmemz4_sd88 visualspatmemz4_sd89 visualspatmemz4_sd90 visualspatmemz4_sd91 visualspatmemz4_sd92 visualspatmemz4_sd93 visualspatmemz4_sd94 visualspatmemz4_sd95 visualspatmemz4_sd96 visualspatmemz4_sd97 visualspatmemz4_sd98 visualspatmemz4_sd99, ytitle("SD of Visual-spatial memory")

*tsline verbintellz5_mean1 verbintellz5_mean2 verbintellz5_mean3 verbintellz5_mean4 verbintellz5_mean5 verbintellz5_mean6 verbintellz5_mean7 verbintellz5_mean8 verbintellz5_mean9 verbintellz5_mean10 verbintellz5_mean11 verbintellz5_mean12 verbintellz5_mean13 verbintellz5_mean14 verbintellz5_mean15 verbintellz5_mean16 verbintellz5_mean17 verbintellz5_mean18 verbintellz5_mean19 verbintellz5_mean20 verbintellz5_mean21 verbintellz5_mean22 verbintellz5_mean23 verbintellz5_mean24 verbintellz5_mean25 verbintellz5_mean26 verbintellz5_mean27 verbintellz5_mean28 verbintellz5_mean29 verbintellz5_mean30 verbintellz5_mean31 verbintellz5_mean32 verbintellz5_mean33 verbintellz5_mean34 verbintellz5_mean35 verbintellz5_mean36 verbintellz5_mean37 verbintellz5_mean38 verbintellz5_mean39 verbintellz5_mean40 verbintellz5_mean41 verbintellz5_mean42 verbintellz5_mean43 verbintellz5_mean44 verbintellz5_mean45 verbintellz5_mean46 verbintellz5_mean47 verbintellz5_mean48 verbintellz5_mean49 verbintellz5_mean50 verbintellz5_mean51 verbintellz5_mean52 verbintellz5_mean53 verbintellz5_mean54 verbintellz5_mean55 verbintellz5_mean56 verbintellz5_mean57 verbintellz5_mean58 verbintellz5_mean59 verbintellz5_mean60 verbintellz5_mean61 verbintellz5_mean62 verbintellz5_mean63 verbintellz5_mean64 verbintellz5_mean65 verbintellz5_mean66 verbintellz5_mean67 verbintellz5_mean68 verbintellz5_mean69 verbintellz5_mean70 verbintellz5_mean71 verbintellz5_mean72 verbintellz5_mean73 verbintellz5_mean74 verbintellz5_mean75 verbintellz5_mean76 verbintellz5_mean77 verbintellz5_mean78 verbintellz5_mean79 verbintellz5_mean80 verbintellz5_mean81 verbintellz5_mean82 verbintellz5_mean83 verbintellz5_mean84 verbintellz5_mean85 verbintellz5_mean86 verbintellz5_mean87 verbintellz5_mean88 verbintellz5_mean89 verbintellz5_mean90 verbintellz5_mean91 verbintellz5_mean92 verbintellz5_mean93 verbintellz5_mean94 verbintellz5_mean95 verbintellz5_mean96 verbintellz5_mean97 verbintellz5_mean98 verbintellz5_mean99 verbintellz5_mean100
tsline verbintellz5_mean1 verbintellz5_mean2 verbintellz5_mean3 verbintellz5_mean4 verbintellz5_mean5 verbintellz5_mean6 verbintellz5_mean7 verbintellz5_mean8 verbintellz5_mean9 verbintellz5_mean10 verbintellz5_mean11 verbintellz5_mean12 verbintellz5_mean13 verbintellz5_mean14 verbintellz5_mean15 verbintellz5_mean16 verbintellz5_mean17 verbintellz5_mean18 verbintellz5_mean19 verbintellz5_mean20 verbintellz5_mean21 verbintellz5_mean22 verbintellz5_mean23 verbintellz5_mean24 verbintellz5_mean25 verbintellz5_mean26 verbintellz5_mean27 verbintellz5_mean28 verbintellz5_mean29 verbintellz5_mean30 verbintellz5_mean31 verbintellz5_mean32 verbintellz5_mean33 verbintellz5_mean34 verbintellz5_mean35 verbintellz5_mean36 verbintellz5_mean37 verbintellz5_mean38 verbintellz5_mean39 verbintellz5_mean40 verbintellz5_mean41 verbintellz5_mean42 verbintellz5_mean43 verbintellz5_mean44 verbintellz5_mean45 verbintellz5_mean46 verbintellz5_mean47 verbintellz5_mean48 verbintellz5_mean49 verbintellz5_mean50 verbintellz5_mean51 verbintellz5_mean52 verbintellz5_mean53 verbintellz5_mean54 verbintellz5_mean55 verbintellz5_mean56 verbintellz5_mean57 verbintellz5_mean58 verbintellz5_mean59 verbintellz5_mean60 verbintellz5_mean61 verbintellz5_mean62 verbintellz5_mean63 verbintellz5_mean64 verbintellz5_mean65 verbintellz5_mean66 verbintellz5_mean67 verbintellz5_mean68 verbintellz5_mean69 verbintellz5_mean70 verbintellz5_mean71 verbintellz5_mean72 verbintellz5_mean73 verbintellz5_mean74 verbintellz5_mean75 verbintellz5_mean76 verbintellz5_mean77 verbintellz5_mean78 verbintellz5_mean79 verbintellz5_mean80 verbintellz5_mean81 verbintellz5_mean82 verbintellz5_mean83 verbintellz5_mean84 verbintellz5_mean85 verbintellz5_mean86 verbintellz5_mean87 verbintellz5_mean88 verbintellz5_mean89 verbintellz5_mean90 verbintellz5_mean91 verbintellz5_mean92 verbintellz5_mean93 verbintellz5_mean94 verbintellz5_mean95 verbintellz5_mean96 verbintellz5_mean97 verbintellz5_mean98 verbintellz5_mean99, ytitle("Mean of Verbal Intelligence")
tsline verbintellz5_sd1 verbintellz5_sd2 verbintellz5_sd3 verbintellz5_sd4 verbintellz5_sd5 verbintellz5_sd6 verbintellz5_sd7 verbintellz5_sd8 verbintellz5_sd9 verbintellz5_sd10 verbintellz5_sd11 verbintellz5_sd12 verbintellz5_sd13 verbintellz5_sd14 verbintellz5_sd15 verbintellz5_sd16 verbintellz5_sd17 verbintellz5_sd18 verbintellz5_sd19 verbintellz5_sd20 verbintellz5_sd21 verbintellz5_sd22 verbintellz5_sd23 verbintellz5_sd24 verbintellz5_sd25 verbintellz5_sd26 verbintellz5_sd27 verbintellz5_sd28 verbintellz5_sd29 verbintellz5_sd30 verbintellz5_sd31 verbintellz5_sd32 verbintellz5_sd33 verbintellz5_sd34 verbintellz5_sd35 verbintellz5_sd36 verbintellz5_sd37 verbintellz5_sd38 verbintellz5_sd39 verbintellz5_sd40 verbintellz5_sd41 verbintellz5_sd42 verbintellz5_sd43 verbintellz5_sd44 verbintellz5_sd45 verbintellz5_sd46 verbintellz5_sd47 verbintellz5_sd48 verbintellz5_sd49 verbintellz5_sd50 verbintellz5_sd51 verbintellz5_sd52 verbintellz5_sd53 verbintellz5_sd54 verbintellz5_sd55 verbintellz5_sd56 verbintellz5_sd57 verbintellz5_sd58 verbintellz5_sd59 verbintellz5_sd60 verbintellz5_sd61 verbintellz5_sd62 verbintellz5_sd63 verbintellz5_sd64 verbintellz5_sd65 verbintellz5_sd66 verbintellz5_sd67 verbintellz5_sd68 verbintellz5_sd69 verbintellz5_sd70 verbintellz5_sd71 verbintellz5_sd72 verbintellz5_sd73 verbintellz5_sd74 verbintellz5_sd75 verbintellz5_sd76 verbintellz5_sd77 verbintellz5_sd78 verbintellz5_sd79 verbintellz5_sd80 verbintellz5_sd81 verbintellz5_sd82 verbintellz5_sd83 verbintellz5_sd84 verbintellz5_sd85 verbintellz5_sd86 verbintellz5_sd87 verbintellz5_sd88 verbintellz5_sd89 verbintellz5_sd90 verbintellz5_sd91 verbintellz5_sd92 verbintellz5_sd93 verbintellz5_sd94 verbintellz5_sd95 verbintellz5_sd96 verbintellz5_sd97 verbintellz5_sd98 verbintellz5_sd99, ytitle("SD of Verbal Intelligence")

*tsline verbmemz6_mean1 verbmemz6_mean2 verbmemz6_mean3 verbmemz6_mean4 verbmemz6_mean5 verbmemz6_mean6 verbmemz6_mean7 verbmemz6_mean8 verbmemz6_mean9 verbmemz6_mean10 verbmemz6_mean11 verbmemz6_mean12 verbmemz6_mean13 verbmemz6_mean14 verbmemz6_mean15 verbmemz6_mean16 verbmemz6_mean17 verbmemz6_mean18 verbmemz6_mean19 verbmemz6_mean20 verbmemz6_mean21 verbmemz6_mean22 verbmemz6_mean23 verbmemz6_mean24 verbmemz6_mean25 verbmemz6_mean26 verbmemz6_mean27 verbmemz6_mean28 verbmemz6_mean29 verbmemz6_mean30 verbmemz6_mean31 verbmemz6_mean32 verbmemz6_mean33 verbmemz6_mean34 verbmemz6_mean35 verbmemz6_mean36 verbmemz6_mean37 verbmemz6_mean38 verbmemz6_mean39 verbmemz6_mean40 verbmemz6_mean41 verbmemz6_mean42 verbmemz6_mean43 verbmemz6_mean44 verbmemz6_mean45 verbmemz6_mean46 verbmemz6_mean47 verbmemz6_mean48 verbmemz6_mean49 verbmemz6_mean50 verbmemz6_mean51 verbmemz6_mean52 verbmemz6_mean53 verbmemz6_mean54 verbmemz6_mean55 verbmemz6_mean56 verbmemz6_mean57 verbmemz6_mean58 verbmemz6_mean59 verbmemz6_mean60 verbmemz6_mean61 verbmemz6_mean62 verbmemz6_mean63 verbmemz6_mean64 verbmemz6_mean65 verbmemz6_mean66 verbmemz6_mean67 verbmemz6_mean68 verbmemz6_mean69 verbmemz6_mean70 verbmemz6_mean71 verbmemz6_mean72 verbmemz6_mean73 verbmemz6_mean74 verbmemz6_mean75 verbmemz6_mean76 verbmemz6_mean77 verbmemz6_mean78 verbmemz6_mean79 verbmemz6_mean80 verbmemz6_mean81 verbmemz6_mean82 verbmemz6_mean83 verbmemz6_mean84 verbmemz6_mean85 verbmemz6_mean86 verbmemz6_mean87 verbmemz6_mean88 verbmemz6_mean89 verbmemz6_mean90 verbmemz6_mean91 verbmemz6_mean92 verbmemz6_mean93 verbmemz6_mean94 verbmemz6_mean95 verbmemz6_mean96 verbmemz6_mean97 verbmemz6_mean98 verbmemz6_mean99 verbmemz6_mean100
tsline verbmemz6_mean1 verbmemz6_mean2 verbmemz6_mean3 verbmemz6_mean4 verbmemz6_mean5 verbmemz6_mean6 verbmemz6_mean7 verbmemz6_mean8 verbmemz6_mean9 verbmemz6_mean10 verbmemz6_mean11 verbmemz6_mean12 verbmemz6_mean13 verbmemz6_mean14 verbmemz6_mean15 verbmemz6_mean16 verbmemz6_mean17 verbmemz6_mean18 verbmemz6_mean19 verbmemz6_mean20 verbmemz6_mean21 verbmemz6_mean22 verbmemz6_mean23 verbmemz6_mean24 verbmemz6_mean25 verbmemz6_mean26 verbmemz6_mean27 verbmemz6_mean28 verbmemz6_mean29 verbmemz6_mean30 verbmemz6_mean31 verbmemz6_mean32 verbmemz6_mean33 verbmemz6_mean34 verbmemz6_mean35 verbmemz6_mean36 verbmemz6_mean37 verbmemz6_mean38 verbmemz6_mean39 verbmemz6_mean40 verbmemz6_mean41 verbmemz6_mean42 verbmemz6_mean43 verbmemz6_mean44 verbmemz6_mean45 verbmemz6_mean46 verbmemz6_mean47 verbmemz6_mean48 verbmemz6_mean49 verbmemz6_mean50 verbmemz6_mean51 verbmemz6_mean52 verbmemz6_mean53 verbmemz6_mean54 verbmemz6_mean55 verbmemz6_mean56 verbmemz6_mean57 verbmemz6_mean58 verbmemz6_mean59 verbmemz6_mean60 verbmemz6_mean61 verbmemz6_mean62 verbmemz6_mean63 verbmemz6_mean64 verbmemz6_mean65 verbmemz6_mean66 verbmemz6_mean67 verbmemz6_mean68 verbmemz6_mean69 verbmemz6_mean70 verbmemz6_mean71 verbmemz6_mean72 verbmemz6_mean73 verbmemz6_mean74 verbmemz6_mean75 verbmemz6_mean76 verbmemz6_mean77 verbmemz6_mean78 verbmemz6_mean79 verbmemz6_mean80 verbmemz6_mean81 verbmemz6_mean82 verbmemz6_mean83 verbmemz6_mean84 verbmemz6_mean85 verbmemz6_mean86 verbmemz6_mean87 verbmemz6_mean88 verbmemz6_mean89 verbmemz6_mean90 verbmemz6_mean91 verbmemz6_mean92 verbmemz6_mean93 verbmemz6_mean94 verbmemz6_mean95 verbmemz6_mean96 verbmemz6_mean97 verbmemz6_mean98 verbmemz6_mean99, ytitle("Mean of Verbal Memory")
tsline verbmemz6_sd1 verbmemz6_sd2 verbmemz6_sd3 verbmemz6_sd4 verbmemz6_sd5 verbmemz6_sd6 verbmemz6_sd7 verbmemz6_sd8 verbmemz6_sd9 verbmemz6_sd10 verbmemz6_sd11 verbmemz6_sd12 verbmemz6_sd13 verbmemz6_sd14 verbmemz6_sd15 verbmemz6_sd16 verbmemz6_sd17 verbmemz6_sd18 verbmemz6_sd19 verbmemz6_sd20 verbmemz6_sd21 verbmemz6_sd22 verbmemz6_sd23 verbmemz6_sd24 verbmemz6_sd25 verbmemz6_sd26 verbmemz6_sd27 verbmemz6_sd28 verbmemz6_sd29 verbmemz6_sd30 verbmemz6_sd31 verbmemz6_sd32 verbmemz6_sd33 verbmemz6_sd34 verbmemz6_sd35 verbmemz6_sd36 verbmemz6_sd37 verbmemz6_sd38 verbmemz6_sd39 verbmemz6_sd40 verbmemz6_sd41 verbmemz6_sd42 verbmemz6_sd43 verbmemz6_sd44 verbmemz6_sd45 verbmemz6_sd46 verbmemz6_sd47 verbmemz6_sd48 verbmemz6_sd49 verbmemz6_sd50 verbmemz6_sd51 verbmemz6_sd52 verbmemz6_sd53 verbmemz6_sd54 verbmemz6_sd55 verbmemz6_sd56 verbmemz6_sd57 verbmemz6_sd58 verbmemz6_sd59 verbmemz6_sd60 verbmemz6_sd61 verbmemz6_sd62 verbmemz6_sd63 verbmemz6_sd64 verbmemz6_sd65 verbmemz6_sd66 verbmemz6_sd67 verbmemz6_sd68 verbmemz6_sd69 verbmemz6_sd70 verbmemz6_sd71 verbmemz6_sd72 verbmemz6_sd73 verbmemz6_sd74 verbmemz6_sd75 verbmemz6_sd76 verbmemz6_sd77 verbmemz6_sd78 verbmemz6_sd79 verbmemz6_sd80 verbmemz6_sd81 verbmemz6_sd82 verbmemz6_sd83 verbmemz6_sd84 verbmemz6_sd85 verbmemz6_sd86 verbmemz6_sd87 verbmemz6_sd88 verbmemz6_sd89 verbmemz6_sd90 verbmemz6_sd91 verbmemz6_sd92 verbmemz6_sd93 verbmemz6_sd94 verbmemz6_sd95 verbmemz6_sd96 verbmemz6_sd97 verbmemz6_sd98 verbmemz6_sd99, ytitle("SD of Verbal Memory")

*tsline visuaspatintellz7_mean1 visuaspatintellz7_mean2 visuaspatintellz7_mean3 visuaspatintellz7_mean4 visuaspatintellz7_mean5 visuaspatintellz7_mean6 visuaspatintellz7_mean7 visuaspatintellz7_mean8 visuaspatintellz7_mean9 visuaspatintellz7_mean10 visuaspatintellz7_mean11 visuaspatintellz7_mean12 visuaspatintellz7_mean13 visuaspatintellz7_mean14 visuaspatintellz7_mean15 visuaspatintellz7_mean16 visuaspatintellz7_mean17 visuaspatintellz7_mean18 visuaspatintellz7_mean19 visuaspatintellz7_mean20 visuaspatintellz7_mean21 visuaspatintellz7_mean22 visuaspatintellz7_mean23 visuaspatintellz7_mean24 visuaspatintellz7_mean25 visuaspatintellz7_mean26 visuaspatintellz7_mean27 visuaspatintellz7_mean28 visuaspatintellz7_mean29 visuaspatintellz7_mean30 visuaspatintellz7_mean31 visuaspatintellz7_mean32 visuaspatintellz7_mean33 visuaspatintellz7_mean34 visuaspatintellz7_mean35 visuaspatintellz7_mean36 visuaspatintellz7_mean37 visuaspatintellz7_mean38 visuaspatintellz7_mean39 visuaspatintellz7_mean40 visuaspatintellz7_mean41 visuaspatintellz7_mean42 visuaspatintellz7_mean43 visuaspatintellz7_mean44 visuaspatintellz7_mean45 visuaspatintellz7_mean46 visuaspatintellz7_mean47 visuaspatintellz7_mean48 visuaspatintellz7_mean49 visuaspatintellz7_mean50 visuaspatintellz7_mean51 visuaspatintellz7_mean52 visuaspatintellz7_mean53 visuaspatintellz7_mean54 visuaspatintellz7_mean55 visuaspatintellz7_mean56 visuaspatintellz7_mean57 visuaspatintellz7_mean58 visuaspatintellz7_mean59 visuaspatintellz7_mean60 visuaspatintellz7_mean61 visuaspatintellz7_mean62 visuaspatintellz7_mean63 visuaspatintellz7_mean64 visuaspatintellz7_mean65 visuaspatintellz7_mean66 visuaspatintellz7_mean67 visuaspatintellz7_mean68 visuaspatintellz7_mean69 visuaspatintellz7_mean70 visuaspatintellz7_mean71 visuaspatintellz7_mean72 visuaspatintellz7_mean73 visuaspatintellz7_mean74 visuaspatintellz7_mean75 visuaspatintellz7_mean76 visuaspatintellz7_mean77 visuaspatintellz7_mean78 visuaspatintellz7_mean79 visuaspatintellz7_mean80 visuaspatintellz7_mean81 visuaspatintellz7_mean82 visuaspatintellz7_mean83 visuaspatintellz7_mean84 visuaspatintellz7_mean85 visuaspatintellz7_mean86 visuaspatintellz7_mean87 visuaspatintellz7_mean88 visuaspatintellz7_mean89 visuaspatintellz7_mean90 visuaspatintellz7_mean91 visuaspatintellz7_mean92 visuaspatintellz7_mean93 visuaspatintellz7_mean94 visuaspatintellz7_mean95 visuaspatintellz7_mean96 visuaspatintellz7_mean97 visuaspatintellz7_mean98 visuaspatintellz7_mean99 visuaspatintellz7_mean100
tsline visuaspatintellz7_mean1 visuaspatintellz7_mean2 visuaspatintellz7_mean3 visuaspatintellz7_mean4 visuaspatintellz7_mean5 visuaspatintellz7_mean6 visuaspatintellz7_mean7 visuaspatintellz7_mean8 visuaspatintellz7_mean9 visuaspatintellz7_mean10 visuaspatintellz7_mean11 visuaspatintellz7_mean12 visuaspatintellz7_mean13 visuaspatintellz7_mean14 visuaspatintellz7_mean15 visuaspatintellz7_mean16 visuaspatintellz7_mean17 visuaspatintellz7_mean18 visuaspatintellz7_mean19 visuaspatintellz7_mean20 visuaspatintellz7_mean21 visuaspatintellz7_mean22 visuaspatintellz7_mean23 visuaspatintellz7_mean24 visuaspatintellz7_mean25 visuaspatintellz7_mean26 visuaspatintellz7_mean27 visuaspatintellz7_mean28 visuaspatintellz7_mean29 visuaspatintellz7_mean30 visuaspatintellz7_mean31 visuaspatintellz7_mean32 visuaspatintellz7_mean33 visuaspatintellz7_mean34 visuaspatintellz7_mean35 visuaspatintellz7_mean36 visuaspatintellz7_mean37 visuaspatintellz7_mean38 visuaspatintellz7_mean39 visuaspatintellz7_mean40 visuaspatintellz7_mean41 visuaspatintellz7_mean42 visuaspatintellz7_mean43 visuaspatintellz7_mean44 visuaspatintellz7_mean45 visuaspatintellz7_mean46 visuaspatintellz7_mean47 visuaspatintellz7_mean48 visuaspatintellz7_mean49 visuaspatintellz7_mean50 visuaspatintellz7_mean51 visuaspatintellz7_mean52 visuaspatintellz7_mean53 visuaspatintellz7_mean54 visuaspatintellz7_mean55 visuaspatintellz7_mean56 visuaspatintellz7_mean57 visuaspatintellz7_mean58 visuaspatintellz7_mean59 visuaspatintellz7_mean60 visuaspatintellz7_mean61 visuaspatintellz7_mean62 visuaspatintellz7_mean63 visuaspatintellz7_mean64 visuaspatintellz7_mean65 visuaspatintellz7_mean66 visuaspatintellz7_mean67 visuaspatintellz7_mean68 visuaspatintellz7_mean69 visuaspatintellz7_mean70 visuaspatintellz7_mean71 visuaspatintellz7_mean72 visuaspatintellz7_mean73 visuaspatintellz7_mean74 visuaspatintellz7_mean75 visuaspatintellz7_mean76 visuaspatintellz7_mean77 visuaspatintellz7_mean78 visuaspatintellz7_mean79 visuaspatintellz7_mean80 visuaspatintellz7_mean81 visuaspatintellz7_mean82 visuaspatintellz7_mean83 visuaspatintellz7_mean84 visuaspatintellz7_mean85 visuaspatintellz7_mean86 visuaspatintellz7_mean87 visuaspatintellz7_mean88 visuaspatintellz7_mean89 visuaspatintellz7_mean90 visuaspatintellz7_mean91 visuaspatintellz7_mean92 visuaspatintellz7_mean93 visuaspatintellz7_mean94 visuaspatintellz7_mean95 visuaspatintellz7_mean96 visuaspatintellz7_mean97 visuaspatintellz7_mean98 visuaspatintellz7_mean99, ytitle("Mean of Visual-spatial intelligence")
tsline visuaspatintellz7_sd1 visuaspatintellz7_sd2 visuaspatintellz7_sd3 visuaspatintellz7_sd4 visuaspatintellz7_sd5 visuaspatintellz7_sd6 visuaspatintellz7_sd7 visuaspatintellz7_sd8 visuaspatintellz7_sd9 visuaspatintellz7_sd10 visuaspatintellz7_sd11 visuaspatintellz7_sd12 visuaspatintellz7_sd13 visuaspatintellz7_sd14 visuaspatintellz7_sd15 visuaspatintellz7_sd16 visuaspatintellz7_sd17 visuaspatintellz7_sd18 visuaspatintellz7_sd19 visuaspatintellz7_sd20 visuaspatintellz7_sd21 visuaspatintellz7_sd22 visuaspatintellz7_sd23 visuaspatintellz7_sd24 visuaspatintellz7_sd25 visuaspatintellz7_sd26 visuaspatintellz7_sd27 visuaspatintellz7_sd28 visuaspatintellz7_sd29 visuaspatintellz7_sd30 visuaspatintellz7_sd31 visuaspatintellz7_sd32 visuaspatintellz7_sd33 visuaspatintellz7_sd34 visuaspatintellz7_sd35 visuaspatintellz7_sd36 visuaspatintellz7_sd37 visuaspatintellz7_sd38 visuaspatintellz7_sd39 visuaspatintellz7_sd40 visuaspatintellz7_sd41 visuaspatintellz7_sd42 visuaspatintellz7_sd43 visuaspatintellz7_sd44 visuaspatintellz7_sd45 visuaspatintellz7_sd46 visuaspatintellz7_sd47 visuaspatintellz7_sd48 visuaspatintellz7_sd49 visuaspatintellz7_sd50 visuaspatintellz7_sd51 visuaspatintellz7_sd52 visuaspatintellz7_sd53 visuaspatintellz7_sd54 visuaspatintellz7_sd55 visuaspatintellz7_sd56 visuaspatintellz7_sd57 visuaspatintellz7_sd58 visuaspatintellz7_sd59 visuaspatintellz7_sd60 visuaspatintellz7_sd61 visuaspatintellz7_sd62 visuaspatintellz7_sd63 visuaspatintellz7_sd64 visuaspatintellz7_sd65 visuaspatintellz7_sd66 visuaspatintellz7_sd67 visuaspatintellz7_sd68 visuaspatintellz7_sd69 visuaspatintellz7_sd70 visuaspatintellz7_sd71 visuaspatintellz7_sd72 visuaspatintellz7_sd73 visuaspatintellz7_sd74 visuaspatintellz7_sd75 visuaspatintellz7_sd76 visuaspatintellz7_sd77 visuaspatintellz7_sd78 visuaspatintellz7_sd79 visuaspatintellz7_sd80 visuaspatintellz7_sd81 visuaspatintellz7_sd82 visuaspatintellz7_sd83 visuaspatintellz7_sd84 visuaspatintellz7_sd85 visuaspatintellz7_sd86 visuaspatintellz7_sd87 visuaspatintellz7_sd88 visuaspatintellz7_sd89 visuaspatintellz7_sd90 visuaspatintellz7_sd91 visuaspatintellz7_sd92 visuaspatintellz7_sd93 visuaspatintellz7_sd94 visuaspatintellz7_sd95 visuaspatintellz7_sd96 visuaspatintellz7_sd97 visuaspatintellz7_sd98 visuaspatintellz7_sd99, ytitle("SD of Visual-spatial intelligence")




*QQPlot 

qqplot execfunctionz1_mean1 execfunctionz1_mean100, name(g11)
qqplot  attenworkspeedz2_mean1  attenworkspeedz2_mean100, name(g21)
qqplot IQcogfuncz3_mean1 IQcogfuncz3_mean100, name(g31)
qqplot visualspatmemz4_mean1 visualspatmemz4_mean100, name(g41)
qqplot verbintellz5_mean1 verbintellz5_mean100, name(g51)
qqplot verbmemz6_mean1 verbmemz6_mean100, name(g61)
qqplot visuaspatintellz7_mean1 visuaspatintellz7_mean100, name(g71)

graph combine g11 g21 g31 g41 g51 g61 g71



qqplot execfunctionz1_sd1 execfunctionz1_sd100, name(s11)
qqplot  attenworkspeedz2_sd1  attenworkspeedz2_sd100, name(s21)
qqplot IQcogfuncz3_sd1 IQcogfuncz3_sd100, name(s31)
qqplot visualspatmemz4_sd1 visualspatmemz4_sd100, name(s41)
qqplot verbintellz5_sd1 verbintellz5_sd100, name(s51)
qqplot verbmemz6_sd1 verbmemz6_sd100, name(s61)
qqplot visuaspatintellz7_sd1 visuaspatintellz7_sd100, name(s71)

graph combine s11 s21 s31 s41 s51 s61 s71


*20 iterations model

use new20imputations, replace
reshape wide *mean *sd, i(iter) j(m)
tsset iter
*convergence only allows to plot under 100 means, so the * ones are all 100, and the runable code is missing the 2nd mean estimation. However, check with Sophie in case this needs to be random?
*tsline execfunctionz1_mean1 execfunctionz1_mean5 execfunctionz1_mean10 execfunctionz1_mean15 execfunctionz1_mean20 execfunctionz1_mean25 execfunctionz1_mean30 execfunctionz1_mean35 execfunctionz1_mean40 execfunctionz1_mean45 execfunctionz1_mean50 execfunctionz1_mean55 execfunctionz1_mean60 execfunctionz1_mean65 execfunctionz1_mean70 execfunctionz1_mean75 execfunctionz1_mean80 execfunctionz1_mean85 execfunctionz1_mean90 execfunctionz1_mean95 execfunctionz1_mean100

*tsline execfunctionz1_mean1 execfunctionz1_mean2 execfunctionz1_mean3 execfunctionz1_mean4 execfunctionz1_mean5 execfunctionz1_mean6 execfunctionz1_mean7 execfunctionz1_mean8 execfunctionz1_mean9 execfunctionz1_mean10 execfunctionz1_mean11 execfunctionz1_mean12 execfunctionz1_mean13 execfunctionz1_mean14 execfunctionz1_mean15 execfunctionz1_mean16 execfunctionz1_mean17 execfunctionz1_mean18 execfunctionz1_mean19 execfunctionz1_mean20 execfunctionz1_mean21 execfunctionz1_mean22 execfunctionz1_mean23 execfunctionz1_mean24 execfunctionz1_mean25 execfunctionz1_mean26 execfunctionz1_mean27 execfunctionz1_mean28 execfunctionz1_mean29 execfunctionz1_mean30 execfunctionz1_mean31 execfunctionz1_mean32 execfunctionz1_mean33 execfunctionz1_mean34 execfunctionz1_mean35 execfunctionz1_mean36 execfunctionz1_mean37 execfunctionz1_mean38 execfunctionz1_mean39 execfunctionz1_mean40 execfunctionz1_mean41 execfunctionz1_mean42 execfunctionz1_mean43 execfunctionz1_mean44 execfunctionz1_mean45 execfunctionz1_mean46 execfunctionz1_mean47 execfunctionz1_mean48 execfunctionz1_mean49 execfunctionz1_mean50 execfunctionz1_mean51 execfunctionz1_mean52 execfunctionz1_mean53 execfunctionz1_mean54 execfunctionz1_mean55 execfunctionz1_mean56 execfunctionz1_mean57 execfunctionz1_mean58 execfunctionz1_mean59 execfunctionz1_mean60 execfunctionz1_mean61 execfunctionz1_mean62 execfunctionz1_mean63 execfunctionz1_mean64 execfunctionz1_mean65 execfunctionz1_mean66 execfunctionz1_mean67 execfunctionz1_mean68 execfunctionz1_mean69 execfunctionz1_mean70 execfunctionz1_mean71 execfunctionz1_mean72 execfunctionz1_mean73 execfunctionz1_mean74 execfunctionz1_mean75 execfunctionz1_mean76 execfunctionz1_mean77 execfunctionz1_mean78 execfunctionz1_mean79 execfunctionz1_mean80 execfunctionz1_mean81 execfunctionz1_mean82 execfunctionz1_mean83 execfunctionz1_mean84 execfunctionz1_mean85 execfunctionz1_mean86 execfunctionz1_mean87 execfunctionz1_mean88 execfunctionz1_mean89 execfunctionz1_mean90 execfunctionz1_mean91 execfunctionz1_mean92 execfunctionz1_mean93 execfunctionz1_mean94 execfunctionz1_mean95 execfunctionz1_mean96 execfunctionz1_mean97 execfunctionz1_mean98 execfunctionz1_mean99 execfunctionz1_mean100
tsline execfunctionz1_mean1  execfunctionz1_mean2 execfunctionz1_mean3 execfunctionz1_mean4 execfunctionz1_mean5 execfunctionz1_mean6 execfunctionz1_mean7 execfunctionz1_mean8 execfunctionz1_mean9 execfunctionz1_mean10 execfunctionz1_mean11 execfunctionz1_mean12 execfunctionz1_mean13 execfunctionz1_mean14 execfunctionz1_mean15 execfunctionz1_mean16 execfunctionz1_mean17 execfunctionz1_mean18 execfunctionz1_mean19 execfunctionz1_mean20 execfunctionz1_mean21 execfunctionz1_mean22 execfunctionz1_mean23 execfunctionz1_mean24 execfunctionz1_mean25 execfunctionz1_mean26 execfunctionz1_mean27 execfunctionz1_mean28 execfunctionz1_mean29 execfunctionz1_mean30 execfunctionz1_mean31 execfunctionz1_mean32 execfunctionz1_mean33 execfunctionz1_mean34 execfunctionz1_mean35 execfunctionz1_mean36 execfunctionz1_mean37 execfunctionz1_mean38 execfunctionz1_mean39 execfunctionz1_mean40 execfunctionz1_mean41 execfunctionz1_mean42 execfunctionz1_mean43 execfunctionz1_mean44 execfunctionz1_mean45 execfunctionz1_mean46 execfunctionz1_mean47 execfunctionz1_mean48 execfunctionz1_mean49 execfunctionz1_mean50 execfunctionz1_mean51 execfunctionz1_mean52 execfunctionz1_mean53 execfunctionz1_mean54 execfunctionz1_mean55 execfunctionz1_mean56 execfunctionz1_mean57 execfunctionz1_mean58 execfunctionz1_mean59 execfunctionz1_mean60 execfunctionz1_mean61 execfunctionz1_mean62 execfunctionz1_mean63 execfunctionz1_mean64 execfunctionz1_mean65 execfunctionz1_mean66 execfunctionz1_mean67 execfunctionz1_mean68 execfunctionz1_mean69 execfunctionz1_mean70 execfunctionz1_mean71 execfunctionz1_mean72 execfunctionz1_mean73 execfunctionz1_mean74 execfunctionz1_mean75 execfunctionz1_mean76 execfunctionz1_mean77 execfunctionz1_mean78 execfunctionz1_mean79 execfunctionz1_mean80 execfunctionz1_mean81 execfunctionz1_mean82 execfunctionz1_mean83 execfunctionz1_mean84 execfunctionz1_mean85 execfunctionz1_mean86 execfunctionz1_mean87 execfunctionz1_mean88 execfunctionz1_mean89 execfunctionz1_mean90 execfunctionz1_mean91 execfunctionz1_mean92 execfunctionz1_mean93 execfunctionz1_mean94 execfunctionz1_mean95 execfunctionz1_mean96 execfunctionz1_mean97 execfunctionz1_mean98 execfunctionz1_mean99, ytitle("Mean of Executive function")
tsline execfunctionz1_sd1 execfunctionz1_sd2 execfunctionz1_sd3 execfunctionz1_sd4 execfunctionz1_sd5 execfunctionz1_sd6 execfunctionz1_sd7 execfunctionz1_sd8 execfunctionz1_sd9 execfunctionz1_sd10 execfunctionz1_sd11 execfunctionz1_sd12 execfunctionz1_sd13 execfunctionz1_sd14 execfunctionz1_sd15 execfunctionz1_sd16 execfunctionz1_sd17 execfunctionz1_sd18 execfunctionz1_sd19 execfunctionz1_sd20 execfunctionz1_sd21 execfunctionz1_sd22 execfunctionz1_sd23 execfunctionz1_sd24 execfunctionz1_sd25 execfunctionz1_sd26 execfunctionz1_sd27 execfunctionz1_sd28 execfunctionz1_sd29 execfunctionz1_sd30 execfunctionz1_sd31 execfunctionz1_sd32 execfunctionz1_sd33 execfunctionz1_sd34 execfunctionz1_sd35 execfunctionz1_sd36 execfunctionz1_sd37 execfunctionz1_sd38 execfunctionz1_sd39 execfunctionz1_sd40 execfunctionz1_sd41 execfunctionz1_sd42 execfunctionz1_sd43 execfunctionz1_sd44 execfunctionz1_sd45 execfunctionz1_sd46 execfunctionz1_sd47 execfunctionz1_sd48 execfunctionz1_sd49 execfunctionz1_sd50 execfunctionz1_sd51 execfunctionz1_sd52 execfunctionz1_sd53 execfunctionz1_sd54 execfunctionz1_sd55 execfunctionz1_sd56 execfunctionz1_sd57 execfunctionz1_sd58 execfunctionz1_sd59 execfunctionz1_sd60 execfunctionz1_sd61 execfunctionz1_sd62 execfunctionz1_sd63 execfunctionz1_sd64 execfunctionz1_sd65 execfunctionz1_sd66 execfunctionz1_sd67 execfunctionz1_sd68 execfunctionz1_sd69 execfunctionz1_sd70 execfunctionz1_sd71 execfunctionz1_sd72 execfunctionz1_sd73 execfunctionz1_sd74 execfunctionz1_sd75 execfunctionz1_sd76 execfunctionz1_sd77 execfunctionz1_sd78 execfunctionz1_sd79 execfunctionz1_sd80 execfunctionz1_sd81 execfunctionz1_sd82 execfunctionz1_sd83 execfunctionz1_sd84 execfunctionz1_sd85 execfunctionz1_sd86 execfunctionz1_sd87 execfunctionz1_sd88 execfunctionz1_sd89 execfunctionz1_sd90 execfunctionz1_sd91 execfunctionz1_sd92 execfunctionz1_sd93 execfunctionz1_sd94 execfunctionz1_sd95 execfunctionz1_sd96 execfunctionz1_sd97 execfunctionz1_sd98 execfunctionz1_sd99, ytitle("SD of Ecexutive function")

*tsline attenworkspeedz2_mean1 attenworkspeedz2_mean2 attenworkspeedz2_mean3 attenworkspeedz2_mean4 attenworkspeedz2_mean5 attenworkspeedz2_mean6 attenworkspeedz2_mean7 attenworkspeedz2_mean8 attenworkspeedz2_mean9 attenworkspeedz2_mean10 attenworkspeedz2_mean11 attenworkspeedz2_mean12 attenworkspeedz2_mean13 attenworkspeedz2_mean14 attenworkspeedz2_mean15 attenworkspeedz2_mean16 attenworkspeedz2_mean17 attenworkspeedz2_mean18 attenworkspeedz2_mean19 attenworkspeedz2_mean20 attenworkspeedz2_mean21 attenworkspeedz2_mean22 attenworkspeedz2_mean23 attenworkspeedz2_mean24 attenworkspeedz2_mean25 attenworkspeedz2_mean26 attenworkspeedz2_mean27 attenworkspeedz2_mean28 attenworkspeedz2_mean29 attenworkspeedz2_mean30 attenworkspeedz2_mean31 attenworkspeedz2_mean32 attenworkspeedz2_mean33 attenworkspeedz2_mean34 attenworkspeedz2_mean35 attenworkspeedz2_mean36 attenworkspeedz2_mean37 attenworkspeedz2_mean38 attenworkspeedz2_mean39 attenworkspeedz2_mean40 attenworkspeedz2_mean41 attenworkspeedz2_mean42 attenworkspeedz2_mean43 attenworkspeedz2_mean44 attenworkspeedz2_mean45 attenworkspeedz2_mean46 attenworkspeedz2_mean47 attenworkspeedz2_mean48 attenworkspeedz2_mean49 attenworkspeedz2_mean50 attenworkspeedz2_mean51 attenworkspeedz2_mean52 attenworkspeedz2_mean53 attenworkspeedz2_mean54 attenworkspeedz2_mean55 attenworkspeedz2_mean56 attenworkspeedz2_mean57 attenworkspeedz2_mean58 attenworkspeedz2_mean59 attenworkspeedz2_mean60 attenworkspeedz2_mean61 attenworkspeedz2_mean62 attenworkspeedz2_mean63 attenworkspeedz2_mean64 attenworkspeedz2_mean65 attenworkspeedz2_mean66 attenworkspeedz2_mean67 attenworkspeedz2_mean68 attenworkspeedz2_mean69 attenworkspeedz2_mean70 attenworkspeedz2_mean71 attenworkspeedz2_mean72 attenworkspeedz2_mean73 attenworkspeedz2_mean74 attenworkspeedz2_mean75 attenworkspeedz2_mean76 attenworkspeedz2_mean77 attenworkspeedz2_mean78 attenworkspeedz2_mean79 attenworkspeedz2_mean80 attenworkspeedz2_mean81 attenworkspeedz2_mean82 attenworkspeedz2_mean83 attenworkspeedz2_mean84 attenworkspeedz2_mean85 attenworkspeedz2_mean86 attenworkspeedz2_mean87 attenworkspeedz2_mean88 attenworkspeedz2_mean89 attenworkspeedz2_mean90 attenworkspeedz2_mean91 attenworkspeedz2_mean92 attenworkspeedz2_mean93 attenworkspeedz2_mean94 attenworkspeedz2_mean95 attenworkspeedz2_mean96 attenworkspeedz2_mean97 attenworkspeedz2_mean98 attenworkspeedz2_mean99 attenworkspeedz2_mean100
tsline attenworkspeedz2_mean1 attenworkspeedz2_mean2 attenworkspeedz2_mean3 attenworkspeedz2_mean4 attenworkspeedz2_mean5 attenworkspeedz2_mean6 attenworkspeedz2_mean7 attenworkspeedz2_mean8 attenworkspeedz2_mean9 attenworkspeedz2_mean10 attenworkspeedz2_mean11 attenworkspeedz2_mean12 attenworkspeedz2_mean13 attenworkspeedz2_mean14 attenworkspeedz2_mean15 attenworkspeedz2_mean16 attenworkspeedz2_mean17 attenworkspeedz2_mean18 attenworkspeedz2_mean19 attenworkspeedz2_mean20 attenworkspeedz2_mean21 attenworkspeedz2_mean22 attenworkspeedz2_mean23 attenworkspeedz2_mean24 attenworkspeedz2_mean25 attenworkspeedz2_mean26 attenworkspeedz2_mean27 attenworkspeedz2_mean28 attenworkspeedz2_mean29 attenworkspeedz2_mean30 attenworkspeedz2_mean31 attenworkspeedz2_mean32 attenworkspeedz2_mean33 attenworkspeedz2_mean34 attenworkspeedz2_mean35 attenworkspeedz2_mean36 attenworkspeedz2_mean37 attenworkspeedz2_mean38 attenworkspeedz2_mean39 attenworkspeedz2_mean40 attenworkspeedz2_mean41 attenworkspeedz2_mean42 attenworkspeedz2_mean43 attenworkspeedz2_mean44 attenworkspeedz2_mean45 attenworkspeedz2_mean46 attenworkspeedz2_mean47 attenworkspeedz2_mean48 attenworkspeedz2_mean49 attenworkspeedz2_mean50 attenworkspeedz2_mean51 attenworkspeedz2_mean52 attenworkspeedz2_mean53 attenworkspeedz2_mean54 attenworkspeedz2_mean55 attenworkspeedz2_mean56 attenworkspeedz2_mean57 attenworkspeedz2_mean58 attenworkspeedz2_mean59 attenworkspeedz2_mean60 attenworkspeedz2_mean61 attenworkspeedz2_mean62 attenworkspeedz2_mean63 attenworkspeedz2_mean64 attenworkspeedz2_mean65 attenworkspeedz2_mean66 attenworkspeedz2_mean67 attenworkspeedz2_mean68 attenworkspeedz2_mean69 attenworkspeedz2_mean70 attenworkspeedz2_mean71 attenworkspeedz2_mean72 attenworkspeedz2_mean73 attenworkspeedz2_mean74 attenworkspeedz2_mean75 attenworkspeedz2_mean76 attenworkspeedz2_mean77 attenworkspeedz2_mean78 attenworkspeedz2_mean79 attenworkspeedz2_mean80 attenworkspeedz2_mean81 attenworkspeedz2_mean82 attenworkspeedz2_mean83 attenworkspeedz2_mean84 attenworkspeedz2_mean85 attenworkspeedz2_mean86 attenworkspeedz2_mean87 attenworkspeedz2_mean88 attenworkspeedz2_mean89 attenworkspeedz2_mean90 attenworkspeedz2_mean91 attenworkspeedz2_mean92 attenworkspeedz2_mean93 attenworkspeedz2_mean94 attenworkspeedz2_mean95 attenworkspeedz2_mean96 attenworkspeedz2_mean97 attenworkspeedz2_mean98 attenworkspeedz2_mean99, ytitle("Mean of Attention, wokring memory & processing speed")
tsline attenworkspeedz2_sd1 attenworkspeedz2_sd2 attenworkspeedz2_sd3 attenworkspeedz2_sd4 attenworkspeedz2_sd5 attenworkspeedz2_sd6 attenworkspeedz2_sd7 attenworkspeedz2_sd8 attenworkspeedz2_sd9 attenworkspeedz2_sd10 attenworkspeedz2_sd11 attenworkspeedz2_sd12 attenworkspeedz2_sd13 attenworkspeedz2_sd14 attenworkspeedz2_sd15 attenworkspeedz2_sd16 attenworkspeedz2_sd17 attenworkspeedz2_sd18 attenworkspeedz2_sd19 attenworkspeedz2_sd20 attenworkspeedz2_sd21 attenworkspeedz2_sd22 attenworkspeedz2_sd23 attenworkspeedz2_sd24 attenworkspeedz2_sd25 attenworkspeedz2_sd26 attenworkspeedz2_sd27 attenworkspeedz2_sd28 attenworkspeedz2_sd29 attenworkspeedz2_sd30 attenworkspeedz2_sd31 attenworkspeedz2_sd32 attenworkspeedz2_sd33 attenworkspeedz2_sd34 attenworkspeedz2_sd35 attenworkspeedz2_sd36 attenworkspeedz2_sd37 attenworkspeedz2_sd38 attenworkspeedz2_sd39 attenworkspeedz2_sd40 attenworkspeedz2_sd41 attenworkspeedz2_sd42 attenworkspeedz2_sd43 attenworkspeedz2_sd44 attenworkspeedz2_sd45 attenworkspeedz2_sd46 attenworkspeedz2_sd47 attenworkspeedz2_sd48 attenworkspeedz2_sd49 attenworkspeedz2_sd50 attenworkspeedz2_sd51 attenworkspeedz2_sd52 attenworkspeedz2_sd53 attenworkspeedz2_sd54 attenworkspeedz2_sd55 attenworkspeedz2_sd56 attenworkspeedz2_sd57 attenworkspeedz2_sd58 attenworkspeedz2_sd59 attenworkspeedz2_sd60 attenworkspeedz2_sd61 attenworkspeedz2_sd62 attenworkspeedz2_sd63 attenworkspeedz2_sd64 attenworkspeedz2_sd65 attenworkspeedz2_sd66 attenworkspeedz2_sd67 attenworkspeedz2_sd68 attenworkspeedz2_sd69 attenworkspeedz2_sd70 attenworkspeedz2_sd71 attenworkspeedz2_sd72 attenworkspeedz2_sd73 attenworkspeedz2_sd74 attenworkspeedz2_sd75 attenworkspeedz2_sd76 attenworkspeedz2_sd77 attenworkspeedz2_sd78 attenworkspeedz2_sd79 attenworkspeedz2_sd80 attenworkspeedz2_sd81 attenworkspeedz2_sd82 attenworkspeedz2_sd83 attenworkspeedz2_sd84 attenworkspeedz2_sd85 attenworkspeedz2_sd86 attenworkspeedz2_sd87 attenworkspeedz2_sd88 attenworkspeedz2_sd89 attenworkspeedz2_sd90 attenworkspeedz2_sd91 attenworkspeedz2_sd92 attenworkspeedz2_sd93 attenworkspeedz2_sd94 attenworkspeedz2_sd95 attenworkspeedz2_sd96 attenworkspeedz2_sd97 attenworkspeedz2_sd98 attenworkspeedz2_sd99, ytitle("SD of Attention, wokring memory & processing speed")


*tsline IQcogfuncz3_mean1 IQcogfuncz3_mean2 IQcogfuncz3_mean3 IQcogfuncz3_mean4 IQcogfuncz3_mean5 IQcogfuncz3_mean6 IQcogfuncz3_mean7 IQcogfuncz3_mean8 IQcogfuncz3_mean9 IQcogfuncz3_mean10 IQcogfuncz3_mean11 IQcogfuncz3_mean12 IQcogfuncz3_mean13 IQcogfuncz3_mean14 IQcogfuncz3_mean15 IQcogfuncz3_mean16 IQcogfuncz3_mean17 IQcogfuncz3_mean18 IQcogfuncz3_mean19 IQcogfuncz3_mean20 IQcogfuncz3_mean21 IQcogfuncz3_mean22 IQcogfuncz3_mean23 IQcogfuncz3_mean24 IQcogfuncz3_mean25 IQcogfuncz3_mean26 IQcogfuncz3_mean27 IQcogfuncz3_mean28 IQcogfuncz3_mean29 IQcogfuncz3_mean30 IQcogfuncz3_mean31 IQcogfuncz3_mean32 IQcogfuncz3_mean33 IQcogfuncz3_mean34 IQcogfuncz3_mean35 IQcogfuncz3_mean36 IQcogfuncz3_mean37 IQcogfuncz3_mean38 IQcogfuncz3_mean39 IQcogfuncz3_mean40 IQcogfuncz3_mean41 IQcogfuncz3_mean42 IQcogfuncz3_mean43 IQcogfuncz3_mean44 IQcogfuncz3_mean45 IQcogfuncz3_mean46 IQcogfuncz3_mean47 IQcogfuncz3_mean48 IQcogfuncz3_mean49 IQcogfuncz3_mean50 IQcogfuncz3_mean51 IQcogfuncz3_mean52 IQcogfuncz3_mean53 IQcogfuncz3_mean54 IQcogfuncz3_mean55 IQcogfuncz3_mean56 IQcogfuncz3_mean57 IQcogfuncz3_mean58 IQcogfuncz3_mean59 IQcogfuncz3_mean60 IQcogfuncz3_mean61 IQcogfuncz3_mean62 IQcogfuncz3_mean63 IQcogfuncz3_mean64 IQcogfuncz3_mean65 IQcogfuncz3_mean66 IQcogfuncz3_mean67 IQcogfuncz3_mean68 IQcogfuncz3_mean69 IQcogfuncz3_mean70 IQcogfuncz3_mean71 IQcogfuncz3_mean72 IQcogfuncz3_mean73 IQcogfuncz3_mean74 IQcogfuncz3_mean75 IQcogfuncz3_mean76 IQcogfuncz3_mean77 IQcogfuncz3_mean78 IQcogfuncz3_mean79 IQcogfuncz3_mean80 IQcogfuncz3_mean81 IQcogfuncz3_mean82 IQcogfuncz3_mean83 IQcogfuncz3_mean84 IQcogfuncz3_mean85 IQcogfuncz3_mean86 IQcogfuncz3_mean87 IQcogfuncz3_mean88 IQcogfuncz3_mean89 IQcogfuncz3_mean90 IQcogfuncz3_mean91 IQcogfuncz3_mean92 IQcogfuncz3_mean93 IQcogfuncz3_mean94 IQcogfuncz3_mean95 IQcogfuncz3_mean96 IQcogfuncz3_mean97 IQcogfuncz3_mean98 IQcogfuncz3_mean99 IQcogfuncz3_mean100
tsline IQcogfuncz3_mean1  IQcogfuncz3_mean2 IQcogfuncz3_mean3 IQcogfuncz3_mean4 IQcogfuncz3_mean5 IQcogfuncz3_mean6 IQcogfuncz3_mean7 IQcogfuncz3_mean8 IQcogfuncz3_mean9 IQcogfuncz3_mean10 IQcogfuncz3_mean11 IQcogfuncz3_mean12 IQcogfuncz3_mean13 IQcogfuncz3_mean14 IQcogfuncz3_mean15 IQcogfuncz3_mean16 IQcogfuncz3_mean17 IQcogfuncz3_mean18 IQcogfuncz3_mean19 IQcogfuncz3_mean20 IQcogfuncz3_mean21 IQcogfuncz3_mean22 IQcogfuncz3_mean23 IQcogfuncz3_mean24 IQcogfuncz3_mean25 IQcogfuncz3_mean26 IQcogfuncz3_mean27 IQcogfuncz3_mean28 IQcogfuncz3_mean29 IQcogfuncz3_mean30 IQcogfuncz3_mean31 IQcogfuncz3_mean32 IQcogfuncz3_mean33 IQcogfuncz3_mean34 IQcogfuncz3_mean35 IQcogfuncz3_mean36 IQcogfuncz3_mean37 IQcogfuncz3_mean38 IQcogfuncz3_mean39 IQcogfuncz3_mean40 IQcogfuncz3_mean41 IQcogfuncz3_mean42 IQcogfuncz3_mean43 IQcogfuncz3_mean44 IQcogfuncz3_mean45 IQcogfuncz3_mean46 IQcogfuncz3_mean47 IQcogfuncz3_mean48 IQcogfuncz3_mean49 IQcogfuncz3_mean50 IQcogfuncz3_mean51 IQcogfuncz3_mean52 IQcogfuncz3_mean53 IQcogfuncz3_mean54 IQcogfuncz3_mean55 IQcogfuncz3_mean56 IQcogfuncz3_mean57 IQcogfuncz3_mean58 IQcogfuncz3_mean59 IQcogfuncz3_mean60 IQcogfuncz3_mean61 IQcogfuncz3_mean62 IQcogfuncz3_mean63 IQcogfuncz3_mean64 IQcogfuncz3_mean65 IQcogfuncz3_mean66 IQcogfuncz3_mean67 IQcogfuncz3_mean68 IQcogfuncz3_mean69 IQcogfuncz3_mean70 IQcogfuncz3_mean71 IQcogfuncz3_mean72 IQcogfuncz3_mean73 IQcogfuncz3_mean74 IQcogfuncz3_mean75 IQcogfuncz3_mean76 IQcogfuncz3_mean77 IQcogfuncz3_mean78 IQcogfuncz3_mean79 IQcogfuncz3_mean80 IQcogfuncz3_mean81 IQcogfuncz3_mean82 IQcogfuncz3_mean83 IQcogfuncz3_mean84 IQcogfuncz3_mean85 IQcogfuncz3_mean86 IQcogfuncz3_mean87 IQcogfuncz3_mean88 IQcogfuncz3_mean89 IQcogfuncz3_mean90 IQcogfuncz3_mean91 IQcogfuncz3_mean92 IQcogfuncz3_mean93 IQcogfuncz3_mean94 IQcogfuncz3_mean95 IQcogfuncz3_mean96 IQcogfuncz3_mean97 IQcogfuncz3_mean98 IQcogfuncz3_mean99, ytitle(Mean of IQ/general congnitive function)
tsline IQcogfuncz3_sd1  IQcogfuncz3_sd2 IQcogfuncz3_sd3 IQcogfuncz3_sd4 IQcogfuncz3_sd5 IQcogfuncz3_sd6 IQcogfuncz3_sd7 IQcogfuncz3_sd8 IQcogfuncz3_sd9 IQcogfuncz3_sd10 IQcogfuncz3_sd11 IQcogfuncz3_sd12 IQcogfuncz3_sd13 IQcogfuncz3_sd14 IQcogfuncz3_sd15 IQcogfuncz3_sd16 IQcogfuncz3_sd17 IQcogfuncz3_sd18 IQcogfuncz3_sd19 IQcogfuncz3_sd20 IQcogfuncz3_sd21 IQcogfuncz3_sd22 IQcogfuncz3_sd23 IQcogfuncz3_sd24 IQcogfuncz3_sd25 IQcogfuncz3_sd26 IQcogfuncz3_sd27 IQcogfuncz3_sd28 IQcogfuncz3_sd29 IQcogfuncz3_sd30 IQcogfuncz3_sd31 IQcogfuncz3_sd32 IQcogfuncz3_sd33 IQcogfuncz3_sd34 IQcogfuncz3_sd35 IQcogfuncz3_sd36 IQcogfuncz3_sd37 IQcogfuncz3_sd38 IQcogfuncz3_sd39 IQcogfuncz3_sd40 IQcogfuncz3_sd41 IQcogfuncz3_sd42 IQcogfuncz3_sd43 IQcogfuncz3_sd44 IQcogfuncz3_sd45 IQcogfuncz3_sd46 IQcogfuncz3_sd47 IQcogfuncz3_sd48 IQcogfuncz3_sd49 IQcogfuncz3_sd50 IQcogfuncz3_sd51 IQcogfuncz3_sd52 IQcogfuncz3_sd53 IQcogfuncz3_sd54 IQcogfuncz3_sd55 IQcogfuncz3_sd56 IQcogfuncz3_sd57 IQcogfuncz3_sd58 IQcogfuncz3_sd59 IQcogfuncz3_sd60 IQcogfuncz3_sd61 IQcogfuncz3_sd62 IQcogfuncz3_sd63 IQcogfuncz3_sd64 IQcogfuncz3_sd65 IQcogfuncz3_sd66 IQcogfuncz3_sd67 IQcogfuncz3_sd68 IQcogfuncz3_sd69 IQcogfuncz3_sd70 IQcogfuncz3_sd71 IQcogfuncz3_sd72 IQcogfuncz3_sd73 IQcogfuncz3_sd74 IQcogfuncz3_sd75 IQcogfuncz3_sd76 IQcogfuncz3_sd77 IQcogfuncz3_sd78 IQcogfuncz3_sd79 IQcogfuncz3_sd80 IQcogfuncz3_sd81 IQcogfuncz3_sd82 IQcogfuncz3_sd83 IQcogfuncz3_sd84 IQcogfuncz3_sd85 IQcogfuncz3_sd86 IQcogfuncz3_sd87 IQcogfuncz3_sd88 IQcogfuncz3_sd89 IQcogfuncz3_sd90 IQcogfuncz3_sd91 IQcogfuncz3_sd92 IQcogfuncz3_sd93 IQcogfuncz3_sd94 IQcogfuncz3_sd95 IQcogfuncz3_sd96 IQcogfuncz3_sd97 IQcogfuncz3_sd98 IQcogfuncz3_sd99, ytitle(SD of IQ/general cognitive function)

*tsline visualspatmemz4_mean1 visualspatmemz4_mean2 visualspatmemz4_mean3 visualspatmemz4_mean4 visualspatmemz4_mean5 visualspatmemz4_mean6 visualspatmemz4_mean7 visualspatmemz4_mean8 visualspatmemz4_mean9 visualspatmemz4_mean10 visualspatmemz4_mean11 visualspatmemz4_mean12 visualspatmemz4_mean13 visualspatmemz4_mean14 visualspatmemz4_mean15 visualspatmemz4_mean16 visualspatmemz4_mean17 visualspatmemz4_mean18 visualspatmemz4_mean19 visualspatmemz4_mean20 visualspatmemz4_mean21 visualspatmemz4_mean22 visualspatmemz4_mean23 visualspatmemz4_mean24 visualspatmemz4_mean25 visualspatmemz4_mean26 visualspatmemz4_mean27 visualspatmemz4_mean28 visualspatmemz4_mean29 visualspatmemz4_mean30 visualspatmemz4_mean31 visualspatmemz4_mean32 visualspatmemz4_mean33 visualspatmemz4_mean34 visualspatmemz4_mean35 visualspatmemz4_mean36 visualspatmemz4_mean37 visualspatmemz4_mean38 visualspatmemz4_mean39 visualspatmemz4_mean40 visualspatmemz4_mean41 visualspatmemz4_mean42 visualspatmemz4_mean43 visualspatmemz4_mean44 visualspatmemz4_mean45 visualspatmemz4_mean46 visualspatmemz4_mean47 visualspatmemz4_mean48 visualspatmemz4_mean49 visualspatmemz4_mean50 visualspatmemz4_mean51 visualspatmemz4_mean52 visualspatmemz4_mean53 visualspatmemz4_mean54 visualspatmemz4_mean55 visualspatmemz4_mean56 visualspatmemz4_mean57 visualspatmemz4_mean58 visualspatmemz4_mean59 visualspatmemz4_mean60 visualspatmemz4_mean61 visualspatmemz4_mean62 visualspatmemz4_mean63 visualspatmemz4_mean64 visualspatmemz4_mean65 visualspatmemz4_mean66 visualspatmemz4_mean67 visualspatmemz4_mean68 visualspatmemz4_mean69 visualspatmemz4_mean70 visualspatmemz4_mean71 visualspatmemz4_mean72 visualspatmemz4_mean73 visualspatmemz4_mean74 visualspatmemz4_mean75 visualspatmemz4_mean76 visualspatmemz4_mean77 visualspatmemz4_mean78 visualspatmemz4_mean79 visualspatmemz4_mean80 visualspatmemz4_mean81 visualspatmemz4_mean82 visualspatmemz4_mean83 visualspatmemz4_mean84 visualspatmemz4_mean85 visualspatmemz4_mean86 visualspatmemz4_mean87 visualspatmemz4_mean88 visualspatmemz4_mean89 visualspatmemz4_mean90 visualspatmemz4_mean91 visualspatmemz4_mean92 visualspatmemz4_mean93 visualspatmemz4_mean94 visualspatmemz4_mean95 visualspatmemz4_mean96 visualspatmemz4_mean97 visualspatmemz4_mean98 visualspatmemz4_mean99 visualspatmemz4_mean100
tsline visualspatmemz4_mean1 visualspatmemz4_mean2 visualspatmemz4_mean3 visualspatmemz4_mean4 visualspatmemz4_mean5 visualspatmemz4_mean6 visualspatmemz4_mean7 visualspatmemz4_mean8 visualspatmemz4_mean9 visualspatmemz4_mean10 visualspatmemz4_mean11 visualspatmemz4_mean12 visualspatmemz4_mean13 visualspatmemz4_mean14 visualspatmemz4_mean15 visualspatmemz4_mean16 visualspatmemz4_mean17 visualspatmemz4_mean18 visualspatmemz4_mean19 visualspatmemz4_mean20 visualspatmemz4_mean21 visualspatmemz4_mean22 visualspatmemz4_mean23 visualspatmemz4_mean24 visualspatmemz4_mean25 visualspatmemz4_mean26 visualspatmemz4_mean27 visualspatmemz4_mean28 visualspatmemz4_mean29 visualspatmemz4_mean30 visualspatmemz4_mean31 visualspatmemz4_mean32 visualspatmemz4_mean33 visualspatmemz4_mean34 visualspatmemz4_mean35 visualspatmemz4_mean36 visualspatmemz4_mean37 visualspatmemz4_mean38 visualspatmemz4_mean39 visualspatmemz4_mean40 visualspatmemz4_mean41 visualspatmemz4_mean42 visualspatmemz4_mean43 visualspatmemz4_mean44 visualspatmemz4_mean45 visualspatmemz4_mean46 visualspatmemz4_mean47 visualspatmemz4_mean48 visualspatmemz4_mean49 visualspatmemz4_mean50 visualspatmemz4_mean51 visualspatmemz4_mean52 visualspatmemz4_mean53 visualspatmemz4_mean54 visualspatmemz4_mean55 visualspatmemz4_mean56 visualspatmemz4_mean57 visualspatmemz4_mean58 visualspatmemz4_mean59 visualspatmemz4_mean60 visualspatmemz4_mean61 visualspatmemz4_mean62 visualspatmemz4_mean63 visualspatmemz4_mean64 visualspatmemz4_mean65 visualspatmemz4_mean66 visualspatmemz4_mean67 visualspatmemz4_mean68 visualspatmemz4_mean69 visualspatmemz4_mean70 visualspatmemz4_mean71 visualspatmemz4_mean72 visualspatmemz4_mean73 visualspatmemz4_mean74 visualspatmemz4_mean75 visualspatmemz4_mean76 visualspatmemz4_mean77 visualspatmemz4_mean78 visualspatmemz4_mean79 visualspatmemz4_mean80 visualspatmemz4_mean81 visualspatmemz4_mean82 visualspatmemz4_mean83 visualspatmemz4_mean84 visualspatmemz4_mean85 visualspatmemz4_mean86 visualspatmemz4_mean87 visualspatmemz4_mean88 visualspatmemz4_mean89 visualspatmemz4_mean90 visualspatmemz4_mean91 visualspatmemz4_mean92 visualspatmemz4_mean93 visualspatmemz4_mean94 visualspatmemz4_mean95 visualspatmemz4_mean96 visualspatmemz4_mean97 visualspatmemz4_mean98 visualspatmemz4_mean99, ytitle("Mean of Visual-spatial memory")
tsline visualspatmemz4_sd1 visualspatmemz4_sd2 visualspatmemz4_sd3 visualspatmemz4_sd4 visualspatmemz4_sd5 visualspatmemz4_sd6 visualspatmemz4_sd7 visualspatmemz4_sd8 visualspatmemz4_sd9 visualspatmemz4_sd10 visualspatmemz4_sd11 visualspatmemz4_sd12 visualspatmemz4_sd13 visualspatmemz4_sd14 visualspatmemz4_sd15 visualspatmemz4_sd16 visualspatmemz4_sd17 visualspatmemz4_sd18 visualspatmemz4_sd19 visualspatmemz4_sd20 visualspatmemz4_sd21 visualspatmemz4_sd22 visualspatmemz4_sd23 visualspatmemz4_sd24 visualspatmemz4_sd25 visualspatmemz4_sd26 visualspatmemz4_sd27 visualspatmemz4_sd28 visualspatmemz4_sd29 visualspatmemz4_sd30 visualspatmemz4_sd31 visualspatmemz4_sd32 visualspatmemz4_sd33 visualspatmemz4_sd34 visualspatmemz4_sd35 visualspatmemz4_sd36 visualspatmemz4_sd37 visualspatmemz4_sd38 visualspatmemz4_sd39 visualspatmemz4_sd40 visualspatmemz4_sd41 visualspatmemz4_sd42 visualspatmemz4_sd43 visualspatmemz4_sd44 visualspatmemz4_sd45 visualspatmemz4_sd46 visualspatmemz4_sd47 visualspatmemz4_sd48 visualspatmemz4_sd49 visualspatmemz4_sd50 visualspatmemz4_sd51 visualspatmemz4_sd52 visualspatmemz4_sd53 visualspatmemz4_sd54 visualspatmemz4_sd55 visualspatmemz4_sd56 visualspatmemz4_sd57 visualspatmemz4_sd58 visualspatmemz4_sd59 visualspatmemz4_sd60 visualspatmemz4_sd61 visualspatmemz4_sd62 visualspatmemz4_sd63 visualspatmemz4_sd64 visualspatmemz4_sd65 visualspatmemz4_sd66 visualspatmemz4_sd67 visualspatmemz4_sd68 visualspatmemz4_sd69 visualspatmemz4_sd70 visualspatmemz4_sd71 visualspatmemz4_sd72 visualspatmemz4_sd73 visualspatmemz4_sd74 visualspatmemz4_sd75 visualspatmemz4_sd76 visualspatmemz4_sd77 visualspatmemz4_sd78 visualspatmemz4_sd79 visualspatmemz4_sd80 visualspatmemz4_sd81 visualspatmemz4_sd82 visualspatmemz4_sd83 visualspatmemz4_sd84 visualspatmemz4_sd85 visualspatmemz4_sd86 visualspatmemz4_sd87 visualspatmemz4_sd88 visualspatmemz4_sd89 visualspatmemz4_sd90 visualspatmemz4_sd91 visualspatmemz4_sd92 visualspatmemz4_sd93 visualspatmemz4_sd94 visualspatmemz4_sd95 visualspatmemz4_sd96 visualspatmemz4_sd97 visualspatmemz4_sd98 visualspatmemz4_sd99, ytitle("SD of Visual-spatial memory")

*tsline verbintellz5_mean1 verbintellz5_mean2 verbintellz5_mean3 verbintellz5_mean4 verbintellz5_mean5 verbintellz5_mean6 verbintellz5_mean7 verbintellz5_mean8 verbintellz5_mean9 verbintellz5_mean10 verbintellz5_mean11 verbintellz5_mean12 verbintellz5_mean13 verbintellz5_mean14 verbintellz5_mean15 verbintellz5_mean16 verbintellz5_mean17 verbintellz5_mean18 verbintellz5_mean19 verbintellz5_mean20 verbintellz5_mean21 verbintellz5_mean22 verbintellz5_mean23 verbintellz5_mean24 verbintellz5_mean25 verbintellz5_mean26 verbintellz5_mean27 verbintellz5_mean28 verbintellz5_mean29 verbintellz5_mean30 verbintellz5_mean31 verbintellz5_mean32 verbintellz5_mean33 verbintellz5_mean34 verbintellz5_mean35 verbintellz5_mean36 verbintellz5_mean37 verbintellz5_mean38 verbintellz5_mean39 verbintellz5_mean40 verbintellz5_mean41 verbintellz5_mean42 verbintellz5_mean43 verbintellz5_mean44 verbintellz5_mean45 verbintellz5_mean46 verbintellz5_mean47 verbintellz5_mean48 verbintellz5_mean49 verbintellz5_mean50 verbintellz5_mean51 verbintellz5_mean52 verbintellz5_mean53 verbintellz5_mean54 verbintellz5_mean55 verbintellz5_mean56 verbintellz5_mean57 verbintellz5_mean58 verbintellz5_mean59 verbintellz5_mean60 verbintellz5_mean61 verbintellz5_mean62 verbintellz5_mean63 verbintellz5_mean64 verbintellz5_mean65 verbintellz5_mean66 verbintellz5_mean67 verbintellz5_mean68 verbintellz5_mean69 verbintellz5_mean70 verbintellz5_mean71 verbintellz5_mean72 verbintellz5_mean73 verbintellz5_mean74 verbintellz5_mean75 verbintellz5_mean76 verbintellz5_mean77 verbintellz5_mean78 verbintellz5_mean79 verbintellz5_mean80 verbintellz5_mean81 verbintellz5_mean82 verbintellz5_mean83 verbintellz5_mean84 verbintellz5_mean85 verbintellz5_mean86 verbintellz5_mean87 verbintellz5_mean88 verbintellz5_mean89 verbintellz5_mean90 verbintellz5_mean91 verbintellz5_mean92 verbintellz5_mean93 verbintellz5_mean94 verbintellz5_mean95 verbintellz5_mean96 verbintellz5_mean97 verbintellz5_mean98 verbintellz5_mean99 verbintellz5_mean100
tsline verbintellz5_mean1 verbintellz5_mean2 verbintellz5_mean3 verbintellz5_mean4 verbintellz5_mean5 verbintellz5_mean6 verbintellz5_mean7 verbintellz5_mean8 verbintellz5_mean9 verbintellz5_mean10 verbintellz5_mean11 verbintellz5_mean12 verbintellz5_mean13 verbintellz5_mean14 verbintellz5_mean15 verbintellz5_mean16 verbintellz5_mean17 verbintellz5_mean18 verbintellz5_mean19 verbintellz5_mean20 verbintellz5_mean21 verbintellz5_mean22 verbintellz5_mean23 verbintellz5_mean24 verbintellz5_mean25 verbintellz5_mean26 verbintellz5_mean27 verbintellz5_mean28 verbintellz5_mean29 verbintellz5_mean30 verbintellz5_mean31 verbintellz5_mean32 verbintellz5_mean33 verbintellz5_mean34 verbintellz5_mean35 verbintellz5_mean36 verbintellz5_mean37 verbintellz5_mean38 verbintellz5_mean39 verbintellz5_mean40 verbintellz5_mean41 verbintellz5_mean42 verbintellz5_mean43 verbintellz5_mean44 verbintellz5_mean45 verbintellz5_mean46 verbintellz5_mean47 verbintellz5_mean48 verbintellz5_mean49 verbintellz5_mean50 verbintellz5_mean51 verbintellz5_mean52 verbintellz5_mean53 verbintellz5_mean54 verbintellz5_mean55 verbintellz5_mean56 verbintellz5_mean57 verbintellz5_mean58 verbintellz5_mean59 verbintellz5_mean60 verbintellz5_mean61 verbintellz5_mean62 verbintellz5_mean63 verbintellz5_mean64 verbintellz5_mean65 verbintellz5_mean66 verbintellz5_mean67 verbintellz5_mean68 verbintellz5_mean69 verbintellz5_mean70 verbintellz5_mean71 verbintellz5_mean72 verbintellz5_mean73 verbintellz5_mean74 verbintellz5_mean75 verbintellz5_mean76 verbintellz5_mean77 verbintellz5_mean78 verbintellz5_mean79 verbintellz5_mean80 verbintellz5_mean81 verbintellz5_mean82 verbintellz5_mean83 verbintellz5_mean84 verbintellz5_mean85 verbintellz5_mean86 verbintellz5_mean87 verbintellz5_mean88 verbintellz5_mean89 verbintellz5_mean90 verbintellz5_mean91 verbintellz5_mean92 verbintellz5_mean93 verbintellz5_mean94 verbintellz5_mean95 verbintellz5_mean96 verbintellz5_mean97 verbintellz5_mean98 verbintellz5_mean99, ytitle("Mean of Verbal Intelligence")
tsline verbintellz5_sd1 verbintellz5_sd2 verbintellz5_sd3 verbintellz5_sd4 verbintellz5_sd5 verbintellz5_sd6 verbintellz5_sd7 verbintellz5_sd8 verbintellz5_sd9 verbintellz5_sd10 verbintellz5_sd11 verbintellz5_sd12 verbintellz5_sd13 verbintellz5_sd14 verbintellz5_sd15 verbintellz5_sd16 verbintellz5_sd17 verbintellz5_sd18 verbintellz5_sd19 verbintellz5_sd20 verbintellz5_sd21 verbintellz5_sd22 verbintellz5_sd23 verbintellz5_sd24 verbintellz5_sd25 verbintellz5_sd26 verbintellz5_sd27 verbintellz5_sd28 verbintellz5_sd29 verbintellz5_sd30 verbintellz5_sd31 verbintellz5_sd32 verbintellz5_sd33 verbintellz5_sd34 verbintellz5_sd35 verbintellz5_sd36 verbintellz5_sd37 verbintellz5_sd38 verbintellz5_sd39 verbintellz5_sd40 verbintellz5_sd41 verbintellz5_sd42 verbintellz5_sd43 verbintellz5_sd44 verbintellz5_sd45 verbintellz5_sd46 verbintellz5_sd47 verbintellz5_sd48 verbintellz5_sd49 verbintellz5_sd50 verbintellz5_sd51 verbintellz5_sd52 verbintellz5_sd53 verbintellz5_sd54 verbintellz5_sd55 verbintellz5_sd56 verbintellz5_sd57 verbintellz5_sd58 verbintellz5_sd59 verbintellz5_sd60 verbintellz5_sd61 verbintellz5_sd62 verbintellz5_sd63 verbintellz5_sd64 verbintellz5_sd65 verbintellz5_sd66 verbintellz5_sd67 verbintellz5_sd68 verbintellz5_sd69 verbintellz5_sd70 verbintellz5_sd71 verbintellz5_sd72 verbintellz5_sd73 verbintellz5_sd74 verbintellz5_sd75 verbintellz5_sd76 verbintellz5_sd77 verbintellz5_sd78 verbintellz5_sd79 verbintellz5_sd80 verbintellz5_sd81 verbintellz5_sd82 verbintellz5_sd83 verbintellz5_sd84 verbintellz5_sd85 verbintellz5_sd86 verbintellz5_sd87 verbintellz5_sd88 verbintellz5_sd89 verbintellz5_sd90 verbintellz5_sd91 verbintellz5_sd92 verbintellz5_sd93 verbintellz5_sd94 verbintellz5_sd95 verbintellz5_sd96 verbintellz5_sd97 verbintellz5_sd98 verbintellz5_sd99, ytitle("SD of Verbal Intelligence")

*tsline verbmemz6_mean1 verbmemz6_mean2 verbmemz6_mean3 verbmemz6_mean4 verbmemz6_mean5 verbmemz6_mean6 verbmemz6_mean7 verbmemz6_mean8 verbmemz6_mean9 verbmemz6_mean10 verbmemz6_mean11 verbmemz6_mean12 verbmemz6_mean13 verbmemz6_mean14 verbmemz6_mean15 verbmemz6_mean16 verbmemz6_mean17 verbmemz6_mean18 verbmemz6_mean19 verbmemz6_mean20 verbmemz6_mean21 verbmemz6_mean22 verbmemz6_mean23 verbmemz6_mean24 verbmemz6_mean25 verbmemz6_mean26 verbmemz6_mean27 verbmemz6_mean28 verbmemz6_mean29 verbmemz6_mean30 verbmemz6_mean31 verbmemz6_mean32 verbmemz6_mean33 verbmemz6_mean34 verbmemz6_mean35 verbmemz6_mean36 verbmemz6_mean37 verbmemz6_mean38 verbmemz6_mean39 verbmemz6_mean40 verbmemz6_mean41 verbmemz6_mean42 verbmemz6_mean43 verbmemz6_mean44 verbmemz6_mean45 verbmemz6_mean46 verbmemz6_mean47 verbmemz6_mean48 verbmemz6_mean49 verbmemz6_mean50 verbmemz6_mean51 verbmemz6_mean52 verbmemz6_mean53 verbmemz6_mean54 verbmemz6_mean55 verbmemz6_mean56 verbmemz6_mean57 verbmemz6_mean58 verbmemz6_mean59 verbmemz6_mean60 verbmemz6_mean61 verbmemz6_mean62 verbmemz6_mean63 verbmemz6_mean64 verbmemz6_mean65 verbmemz6_mean66 verbmemz6_mean67 verbmemz6_mean68 verbmemz6_mean69 verbmemz6_mean70 verbmemz6_mean71 verbmemz6_mean72 verbmemz6_mean73 verbmemz6_mean74 verbmemz6_mean75 verbmemz6_mean76 verbmemz6_mean77 verbmemz6_mean78 verbmemz6_mean79 verbmemz6_mean80 verbmemz6_mean81 verbmemz6_mean82 verbmemz6_mean83 verbmemz6_mean84 verbmemz6_mean85 verbmemz6_mean86 verbmemz6_mean87 verbmemz6_mean88 verbmemz6_mean89 verbmemz6_mean90 verbmemz6_mean91 verbmemz6_mean92 verbmemz6_mean93 verbmemz6_mean94 verbmemz6_mean95 verbmemz6_mean96 verbmemz6_mean97 verbmemz6_mean98 verbmemz6_mean99 verbmemz6_mean100
tsline verbmemz6_mean1 verbmemz6_mean2 verbmemz6_mean3 verbmemz6_mean4 verbmemz6_mean5 verbmemz6_mean6 verbmemz6_mean7 verbmemz6_mean8 verbmemz6_mean9 verbmemz6_mean10 verbmemz6_mean11 verbmemz6_mean12 verbmemz6_mean13 verbmemz6_mean14 verbmemz6_mean15 verbmemz6_mean16 verbmemz6_mean17 verbmemz6_mean18 verbmemz6_mean19 verbmemz6_mean20 verbmemz6_mean21 verbmemz6_mean22 verbmemz6_mean23 verbmemz6_mean24 verbmemz6_mean25 verbmemz6_mean26 verbmemz6_mean27 verbmemz6_mean28 verbmemz6_mean29 verbmemz6_mean30 verbmemz6_mean31 verbmemz6_mean32 verbmemz6_mean33 verbmemz6_mean34 verbmemz6_mean35 verbmemz6_mean36 verbmemz6_mean37 verbmemz6_mean38 verbmemz6_mean39 verbmemz6_mean40 verbmemz6_mean41 verbmemz6_mean42 verbmemz6_mean43 verbmemz6_mean44 verbmemz6_mean45 verbmemz6_mean46 verbmemz6_mean47 verbmemz6_mean48 verbmemz6_mean49 verbmemz6_mean50 verbmemz6_mean51 verbmemz6_mean52 verbmemz6_mean53 verbmemz6_mean54 verbmemz6_mean55 verbmemz6_mean56 verbmemz6_mean57 verbmemz6_mean58 verbmemz6_mean59 verbmemz6_mean60 verbmemz6_mean61 verbmemz6_mean62 verbmemz6_mean63 verbmemz6_mean64 verbmemz6_mean65 verbmemz6_mean66 verbmemz6_mean67 verbmemz6_mean68 verbmemz6_mean69 verbmemz6_mean70 verbmemz6_mean71 verbmemz6_mean72 verbmemz6_mean73 verbmemz6_mean74 verbmemz6_mean75 verbmemz6_mean76 verbmemz6_mean77 verbmemz6_mean78 verbmemz6_mean79 verbmemz6_mean80 verbmemz6_mean81 verbmemz6_mean82 verbmemz6_mean83 verbmemz6_mean84 verbmemz6_mean85 verbmemz6_mean86 verbmemz6_mean87 verbmemz6_mean88 verbmemz6_mean89 verbmemz6_mean90 verbmemz6_mean91 verbmemz6_mean92 verbmemz6_mean93 verbmemz6_mean94 verbmemz6_mean95 verbmemz6_mean96 verbmemz6_mean97 verbmemz6_mean98 verbmemz6_mean99, ytitle("Mean of Verbal Memory")
tsline verbmemz6_sd1 verbmemz6_sd2 verbmemz6_sd3 verbmemz6_sd4 verbmemz6_sd5 verbmemz6_sd6 verbmemz6_sd7 verbmemz6_sd8 verbmemz6_sd9 verbmemz6_sd10 verbmemz6_sd11 verbmemz6_sd12 verbmemz6_sd13 verbmemz6_sd14 verbmemz6_sd15 verbmemz6_sd16 verbmemz6_sd17 verbmemz6_sd18 verbmemz6_sd19 verbmemz6_sd20 verbmemz6_sd21 verbmemz6_sd22 verbmemz6_sd23 verbmemz6_sd24 verbmemz6_sd25 verbmemz6_sd26 verbmemz6_sd27 verbmemz6_sd28 verbmemz6_sd29 verbmemz6_sd30 verbmemz6_sd31 verbmemz6_sd32 verbmemz6_sd33 verbmemz6_sd34 verbmemz6_sd35 verbmemz6_sd36 verbmemz6_sd37 verbmemz6_sd38 verbmemz6_sd39 verbmemz6_sd40 verbmemz6_sd41 verbmemz6_sd42 verbmemz6_sd43 verbmemz6_sd44 verbmemz6_sd45 verbmemz6_sd46 verbmemz6_sd47 verbmemz6_sd48 verbmemz6_sd49 verbmemz6_sd50 verbmemz6_sd51 verbmemz6_sd52 verbmemz6_sd53 verbmemz6_sd54 verbmemz6_sd55 verbmemz6_sd56 verbmemz6_sd57 verbmemz6_sd58 verbmemz6_sd59 verbmemz6_sd60 verbmemz6_sd61 verbmemz6_sd62 verbmemz6_sd63 verbmemz6_sd64 verbmemz6_sd65 verbmemz6_sd66 verbmemz6_sd67 verbmemz6_sd68 verbmemz6_sd69 verbmemz6_sd70 verbmemz6_sd71 verbmemz6_sd72 verbmemz6_sd73 verbmemz6_sd74 verbmemz6_sd75 verbmemz6_sd76 verbmemz6_sd77 verbmemz6_sd78 verbmemz6_sd79 verbmemz6_sd80 verbmemz6_sd81 verbmemz6_sd82 verbmemz6_sd83 verbmemz6_sd84 verbmemz6_sd85 verbmemz6_sd86 verbmemz6_sd87 verbmemz6_sd88 verbmemz6_sd89 verbmemz6_sd90 verbmemz6_sd91 verbmemz6_sd92 verbmemz6_sd93 verbmemz6_sd94 verbmemz6_sd95 verbmemz6_sd96 verbmemz6_sd97 verbmemz6_sd98 verbmemz6_sd99, ytitle("SD of Verbal Memory")

*tsline visuaspatintellz7_mean1 visuaspatintellz7_mean2 visuaspatintellz7_mean3 visuaspatintellz7_mean4 visuaspatintellz7_mean5 visuaspatintellz7_mean6 visuaspatintellz7_mean7 visuaspatintellz7_mean8 visuaspatintellz7_mean9 visuaspatintellz7_mean10 visuaspatintellz7_mean11 visuaspatintellz7_mean12 visuaspatintellz7_mean13 visuaspatintellz7_mean14 visuaspatintellz7_mean15 visuaspatintellz7_mean16 visuaspatintellz7_mean17 visuaspatintellz7_mean18 visuaspatintellz7_mean19 visuaspatintellz7_mean20 visuaspatintellz7_mean21 visuaspatintellz7_mean22 visuaspatintellz7_mean23 visuaspatintellz7_mean24 visuaspatintellz7_mean25 visuaspatintellz7_mean26 visuaspatintellz7_mean27 visuaspatintellz7_mean28 visuaspatintellz7_mean29 visuaspatintellz7_mean30 visuaspatintellz7_mean31 visuaspatintellz7_mean32 visuaspatintellz7_mean33 visuaspatintellz7_mean34 visuaspatintellz7_mean35 visuaspatintellz7_mean36 visuaspatintellz7_mean37 visuaspatintellz7_mean38 visuaspatintellz7_mean39 visuaspatintellz7_mean40 visuaspatintellz7_mean41 visuaspatintellz7_mean42 visuaspatintellz7_mean43 visuaspatintellz7_mean44 visuaspatintellz7_mean45 visuaspatintellz7_mean46 visuaspatintellz7_mean47 visuaspatintellz7_mean48 visuaspatintellz7_mean49 visuaspatintellz7_mean50 visuaspatintellz7_mean51 visuaspatintellz7_mean52 visuaspatintellz7_mean53 visuaspatintellz7_mean54 visuaspatintellz7_mean55 visuaspatintellz7_mean56 visuaspatintellz7_mean57 visuaspatintellz7_mean58 visuaspatintellz7_mean59 visuaspatintellz7_mean60 visuaspatintellz7_mean61 visuaspatintellz7_mean62 visuaspatintellz7_mean63 visuaspatintellz7_mean64 visuaspatintellz7_mean65 visuaspatintellz7_mean66 visuaspatintellz7_mean67 visuaspatintellz7_mean68 visuaspatintellz7_mean69 visuaspatintellz7_mean70 visuaspatintellz7_mean71 visuaspatintellz7_mean72 visuaspatintellz7_mean73 visuaspatintellz7_mean74 visuaspatintellz7_mean75 visuaspatintellz7_mean76 visuaspatintellz7_mean77 visuaspatintellz7_mean78 visuaspatintellz7_mean79 visuaspatintellz7_mean80 visuaspatintellz7_mean81 visuaspatintellz7_mean82 visuaspatintellz7_mean83 visuaspatintellz7_mean84 visuaspatintellz7_mean85 visuaspatintellz7_mean86 visuaspatintellz7_mean87 visuaspatintellz7_mean88 visuaspatintellz7_mean89 visuaspatintellz7_mean90 visuaspatintellz7_mean91 visuaspatintellz7_mean92 visuaspatintellz7_mean93 visuaspatintellz7_mean94 visuaspatintellz7_mean95 visuaspatintellz7_mean96 visuaspatintellz7_mean97 visuaspatintellz7_mean98 visuaspatintellz7_mean99 visuaspatintellz7_mean100
tsline visuaspatintellz7_mean1 visuaspatintellz7_mean2 visuaspatintellz7_mean3 visuaspatintellz7_mean4 visuaspatintellz7_mean5 visuaspatintellz7_mean6 visuaspatintellz7_mean7 visuaspatintellz7_mean8 visuaspatintellz7_mean9 visuaspatintellz7_mean10 visuaspatintellz7_mean11 visuaspatintellz7_mean12 visuaspatintellz7_mean13 visuaspatintellz7_mean14 visuaspatintellz7_mean15 visuaspatintellz7_mean16 visuaspatintellz7_mean17 visuaspatintellz7_mean18 visuaspatintellz7_mean19 visuaspatintellz7_mean20 visuaspatintellz7_mean21 visuaspatintellz7_mean22 visuaspatintellz7_mean23 visuaspatintellz7_mean24 visuaspatintellz7_mean25 visuaspatintellz7_mean26 visuaspatintellz7_mean27 visuaspatintellz7_mean28 visuaspatintellz7_mean29 visuaspatintellz7_mean30 visuaspatintellz7_mean31 visuaspatintellz7_mean32 visuaspatintellz7_mean33 visuaspatintellz7_mean34 visuaspatintellz7_mean35 visuaspatintellz7_mean36 visuaspatintellz7_mean37 visuaspatintellz7_mean38 visuaspatintellz7_mean39 visuaspatintellz7_mean40 visuaspatintellz7_mean41 visuaspatintellz7_mean42 visuaspatintellz7_mean43 visuaspatintellz7_mean44 visuaspatintellz7_mean45 visuaspatintellz7_mean46 visuaspatintellz7_mean47 visuaspatintellz7_mean48 visuaspatintellz7_mean49 visuaspatintellz7_mean50 visuaspatintellz7_mean51 visuaspatintellz7_mean52 visuaspatintellz7_mean53 visuaspatintellz7_mean54 visuaspatintellz7_mean55 visuaspatintellz7_mean56 visuaspatintellz7_mean57 visuaspatintellz7_mean58 visuaspatintellz7_mean59 visuaspatintellz7_mean60 visuaspatintellz7_mean61 visuaspatintellz7_mean62 visuaspatintellz7_mean63 visuaspatintellz7_mean64 visuaspatintellz7_mean65 visuaspatintellz7_mean66 visuaspatintellz7_mean67 visuaspatintellz7_mean68 visuaspatintellz7_mean69 visuaspatintellz7_mean70 visuaspatintellz7_mean71 visuaspatintellz7_mean72 visuaspatintellz7_mean73 visuaspatintellz7_mean74 visuaspatintellz7_mean75 visuaspatintellz7_mean76 visuaspatintellz7_mean77 visuaspatintellz7_mean78 visuaspatintellz7_mean79 visuaspatintellz7_mean80 visuaspatintellz7_mean81 visuaspatintellz7_mean82 visuaspatintellz7_mean83 visuaspatintellz7_mean84 visuaspatintellz7_mean85 visuaspatintellz7_mean86 visuaspatintellz7_mean87 visuaspatintellz7_mean88 visuaspatintellz7_mean89 visuaspatintellz7_mean90 visuaspatintellz7_mean91 visuaspatintellz7_mean92 visuaspatintellz7_mean93 visuaspatintellz7_mean94 visuaspatintellz7_mean95 visuaspatintellz7_mean96 visuaspatintellz7_mean97 visuaspatintellz7_mean98 visuaspatintellz7_mean99, ytitle("Mean of Visual-spatial intelligence")
tsline visuaspatintellz7_sd1 visuaspatintellz7_sd2 visuaspatintellz7_sd3 visuaspatintellz7_sd4 visuaspatintellz7_sd5 visuaspatintellz7_sd6 visuaspatintellz7_sd7 visuaspatintellz7_sd8 visuaspatintellz7_sd9 visuaspatintellz7_sd10 visuaspatintellz7_sd11 visuaspatintellz7_sd12 visuaspatintellz7_sd13 visuaspatintellz7_sd14 visuaspatintellz7_sd15 visuaspatintellz7_sd16 visuaspatintellz7_sd17 visuaspatintellz7_sd18 visuaspatintellz7_sd19 visuaspatintellz7_sd20 visuaspatintellz7_sd21 visuaspatintellz7_sd22 visuaspatintellz7_sd23 visuaspatintellz7_sd24 visuaspatintellz7_sd25 visuaspatintellz7_sd26 visuaspatintellz7_sd27 visuaspatintellz7_sd28 visuaspatintellz7_sd29 visuaspatintellz7_sd30 visuaspatintellz7_sd31 visuaspatintellz7_sd32 visuaspatintellz7_sd33 visuaspatintellz7_sd34 visuaspatintellz7_sd35 visuaspatintellz7_sd36 visuaspatintellz7_sd37 visuaspatintellz7_sd38 visuaspatintellz7_sd39 visuaspatintellz7_sd40 visuaspatintellz7_sd41 visuaspatintellz7_sd42 visuaspatintellz7_sd43 visuaspatintellz7_sd44 visuaspatintellz7_sd45 visuaspatintellz7_sd46 visuaspatintellz7_sd47 visuaspatintellz7_sd48 visuaspatintellz7_sd49 visuaspatintellz7_sd50 visuaspatintellz7_sd51 visuaspatintellz7_sd52 visuaspatintellz7_sd53 visuaspatintellz7_sd54 visuaspatintellz7_sd55 visuaspatintellz7_sd56 visuaspatintellz7_sd57 visuaspatintellz7_sd58 visuaspatintellz7_sd59 visuaspatintellz7_sd60 visuaspatintellz7_sd61 visuaspatintellz7_sd62 visuaspatintellz7_sd63 visuaspatintellz7_sd64 visuaspatintellz7_sd65 visuaspatintellz7_sd66 visuaspatintellz7_sd67 visuaspatintellz7_sd68 visuaspatintellz7_sd69 visuaspatintellz7_sd70 visuaspatintellz7_sd71 visuaspatintellz7_sd72 visuaspatintellz7_sd73 visuaspatintellz7_sd74 visuaspatintellz7_sd75 visuaspatintellz7_sd76 visuaspatintellz7_sd77 visuaspatintellz7_sd78 visuaspatintellz7_sd79 visuaspatintellz7_sd80 visuaspatintellz7_sd81 visuaspatintellz7_sd82 visuaspatintellz7_sd83 visuaspatintellz7_sd84 visuaspatintellz7_sd85 visuaspatintellz7_sd86 visuaspatintellz7_sd87 visuaspatintellz7_sd88 visuaspatintellz7_sd89 visuaspatintellz7_sd90 visuaspatintellz7_sd91 visuaspatintellz7_sd92 visuaspatintellz7_sd93 visuaspatintellz7_sd94 visuaspatintellz7_sd95 visuaspatintellz7_sd96 visuaspatintellz7_sd97 visuaspatintellz7_sd98 visuaspatintellz7_sd99, ytitle("SD of Visual-spatial intelligence")



*QQPlot 

qqplot execfunctionz1_mean1 execfunctionz1_mean100, name(g12)
qqplot  attenworkspeedz2_mean1  attenworkspeedz2_mean100, name(g22)
qqplot IQcogfuncz3_mean1 IQcogfuncz3_mean100, name(g32)
qqplot visualspatmemz4_mean1 visualspatmemz4_mean100, name(g42)
qqplot verbintellz5_mean1 verbintellz5_mean100, name(g52)
qqplot verbmemz6_mean1 verbmemz6_mean100, name(g62)
qqplot visuaspatintellz7_mean1 visuaspatintellz7_mean100, name(g72)

graph combine g12 g22 g32 g42 g52 g62 g72


qqplot execfunctionz1_sd1 execfunctionz1_sd100, name(s12)
qqplot  attenworkspeedz2_sd1  attenworkspeedz2_sd100, name(s22)
qqplot IQcogfuncz3_sd1 IQcogfuncz3_sd100, name(s32)
qqplot visualspatmemz4_sd1 visualspatmemz4_sd100, name(s42)
qqplot verbintellz5_sd1 verbintellz5_sd100, name(s52)
qqplot verbmemz6_sd1 verbmemz6_sd100, name(s62)
qqplot visuaspatintellz7_sd1 visuaspatintellz7_sd100, name(s72)

graph combine s12 s22 s32 s42 s52 s62 s72



********************************************************************************************************************************************************
*Step 3:
*Final imputation model and analysis of cognitive domains 
********************************************************************************************************************************************************



*Results reported in Table 4
*(as well as additional in the supplementary material; Table S.4.1 and Table S.4.2)


*For further information about auxillary variable selection please see section: MICE MODEL Auxillary variable selection
*Variables to specify in model (as well as the cognitive domain):

*Preparing imputation dataset:
clear all
use "/Users/edwardmillgate/Desktop/cognition_18052021.dta"
keep idstrata diagnosisBLstrata02 cohort cohortstrata execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 
save "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"


*rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 


*1. Executive function
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed execfunctionz1 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) execfunctionz1 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever execfunctionz1
mi estimate, dots mcerror: logit strataeitherever execfunctionz1 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever execfunctionz1
mi estimate, dots mcerror or: logit strataeitherever execfunctionz1 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup



*2. Attention, wokring memory & processing speed
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed attenworkspeedz2 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) attenworkspeedz2 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever attenworkspeedz2
mi estimate, dots mcerror: logit strataeitherever attenworkspeedz2 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever attenworkspeedz2
mi estimate, dots mcerror or: logit strataeitherever attenworkspeedz2 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup



*3. IQ/General cognitive functioning
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed IQcogfuncz3 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) IQcogfuncz3 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever IQcogfuncz3
mi estimate, dots mcerror: logit strataeitherever IQcogfuncz3 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever IQcogfuncz3
mi estimate, dots mcerror or: logit strataeitherever IQcogfuncz3 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*4. Visual-spatial memory 
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed visualspatmemz4 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) visualspatmemz4 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever visualspatmemz4
mi estimate, dots mcerror: logit strataeitherever visualspatmemz4 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever visualspatmemz4
mi estimate, dots mcerror or: logit strataeitherever visualspatmemz4 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*5. Verbal intelligence & processing
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed verbintellz5 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) verbintellz5 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever verbintellz5
mi estimate, dots mcerror: logit strataeitherever verbintellz5 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever verbintellz5
mi estimate, dots mcerror or: logit strataeitherever verbintellz5 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*6. Verbal memory & learning 
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed verbmemz6 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) verbmemz6 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever verbmemz6
mi estimate, dots mcerror: logit strataeitherever verbmemz6 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever verbmemz6
mi estimate, dots mcerror or: logit strataeitherever verbmemz6 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

*7. Visual-spatial intelligence

clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever visuaspatintellz7
mi estimate, dots mcerror: logit strataeitherever visuaspatintellz7 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever visuaspatintellz7
mi estimate, dots mcerror or: logit strataeitherever visuaspatintellz7 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup





********************************************************************************************************************************************************
******************Supplementary analysis Table S.4.1***********************
********************************************************************************************************************************************************

*Only schizophrenia samples


*1. Executive function
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
keep if diagnosisBLstrata02 == 1
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed execfunctionz1 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) execfunctionz1 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever execfunctionz1
mi estimate, dots mcerror: logit strataeitherever execfunctionz1 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever execfunctionz1
mi estimate, dots mcerror or: logit strataeitherever execfunctionz1 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup



*2. Attention, wokring memory & processing speed
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
keep if diagnosisBLstrata02 == 1
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed attenworkspeedz2 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) attenworkspeedz2 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever attenworkspeedz2
mi estimate, dots mcerror: logit strataeitherever attenworkspeedz2 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever attenworkspeedz2
mi estimate, dots mcerror or: logit strataeitherever attenworkspeedz2 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup



*3. IQ/General cognitive functioning
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
keep if diagnosisBLstrata02 == 1
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed IQcogfuncz3 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) IQcogfuncz3 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever IQcogfuncz3
mi estimate, dots mcerror: logit strataeitherever IQcogfuncz3 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever IQcogfuncz3
mi estimate, dots mcerror or: logit strataeitherever IQcogfuncz3 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*4. Visual-spatial memory 
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
keep if diagnosisBLstrata02 == 1
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed visualspatmemz4 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) visualspatmemz4 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever visualspatmemz4
mi estimate, dots mcerror: logit strataeitherever visualspatmemz4 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever visualspatmemz4
mi estimate, dots mcerror or: logit strataeitherever visualspatmemz4 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*5. Verbal intelligence & processing
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
keep if diagnosisBLstrata02 == 1
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed verbintellz5 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) verbintellz5 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever verbintellz5
mi estimate, dots mcerror: logit strataeitherever verbintellz5 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever verbintellz5
mi estimate, dots mcerror or: logit strataeitherever verbintellz5 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*6. Verbal memory & learning 
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
keep if diagnosisBLstrata02 == 1
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed verbmemz6 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) verbmemz6 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever verbmemz6
mi estimate, dots mcerror: logit strataeitherever verbmemz6 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever verbmemz6
mi estimate, dots mcerror or: logit strataeitherever verbmemz6 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*7. Visual-spatial intelligence

clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
keep if diagnosisBLstrata02 == 1
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataeitherever visuaspatintellz7
mi estimate, dots mcerror: logit strataeitherever visuaspatintellz7 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataeitherever visuaspatintellz7
mi estimate, dots mcerror or: logit strataeitherever visuaspatintellz7 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


********************************************************************************************************************************************************
******************Supplementary analysis Table S.4.2************************
********************************************************************************************************************************************************

***Prediciting clozapine ever use

*1. Executive function
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed execfunctionz1 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) execfunctionz1 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataclozeverbinary execfunctionz1
mi estimate, dots mcerror: logit strataclozeverbinary execfunctionz1 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataclozeverbinary execfunctionz1
mi estimate, dots mcerror or: logit strataclozeverbinary execfunctionz1 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup



*2. Attention, wokring memory & processing speed
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed attenworkspeedz2 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) attenworkspeedz2 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataclozeverbinary attenworkspeedz2
mi estimate, dots mcerror: logit strataclozeverbinary attenworkspeedz2 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataclozeverbinary attenworkspeedz2
mi estimate, dots mcerror or: logit strataclozeverbinary attenworkspeedz2 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup



*3. IQ/General cognitive functioning
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed IQcogfuncz3 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) IQcogfuncz3 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataclozeverbinary IQcogfuncz3
mi estimate, dots mcerror: logit strataclozeverbinary IQcogfuncz3 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataclozeverbinary IQcogfuncz3
mi estimate, dots mcerror or: logit strataclozeverbinary IQcogfuncz3 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*4. Visual-spatial memory 
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed visualspatmemz4 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) visualspatmemz4 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataclozeverbinary visualspatmemz4
mi estimate, dots mcerror: logit strataclozeverbinary visualspatmemz4 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataclozeverbinary visualspatmemz4
mi estimate, dots mcerror or: logit strataclozeverbinary visualspatmemz4 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*5. Verbal intelligence & processing
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed verbintellz5 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) verbintellz5 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataclozeverbinary verbintellz5
mi estimate, dots mcerror: logit strataclozeverbinary verbintellz5 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataclozeverbinary verbintellz5
mi estimate, dots mcerror or: logit strataclozeverbinary verbintellz5 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


*6. Verbal memory & learning 
clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed verbmemz6 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) verbmemz6 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataclozeverbinary verbmemz6
mi estimate, dots mcerror: logit strataclozeverbinary verbmemz6 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup


mi estimate, dots mcerror or: logit strataclozeverbinary verbmemz6
mi estimate, dots mcerror or: logit strataclozeverbinary verbmemz6 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

*7. Visual-spatial intelligence

clear all
use "/Users/edwardmillgate/Desktop/imputationdatasett01.dta"
mi set wide
mi xtset, clear
mi stset, clear
mi register imputed visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 strataeitherever cohortstrata02 lengthfollowup strataclozeverbinary 

   
mi impute chained (regress) visuaspatintellz7 rf_baseline rf_onset rf_gender rf_bmi rf_dup rf_livingcurr rf_cannabis rf_alcohol rf_sans rf_saps rf_ethnicity02 rf_modeonset02 lengthfollowup strataclozeverbinary  = strataeitherever cohortstrata02, add(100) burnin(20) rseed(1000) force

mi estimate, dots mcerror: logit strataclozeverbinary visuaspatintellz7
mi estimate, dots mcerror: logit strataclozeverbinary visuaspatintellz7 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup

mi estimate, dots mcerror or: logit strataclozeverbinary visuaspatintellz7
mi estimate, dots mcerror or: logit strataclozeverbinary visuaspatintellz7 rf_baseline rf_gender cohortstrata02 lengthfollowup rf_saps rf_sans rf_dup





********************************************************************************************************************************************************
*************** Extra supplementary material/methods tables*******************
********************************************************************************************************************************************************

*Cogntiive data per cohort (supplementary). Table S.2.
bysort cohortstrata02: su execfunctionz1
bysort cohortstrata02: attenworkspeedz2 
bysort cohortstrata02: IQcogfuncz3 
bysort cohortstrata02: visualspatmemz4 
bysort cohortstrata02: verbintellz5
bysort cohortstrata02: verbmemz6
bysort cohortstrata02: visuaspatintellz7

*Proportion of missing data
mdesc execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7


*Summaries for those only with a schizophrenia diagnosis (supplementary) Table S.3.2
tab diagnosisBLstrata02
tab diagnosisBLstrata01

keep if diagnosisBLstrata02 == 1
bysort strataeitherever: su execfunctionz1
bysort strataeitherever: su attenworkspeedz2
bysort strataeitherever: su IQcogfuncz3
bysort strataeitherever: su visualspatmemz4
bysort strataeitherever: su verbintellz5
bysort strataeitherever: su verbmemz6
bysort strataeitherever: su visuaspatintellz7

*Re-run *Proportion of missing data: 
mdesc execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7

clear all 
use "/Users/edwardmillgate/Desktop/cognition_18052021.dta"

*Sanity check using clozapine at baseline (Y/N) Table S.3.3
bysort strataclozeverbinary: su execfunctionz1
bysort strataclozeverbinary: su attenworkspeedz2
bysort strataclozeverbinary: su IQcogfuncz3
bysort strataclozeverbinary: su visualspatmemz4
bysort strataclozeverbinary: su verbintellz5
bysort strataclozeverbinary: su verbmemz6
bysort strataclozeverbinary: su visuaspatintellz7

********************************************************************************************************************************************************
*************Additional code for explanation of variable selection of MICE model (i.e. Figure S.1) 
********************************************************************************************************************************************************

*********************************************************
*********MICE MODEL Auxillary variable selection**********
*********************************************************

**********************************************
**Step 1: 
*Identify variables associated with missingness 
***********************************************

clear all
use "/Users/edwardmillgate/Desktop/cognition_18052021.dta"


gen exec1mis = 0
replace exec1mis = 1 if missing(execfunctionz1)

gen atten2mis = 0
replace atten2mis = 1 if missing(attenworkspeedz2)

gen IQ3mis = 0
replace IQ3mis = 1 if missing(IQcogfuncz3)

gen visual4mis = 0
replace visual4mis = 1 if missing(visualspatmemz4)

gen verbal5mis = 0
replace verbal5mis = 1 if missing(verbintellz5)

gen verbal6mis = 0
replace verbal6mis = 1 if missing(verbmemz6)

gen visual7mis = 0
replace visual7mis = 1 if missing(visuaspatintellz7)


mdesc rf_baseline rf_onset rf_dup rf_gender rf_histsz rf_histmh rf_bmi rf_relationshipcurr rf_relationshipltime rf_livingcurr rf_accommodation rf_employment rf_educationyears rf_educationqual rf_cannabis rf_tobacco rf_alcohol rf_pansspos rf_panssneg rf_panssgen rf_pansstotal rf_saps rf_sans rf_bprstotal rf_gaf rf_ethnicity02 rf_modeonset02


*Method 1: select all auxilarry variables which exceed r .04); too small 
pwcorr execfunctionz1 attenworkspeedz2 IQcogfuncz3 visualspatmemz4 verbintellz5 verbmemz6 visuaspatintellz7 rf_baseline rf_onset rf_dup rf_gender rf_histsz rf_histmh rf_bmi rf_relationshipcurr rf_relationshipltime rf_livingcurr rf_accommodation rf_employment rf_educationyears rf_educationqual rf_cannabis rf_tobacco rf_alcohol rf_pansspos rf_panssneg rf_panssgen rf_pansstotal rf_saps rf_sans rf_bprstotal rf_gaf rf_ethnicity02 rf_modeonset02, obs

*Method 2: select all auxillary variables which correlate with missingness of cognitive data; too small 
pwcorr exec1mis atten2mis IQ3mis visual4mis verbal5mis verbal6mis visual7mis rf_baseline rf_onset rf_dup rf_gender rf_histsz rf_histmh rf_bmi rf_relationshipcurr rf_relationshipltime rf_livingcurr rf_accommodation rf_employment rf_educationyears rf_educationqual rf_cannabis rf_tobacco rf_alcohol rf_pansspos rf_panssneg rf_panssgen rf_pansstotal rf_saps rf_sans rf_bprstotal rf_gaf rf_ethnicity02 rf_modeonset02, obs




*Method 3: look at differences between missing groups and select vairables which cause a significant difference (may have to do this vairable at a time; maybe make a diagram)


***For variables with mutliple levels of outcome; e.g. gender, qualifications, living?, modeofonset, ethnicity use this: tabulate rf_ethnicity02 visual7mis, chi2
*1
ttest rf_baseline, by(exec1mis)
ttest rf_onset, by(exec1mis)
ttest rf_dup, by(exec1mis)
tabulate rf_gender exec1mis, chi2 
ttest rf_histsz, by(exec1mis)
ttest rf_histmh, by(exec1mis)
ttest rf_bmi, by(exec1mis)
tabulate rf_relationshipcurr exec1mis, chi2
tabulate rf_relationshipltime exec1mis, chi2
tabulate rf_livingcurr exec1mis, chi2
tabulate rf_accommodation exec1mis, chi2
tabulate rf_employment exec1mis, chi2
ttest rf_educationyears, by(exec1mis)
tabulate rf_educationqual exec1mis, chi2
ttest lengthfollowup, by(exec1mis)
tabulate rf_cannabis exec1mis, chi2
tabulate rf_tobacco exec1mis, chi2 
tabulate rf_alcohol exec1mis, chi2
ttest rf_pansspos, by(exec1mis)
ttest rf_panssneg, by(exec1mis)
ttest rf_panssgen, by(exec1mis)
ttest rf_pansstotal, by(exec1mis)
ttest rf_saps, by(exec1mis)
ttest rf_sans, by(exec1mis)
ttest rf_bprstotal, by(exec1mis)
ttest rf_gaf, by(exec1mis)
tabulate rf_ethnicity02 exec1mis, chi2 
tabulate rf_modeonset02 exec1mis, chi2 

*2
ttest rf_baseline, by(atten2mis)
ttest rf_onset, by(atten2mis)
ttest rf_dup, by(atten2mis)
tabulate rf_gender atten2mis, chi2 
ttest rf_histsz, by(atten2mis)
ttest rf_histmh, by(atten2mis)
ttest rf_bmi, by(atten2mis)
tabulate rf_relationshipcurr atten2mis, chi2
tabulate rf_relationshipltime atten2mis, chi2
tabulate rf_livingcurr atten2mis, chi2
tabulate rf_accommodation atten2mis, chi2
tabulate rf_employment atten2mis, chi2
ttest rf_educationyears, by(atten2mis)
tabulate rf_educationqual atten2mis, chi2
ttest lengthfollowup, by(atten2mis)
tabulate rf_cannabis atten2mis, chi2
tabulate rf_tobacco atten2mis, chi2 
tabulate rf_alcohol atten2mis, chi2
ttest rf_pansspos, by(atten2mis)
ttest rf_panssneg, by(atten2mis)
ttest rf_panssgen, by(atten2mis)
ttest rf_pansstotal, by(atten2mis)
ttest rf_saps, by(atten2mis)
ttest rf_sans, by(atten2mis)
ttest rf_bprstotal, by(atten2mis)
ttest rf_gaf, by(atten2mis)
tabulate rf_ethnicity02 atten2mis, chi2 
tabulate rf_modeonset02 atten2mis, chi2 

*3
ttest rf_baseline, by(IQ3mis)
ttest rf_onset, by(IQ3mis)
ttest rf_dup, by(IQ3mis)
tabulate rf_gender IQ3mis, chi2 
ttest rf_histsz, by(IQ3mis)
ttest rf_histmh, by(IQ3mis)
ttest rf_bmi, by(IQ3mis)
tabulate rf_relationshipcurr IQ3mis, chi2
tabulate rf_relationshipltime IQ3mis, chi2
tabulate rf_livingcurr IQ3mis, chi2
tabulate rf_accommodation IQ3mis, chi2
tabulate rf_employment IQ3mis, chi2
ttest rf_educationyears, by(IQ3mis)
tabulate rf_educationqual IQ3mis, chi2
ttest lengthfollowup, by(IQ3mis)
tabulate rf_cannabis IQ3mis, chi2
tabulate rf_tobacco IQ3mis, chi2 
tabulate rf_alcohol IQ3mis, chi2
ttest rf_pansspos, by(IQ3mis)
ttest rf_panssneg, by(IQ3mis)
ttest rf_panssgen, by(IQ3mis)
ttest rf_pansstotal, by(IQ3mis)
ttest rf_saps, by(IQ3mis)
ttest rf_sans, by(IQ3mis)
ttest rf_bprstotal, by(IQ3mis)
ttest rf_gaf, by(IQ3mis)
tabulate rf_ethnicity02 IQ3mis, chi2 
tabulate rf_modeonset02 IQ3mis, chi2 

*4
ttest rf_baseline, by(visual4mis)
ttest rf_onset, by(visual4mis)
ttest rf_dup, by(visual4mis)
tabulate rf_gender visual4mis, chi2 
ttest rf_histsz, by(visual4mis)
ttest rf_histmh, by(visual4mis)
ttest rf_bmi, by(visual4mis)
tabulate rf_relationshipcurr visual4mis, chi2
tabulate rf_relationshipltime visual4mis, chi2
tabulate rf_livingcurr visual4mis, chi2
tabulate rf_accommodation visual4mis, chi2
tabulate rf_employment visual4mis, chi2
ttest rf_educationyears, by(visual4mis)
tabulate rf_educationqual visual4mis, chi2
ttest lengthfollowup, by(visual4mis)
tabulate rf_cannabis visual4mis, chi2
tabulate rf_tobacco visual4mis, chi2 
tabulate rf_alcohol visual4mis, chi2
ttest rf_pansspos, by(visual4mis)
ttest rf_panssneg, by(visual4mis)
ttest rf_panssgen, by(visual4mis)
ttest rf_pansstotal, by(visual4mis)
ttest rf_saps, by(visual4mis)
ttest rf_sans, by(visual4mis)
ttest rf_bprstotal, by(visual4mis)
ttest rf_gaf, by(visual4mis)
tabulate rf_ethnicity02 visual4mis, chi2 
tabulate rf_modeonset02 visual4mis, chi2 

*5
ttest rf_baseline, by(verbal5mis)
ttest rf_onset, by(verbal5mis)
ttest rf_dup, by(verbal5mis)
tabulate rf_gender verbal5mis, chi2 
ttest rf_histsz, by(verbal5mis)
ttest rf_histmh, by(verbal5mis)
ttest rf_bmi, by(verbal5mis)
tabulate rf_relationshipcurr verbal5mis, chi2
tabulate rf_relationshipltime verbal5mis, chi2
tabulate rf_livingcurr verbal5mis, chi2
tabulate rf_accommodation verbal5mis, chi2
tabulate rf_employment verbal5mis, chi2
ttest rf_educationyears, by(verbal5mis)
tabulate rf_educationqual verbal5mis, chi2
ttest lengthfollowup, by(verbal5mis)
tabulate rf_cannabis verbal5mis, chi2
tabulate rf_tobacco verbal5mis, chi2 
tabulate rf_alcohol verbal5mis, chi2
ttest rf_pansspos, by(verbal5mis)
ttest rf_panssneg, by(verbal5mis)
ttest rf_panssgen, by(verbal5mis)
ttest rf_pansstotal, by(verbal5mis)
ttest rf_saps, by(verbal5mis)
ttest rf_sans, by(verbal5mis)
ttest rf_bprstotal, by(verbal5mis)
ttest rf_gaf, by(verbal5mis)
tabulate rf_ethnicity02 verbal5mis, chi2 
tabulate rf_modeonset02 verbal5mis, chi2 

*6
ttest rf_baseline, by(verbal6mis)
ttest rf_onset, by(verbal6mis)
ttest rf_dup, by(verbal6mis)
tabulate rf_gender verbal6mis, chi2 
ttest rf_histsz, by(verbal6mis)
ttest rf_histmh, by(verbal6mis)
ttest rf_bmi, by(verbal6mis)
tabulate rf_relationshipcurr verbal6mis, chi2
tabulate rf_relationshipltime verbal6mis, chi2
tabulate rf_livingcurr verbal6mis, chi2
tabulate rf_accommodation verbal6mis, chi2
tabulate rf_employment verbal6mis, chi2
ttest rf_educationyears, by(verbal6mis)
tabulate rf_educationqual verbal6mis, chi2
ttest lengthfollowup, by(verbal6mis)
tabulate rf_cannabis verbal6mis, chi2
tabulate rf_tobacco verbal6mis, chi2 
tabulate rf_alcohol verbal6mis, chi2
ttest rf_pansspos, by(verbal6mis)
ttest rf_panssneg, by(verbal6mis)
ttest rf_panssgen, by(verbal6mis)
ttest rf_pansstotal, by(verbal6mis)
ttest rf_saps, by(verbal6mis)
ttest rf_sans, by(verbal6mis)
ttest rf_bprstotal, by(verbal6mis)
ttest rf_gaf, by(verbal6mis)
tabulate rf_ethnicity02 verbal6mis, chi2 
tabulate rf_modeonset02 verbal6mis, chi2 

*7
ttest rf_baseline, by(visual7mis)
ttest rf_onset, by(visual7mis)
ttest rf_dup, by(visual7mis)
tabulate rf_gender visual7mis, chi2 
ttest rf_histsz, by(visual7mis)
ttest rf_histmh, by(visual7mis)
ttest rf_bmi, by(visual7mis)
tabulate rf_relationshipcurr visual7mis, chi2
tabulate rf_relationshipltime visual7mis, chi2
tabulate rf_livingcurr visual7mis, chi2
tabulate rf_accommodation visual7mis, chi2
tabulate rf_employment visual7mis, chi2
ttest rf_educationyears, by(visual7mis)
tabulate rf_educationqual visual7mis, chi2
ttest lengthfollowup, by(visual7mis)
tabulate rf_cannabis visual7mis, chi2
tabulate rf_tobacco visual7mis, chi2 
tabulate rf_alcohol visual7mis, chi2
ttest rf_pansspos, by(visual7mis)
ttest rf_panssneg, by(visual7mis)
ttest rf_panssgen, by(visual7mis)
ttest rf_pansstotal, by(visual7mis)
ttest rf_saps, by(visual7mis)
ttest rf_sans, by(visual7mis)
ttest rf_bprstotal, by(visual7mis)
ttest rf_gaf, by(visual7mis)
tabulate rf_ethnicity02 visual7mis, chi2 
tabulate rf_modeonset02 visual7mis, chi2 




