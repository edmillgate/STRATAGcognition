********************************************************************************************************************************************************
********************************************************************************************************************************************************
********************************************************************************************************************************************************
*************************  STRATA-G: Cognitive data pre-processing (8th October 2020) Edward Millgate, IoPPN, King's College London ********************
********************************************************************************************************************************************************
********************************************************************************************************************************************************
********************************************************************************************************************************************************

clear all
use "/Users/edwardmillgate/Desktop/STRATA x Neuropsych/STRATA-G/STRATA-G Dataset_27022020_stratamasterdatabase_08102020.dta"

**************************************************************************
*Variables which need to be inversed so that there is a consistent direction of effect 
**************************************************************************

**i.e. reverse code scores which have higher scores denoting worse performance
*cantabidederrtotalBLstrata
*cantabidedlatavBLstrata
*cantabToLinthinktotBLstrata
*cantabToLsuthinktotBLstrata
*stroopcolourerrors
*stroopworderrors
*TRAILB_NR
*TRAILB_TS
*tmb
*stroopwordtimetaken
*haylingtotalerrors
*trialba
*TRAILA_NR
*TRAILA_TS
*tma
*cantabsserrBLstrata
*cantabssuseerrBLstrata
*cantabswmerrtotBLstrata



**************************************************************************
*i. Reverse scoring for better performance = smaller score
**************************************************************************

gen cantaberr1 = cantabidederrtotalBLstrata * -1
gen cantablatv = cantabidedlatavBLstrata * -1
gen cantabtolthin = cantabToLinthinktotBLstrata * -1
gen cantabsuthin = cantabToLsuthinktotBLstrata * -1
gen strooperrc1 = stroopcolourerrors * -1
gen strooperrw1 = stroopworderrors * -1
gen TRAILB1 = TRAILB_NR * -1
gen TRAILB2 = TRAILB_TS * -1
gen tmb2 = tmb_1 * -1
gen strooptime1 = stroopwordtimetaken * -1
gen halyingerr = haylingtotalerrors * -1
gen trailba1 = trialba * -1
gen TRIALA1 = TRAILA_NR * -1
gen TRIALA2 = TRAILA_TS * -1
gen tma2 = tma_1 * -1
gen cantabusser2 = cantabsserrBLstrata * -1
gen cantabssueer2 = cantabssuseerrBLstrata * -1
gen cantabwesst2 = cantabswmerrtotBLstrata * -1

drop cantabidederrtotalBLstrata
drop cantabidedlatavBLstrata
drop cantabToLinthinktotBLstrata
drop cantabToLsuthinktotBLstrata
drop stroopcolourerrors
drop stroopworderrors
drop TRAILB_NR
drop TRAILB_TS
drop tmb_1
drop stroopwordtimetaken
drop haylingtotalerrors
drop trialba
drop TRAILA_NR
drop TRAILA_TS
drop tma_1
drop cantabsserrBLstrata
drop cantabssuseerrBLstrata
drop cantabswmerrtotBLstrata

rename cantaberr1 cantabidederrtotalBLstrata
rename cantablatv cantabidedlatavBLstrata
rename cantabtolthin cantabToLinthinktotBLstrata
rename cantabsuthin cantabToLsuthinktotBLstrata
rename strooperrc1 stroopcolourerrors
rename strooperrw1 stroopworderrors
rename TRAILB1 TRAILB_NR
rename TRAILB2 TRAILB_TS
rename tmb2 tmb_1
rename strooptime1 stroopwordtimetaken
rename halyingerr haylingtotalerrors
rename trailba1 trialba
rename TRIALA1 TRAILA_NR
rename TRIALA2 TRAILA_TS
rename tma2 tma_1
rename cantabusser2 cantabsserrBLstrata
rename cantabssueer2 cantabssuseerrBLstrata
rename cantabwesst2 cantabswmerrtotBLstrata


