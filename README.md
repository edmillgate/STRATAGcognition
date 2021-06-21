# STRATAGcognition
Code relating to the management and analysis of cognitive variables in the STRATA-G dataset

The attached code was written for STATA15/SE and was produced by Mr Edward Millgate at the Department of Psychosis Studies, King's College london, United Kingdom. All code was accurate at the time of performing the analysis.

1. STRATAG_Cognition_analysis_190521.do:

This code is divided up as follows:

i. Restriction of overall dataset to participants with baseline cognitive data
ii. Generating and summaries of missing values
iii. Multiple imputation by chained equations (MICE) modelling of baseline cognitive variables and auxiliary varaibles (see also viii.), including model checks for number of iterations
iv. Main logistic regression analysis of cognitive variables predicting antipsychotic response using imputed variables from MICE
v. Supplementary analysis of main analysis restricting to participants with a schizophrenia diagnosis
vi. Supplemenrtary analysis of main analysis but predicting clozapine use (as an more restricted definition of antipsychotic resistance)
vii. Additional supplementary summaruy statistics
viii. Additional code justifying the selection of auxiliary variables for MICE modelling 
