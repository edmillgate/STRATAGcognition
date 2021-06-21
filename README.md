# STRATAG baseline cognitive analysis
Code relating to the management and analysis of cognitive variables in the STRATA-G dataset

The attached code was written for STATA15/SE and was produced by Mr Edward Millgate at the Department of Psychosis Studies, King's College London, United Kingdom. All code was accurate at the time of performing the analysis.

1. STRATAG_Cognition_analysis_190521.do:

This code file is divided up as follows:

i. Restriction of overall dataset from Smart et al., 2020 to participants with baseline cognitive data//
ii. Generating summaries of missing values//
iii. Multiple imputation by chained equations (MICE) modelling of baseline cognitive variables and auxiliary variables (see also viii.), including model checks for number of iterations through convergence and QQ-plots
iv. Main analysis: logistic (unadjusted and adjusted) regression of cognitive variables predicting antipsychotic response using imputed variables from MICE
v. Supplementary analysis of main analysis restricting to participants with a schizophrenia diagnosis only
vi. Supplementary analysis of main analysis but predicting clozapine use (as an more restricted definition of antipsychotic resistance)
vii. Additional supplementary summary statistics
viii. Additional code justifying the selection of auxiliary variables for MICE modelling 


References
Smart, S. (2020). Clinical and genetic predictors of treatment resistant psychosis (Doctoral dissertation, King's College London).