**************************************************************************
**ii. Generating Z-scores for each cognitive domain (if * = not included)
*Standardised to whole sample means 
**************************************************************************


*1. Execuitve funcion
gen cantabidBLstrata_z2020 = (cantabidedtotalBLstrata - (74.3125))/(28.59927)
gen cantabiderrBLstrata_z2020 = (cantabidederrtotalBLstrata -(19.28808))/(13.86359)
gen cantabidlatBLstrata_z2020 = (cantabidedlatavBLstrata - (2254.707))/(1267.61)
gen cantabToLmin5BLstrata_z2020 = (cantabToLminmo5BLstrata - (1.59727))/(1.176944)
gen cantabToLavmBLstrata_z2020 = (cantabToLavmototBLstrata - (4.64913))/(.7152484)
gen cantabToLthiBLstrata_z2020 = (cantabToLinthinktotBLstrata - (5577.473))/(3846.923)
gen cantabToLsuthiBLstrata_z2020 = (cantabToLsuthinktotBLstrata - (3267.748))/(3535.166)
gen stroopcolourerrors_z2020 = (stroopcolourerrors - (5.046512))/(3.798204)
gen stroopworderrors_z2020 = (stroopworderrors - (.7111111))/(1.531817)
gen TRAILB_NR_z2020 = (TRAILB_NR - (-2.756272))/(18.64274)
gen TRAILB_TS_z2020 = (TRAILB_TS - (91.56717))/(77.7364)
gen tmb_z2020 = (tmb_1 - (102.3259))/(75.6717)
gen verbalfluencyletter_z2020 = (verbalfluencyletter - (36.82258))/(10.24399)
gen verbalfluencycategory_z2020 = (verbalfluencycategory - (45.79032))/(9.921226)
gen verbalfluencycombination_z2020 = (verbalfluencycombination - (41.90323))/(9.620606)
gen FAS_CAT_60TS_z2020 = (FAS_CAT_60TS - (6.842294))/(74.47188)
gen FAS_LET_60TS_z2020 = (FAS_LET_60TS - (-7))/(63.15882)
gen tlcorr_z2020 = (FAS_Letters - (21.92105))/(9.077001)
gen tccorr_z2020 = (FAS_Categories - (34.4))/(9.44732)
gen haylingtotalerrors_z2020 = (haylingtotalerrors - (4.862745))/(3.638789)

*gen haylingoverallscaledscore_z2020 = (haylingoverallscaledscore - (4.475))/(1.648426)

*2. Attention, Working Memory and Visual-Motor/Processing Speed
gen waisdigitspanrawBLstrata_z2020 = (waisdigitspanrawBLstrata - (14.325))/(3.628002)
gen waisarithrawBLstrata_z2020 = (waisarithrawBLstrata - (10.72927))/(3.955648)
gen waispicarrrawBLstrata_z2020 = (waispicarrrawBLstrata - (11.27586))/(4.165304)
gen waispiccomprawBLstrata_z2020 = (waispiccomprawBLstrata - (14.02381))/(3.203659)
gen waisdigsymrawBLstrata_z2020 = (waisdigsymrawBLstrata - (45.58667))/(13.64521)
gen waisiiiarithrawBLstrata_z2020 = (waisiiiarithrawBLstrata - (9.963415))/(4.045584)
gen waisiiidigsymrawBLstrata_z2020 = (waisiiidigsymrawBLstrata - (51.74074))/(18.00985)
gen waisiiiwmiBLstrata_z2020 = (waisiiiwmiBLstrata - (82.82209))/(21.58358)
gen waisiiipsiBLstrata_z2020 = (waisiiipsiBLstrata - (79.60494))/(13.52217)
gen WAISIII_DSR_z2020 = (WAISIII_DSR - (41.15054))/(56.29808)
gen stroopwordtimetaken_z2020 = (stroopwordtimetaken - (61.60792))/(16.79378)
gen WAISIIIDP_R_z2020 = (WAISIIIDP_R - (-17.44803))/(52.3864)
gen WAISIII_DS_F_z2020 = (WAISIII_DS_F - (-21.95341))/(49.40773)
gen WAIS_III_DS_BW_z2020 = (WAIS_III_DS_BW - (-23.92832))/(48.30071)
gen trialba_z2020 = (trialba - (51.44147))/(61.95072)
gen TRAILA_NR_z2020 = (TRAILA_NR - (-.5483871))/(8.392592)
gen TRAILA_TS_z2020 = (TRAILA_TS - (41.02667))/(25.55577)
gen tma_z2020 = (tma_1 - (46.66176))/(28.50243)

*gen sdig_z2020 = (waisrscaleddigit - (7.014706))/(2.630266)

*3. IQ/General Cognitive Functioning 
gen nartiqBLstrata_z2020 = (nartiqBLstrata - (96.876))/(13.83921)
gen narterrBLstrata_z2020 = (narterrBLstrata - (29.43671))/(11.9385)
gen waisiqBLstrata_z2020 = ( waisiqBLstrata - (94.51475))/(55.18641)
gen waisfullscaleiqBLstrata_z2020 = (waisfullscaleiqBLstrata - (92.37008))/(12.9895)
gen wtarstandard_z2020 = (wtarstandard - (85.73333))/(21.14732)
gen wtariqBLstrata_z2020 = (wtariqBLstrata - (92.35976))/(12.99546)
gen waisiiiiqBLstrata_z2020 = (waisiiiiqBLstrata - (81.92793))/(15.50584)
gen waisiiiblyleriqBLstrata_z2020 = (waisiiiblyleriqBLstrata - (84.92025))/(17.35433)
gen baselinenart_z2020 = (baselinenart - (98.0916))/(11.71025)
gen nart_total_z2020 = (nart_total - (98.77273))/(12.85242)
gen wtarpredictedfullscaleiq_z2020 = (wtarpredictedfullscaleiq - (92.28485))/(12.99146)
gen WTAR_standard_score_z2020 =(WTAR_standard_score - (27.39427))/(93.00972)
gen WTAR_IQ_basic_z2020 = (WTAR_IQ_basic - (29.61649))/(93.83427)


*4. Visual-Spatial Memory and Leaning
gen cantabssBLstrata_z2020 = (cantabssBLstrata - (5.375817))/(1.423205)
gen cantabsserrBLstrata_z2020 = (cantabsserrBLstrata - (8.042482))/(4.769592)
gen cantabssuseerrBLstrata_z2020 = (cantabssuseerrBLstrata - (3.663399))/(2.449711)
gen cantabswmstratBLstrata_z2020 = (cantabswmstratBLstrata - (34.84965))/(5.041072)
gen cantabswmerrtotBLstrata_z2020 = (cantabswmerrtotBLstrata - (2.175258))/(3.818314)
gen cantabrmpattscoreBLstrata_z2020 = (cantabrmpattscoreBLstrata - (19.46053))/(3.163074)
gen vmto_z2020 = (vmto_1 - (9.44186))/(3.201335)
gen WAIS_III_Spat_Raw_z2020 = (WAIS_III_Spat_Raw - (-24.91039))/(55.13505)
gen WAIS_III_SP_F_z2020 = (WAIS_III_SP_F - (-30.10036))/(51.61671)
gen WAIS_III_SPB_z2020 = (WAIS_III_SPB  - (-30.68459))/(51.18798)

*5. Verbal Intelligence and Processing
gen nartverbaliqBLstrata_z2020 = (nartverbaliqBLstrata - (87.93038))/(11.58967)
gen nartviqBLstrata_z2020 = (nartviqBLstrata - (93.26582))/(15.24134)
gen waisvocabBLstrata_z2020 = (waisvocabBLstrata - (9.237245))/(2.720076)
gen waisvocabrawBLstrata_z2020 = (waisvocabrawBLstrata - (40.75))/(14.24621)
gen waissimrawBLstrata_z2020 = (waissimrawBLstrata - (18.27692))/(4.322315)
gen waisverbaliqBLstrata_z2020 = (waisverbaliqBLstrata - (95.65414))/(12.24191)
gen wtarviqBLstrata_z2020 = (wtarviqBLstrata - (92.51829))/(12.88432)
gen waisiiivciBLstrata_z2020 = (waisiiivciBLstrata - (95.93252))/(17.20577)
gen waisiiiinforawBLstrata_z2020 = (waisiiiinforawBLstrata - (13.62805))/(5.697008)
gen WAISIII_IR_z2020 = (WAISIII_IR - (6.168459))/(34.26154)
gen waisinforawBLstrata_z2020 = (waisinforawBLstrata - (16.07143))/(5.935205)
gen waisiiiviqBLstrata_z2020 = (waisiiiviqBLstrata - (85.54867))/(18.07573)
gen wtarpredictedviq_z2020 = (wtarpredictedviq - (92.44848))/(12.87624)

*gen scom_z2020 = (waisrscaledcomprehension - (8.152164))/(2.909592)
*gen svoc_z2020 = (waisrscaledvocab - (7.942446))/(2.625874)

*6. Verbal Memory and Learning
gen ravltflasepositives_z2020 = (ravltflasepositives - (1.465517))/(2.303434)
gen ravltcorrectrecognition_z2020 = (ravltcorrectrecognition - (11.89831))/(2.461391)
gen wechslermemlogmemory_z2020 = (wechslermemoryscalelogicalmemory - (16.56716))/(6.555645)
gen av15_z2020 = (ReyAuditory1to5 - (43.30303))/(12.02157)
gen ava7_z2020 = (ReyAuditory7 - (8.674419))/(3.446381)
gen lnst_z2020 = (lnst_1 - (12.85714))/(4.156307)

*7. Visual-Spatial Intelligence and Processing 
gen nartperformiqBLstrata_z2020 = (nartperformiqBLstrata - (93.72038))/(17.94434)
gen nartpiqBLstrata_z2020 = (nartpiqBLstrata - (95.25949))/(13.18327)
gen waisblockrawBLstrata_z2020 = (waisblockrawBLstrata - (29.82))/(12.5931)
gen waisperformiqBLstrata_z2020 = (waisperformiqBLstrata - (90.09375))/(16.1462)
gen wtarpiqBLstrata_z2020 = (wtarpiqBLstrata - (94.93902))/(11.39352)
gen waisiiiblockrawBLstrata_z2020 = (waisiiiblockrawBLstrata - (31.81595))/(11.39352)
gen waisiiipiqBLstrata_z2020 = (waisiiipiqBLstrata - (80.53571))/(15.35932)
gen waisiiipoiBLstrata_z2020 = (waisiiipoiBLstrata - (90.04908))/(22.05683)
gen WAISIII_BR_z2020 = (WAISIII_BR - (35.93548))/(24.09266)
gen WAISIII_MRR_z2020 = (WAISIII_MRR - (12.58993))/(21.20991)
gen rvb_z2020 = (RavensBtotal - (9.240876))/(2.402589)
gen rvab_z2020 = (RavensABtotal - (10.54745))/(1.653743)
gen rva_z2020 = (RavensAtotal - (10.48905))/(1.404288)
gen rvto_z2020 = (rvto_1 - (30.28467))/(4.705986)

*gen sblo_z2020 = (waisrscaledblock - (8.971223))/(3.562979)


**************************************************************************
*iii. Generating cognitive domains
**************************************************************************


*1. Executive function
egen execfunctionz1 = rowmean(cantabidBLstrata_z2020 cantabiderrBLstrata_z2020 cantabidlatBLstrata_z2020  cantabToLmin5BLstrata_z2020 cantabToLavmBLstrata_z2020 cantabToLthiBLstrata_z2020 cantabToLsuthiBLstrata_z2020 stroopcolourerrors_z2020 stroopworderrors_z2020 TRAILB_NR_z2020 TRAILB_TS_z2020 tmb_z2020 haylingtotalerrors_z2020  verbalfluencyletter_z2020 verbalfluencycategory_z2020 FAS_CAT_60TS_z2020 FAS_LET_60TS_z2020 tlcorr_z2020 tccorr_z2020)
*2. Attention, Working Memory and Visual-Motor/Processing Speed
egen attenworkspeedz2 = rowmean(waisdigitspanrawBLstrata_z2020 waisarithrawBLstrata_z2020 waisdigsymrawBLstrata_z2020 waisiiiarithrawBLstrata_z2020 waisiiidigsymrawBLstrata_z2020 waisiiiwmiBLstrata_z2020 waisiiipsiBLstrata_z2020 WAISIII_DSR_z2020 stroopwordtimetaken_z2020  WAISIIIDP_R_z2020 WAISIII_DS_F_z2020 WAIS_III_DS_BW_z2020 trialba_z2020 TRAILA_NR_z2020 TRAILA_TS_z2020 tma_z2020 )
*3. IQ/General Cognitive Functioning 
egen IQcogfuncz3 = rowmean(nartiqBLstrata_z2020 narterrBLstrata_z2020 waisiqBLstrata_z2020 waisfullscaleiqBLstrata_z2020 wtarstandard_z2020 wtariqBLstrata_z2020 waisiiiiqBLstrata_z2020 waisiiiblyleriqBLstrata_z2020 baselinenart_z2020 nart_total_z2020 wtarpredictedfullscaleiq_z2020 WTAR_standard_score_z2020 WTAR_IQ_basic_z2020)
*4. Visual-Spatial Memory and Leaning
egen visualspatmemz4 = rowmean(cantabssBLstrata_z2020 cantabsserrBLstrata_z2020 cantabssuseerrBLstrata_z2020 cantabswmstratBLstrata_z2020 cantabswmerrtotBLstrata_z2020 cantabrmpattscoreBLstrata_z2020 vmto_z2020 WAIS_III_Spat_Raw_z2020 WAIS_III_SP_F_z2020 WAIS_III_SPB_z2020 )
*5. Verbal Intelligence and Processing
egen verbintellz5 = rowmean(nartverbaliqBLstrata_z2020 nartviqBLstrata_z2020 waisvocabBLstrata_z2020 waisiiivciBLstrata_z2020 waisinforawBLstrata_z2020 WAISIII_IR_z2020 waisvocabrawBLstrata_z2020 waissimrawBLstrata_z2020 waisverbaliqBLstrata_z2020 wtarviqBLstrata_z2020 waisiiiinforawBLstrata_z2020 waisiiiviqBLstrata_z2020  wtarpredictedviq_z2020)
*6. Verbal Memory and Learning
egen verbmemz6 = rowmean(ravltflasepositives_z2020 ravltcorrectrecognition_z2020 wechslermemlogmemory_z2020 av15_z2020 ava7_z2020 lnst_z2020)
*7. Visual-Spatial Intelligence and Processing 
egen visuaspatintellz7 = rowmean(nartperformiqBLstrata_z2020 nartpiqBLstrata_z2020 waisblockrawBLstrata_z2020 waisperformiqBLstrata_z2020 wtarpiqBLstrata_z2020 waisiiiblockrawBLstrata_z2020 waisiiipiqBLstrata_z2020 waisiiipoiBLstrata_z2020 WAISIII_BR_z2020 WAISIII_MRR_z2020 rvb_z2020 rvab_z2020 rva_z2020 rvto_z2020 waispicarrrawBLstrata_z2020 waispiccomprawBLstrata_z2020)
