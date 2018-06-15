#V3.24j
#C growth parameters are estimated
#C spawner-recruitment bias adjustment Not tuned For optimality
#_data_and_control_files: complex.dat // complex.ctl
#_SS-V3.24j-opt;_11/14/2012;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_10.1
1  #_N_Growth_Patterns
1 #_N_Morphs_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
#_Cond 0  #  N recruitment designs goes here if N_GP*nseas*area>1
#_Cond 0  #  placeholder for recruitment interaction request
#_Cond 1 1 1  # example recruitment design element for GP=1, seas=1, area=1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
1 #_Nblock_Patterns
2 #_blocks_per_pattern 
# begin and end years of blocks
1994 2006 2007 2016
#
0.5 #_fracfemale 
3 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
 #_Age_natmort_by gender x growthpattern
 0.47 0.37 0.3 0.25 0.21 0.18 0.16 0.15 0.14 0.13 0.12 0.12 0.11 0.11 0.11 0.11 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1
2 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_speciific_K; 4=not implemented
0.5 #_Growth_Age_for_L1
30 #_Growth_Age_for_L2 (999 to use as Linf)
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
3 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=read fec and wt from wtatage.ss
#_Age_Maturity by growth pattern
 0 0 0 0.25 0.5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
3 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
2 #_env/block/dev_adjust_method (1=standard; 2=logistic transform keeps in base parm bounds; 3=standard w/ no bound check)
#
#_growth_parms
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 10 45 32.9541 36 -1 10  -5 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 200 340 319 319 1 5  4 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1   prior
 0.01 0.4 0.22 0.15 -1 0.8   4 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 	-3	3	-0.12	0.58	0	0.8	4	0	0	0	0	0.5	0	0	#	Richards_coeff
 0.05 0.25 0.1 0.1 -1 0.8  3 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.02 0.25 0.06 0.1 -1 0.8  3 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
 -3 3 2.95e-005 2.95e-005 -1 0.8 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem
 -3 4 2.899 2.899 -1 0.8 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem
 3 5 4 4 -1 0.8 -3 0 0 0 0 0 0 0 # Mat50%_Fem
 -7 -3 -5 -5 -1 0.8 -3 0 0 0 0 0 0 0 # Mat_slope_Fem
 -3 3 1 1 -1 0.8 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem
 -3 3 0 0 -1 0.8 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_Seas_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # CohortGrowDev
#
#_Cond 0  #custom_MG-env_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-environ parameters
#
#_Cond 0  #custom_MG-block_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-block parameters
#_Cond No MG parm trends 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Cond -4 #_MGparm_Dev_Phase
#
#_Spawner-Recruitment
6 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm
#_LO HI INIT PRIOR PR_type SD PHASE
 6 15 7.98019 10.3 -1 10 1 # SR_LN(R0)
 0.2 1 0.9 0.9 -1 0.05 -3 # SR_BH_flat_steep
 0 2 0.6 0.6 -1 0.2 -5 # SR_sigmaR
 -5 5 0 0 -1 1 -3 # SR_envlink
 -5 5 0 0 -1 1 -2 # SR_R1_offset
 0 0 0 0 -1 0 -99 # SR_autocorr
0 #_SR_env_link
0 #_SR_env_target_0=none;1=devs;_2=R0;_3=steepness
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1950 # first year of main recr_devs; early devs can preceed this era
2014 # last year of main recr_devs; forecast devs start in following year
6 #_recdev phase 
1 # (0/1) to read 13 advanced options
 -15 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 6 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1931 #_last_early_yr_nobias_adj_in_MPD
 1962 #_first_yr_fullbias_adj_in_MPD
 1998 #_last_yr_fullbias_adj_in_MPD
 2083 #_first_recent_yr_nobias_adj_in_MPD
 0.93 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 7 #max rec_dev
 54 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# Specified recr devs to read
#_Yr Input_value # Final_value
 1961 0.367027 # -0.261324
 1962 0.0645511 # -0.314537
 1963 0.48233 # -0.863137
 1964 -0.438039 # -0.197228
 1965 -0.784369 # -0.397854
 1966 -0.744618 # -0.173652
 1967 -0.687635 # 0.0624002
 1968 -0.0271688 # -0.061275
 1969 0.62289 # 0.0843448
 1970 -0.166794 # -0.165662
 1971 0.00997055 # -0.405195
 1972 1.11948 # -0.898918
 1973 0.620815 # -0.0834374
 1974 -0.400979 # -0.427511
 1975 -0.435079 # -0.171772
 1976 -0.905073 # -0.0331124
 1977 -0.920341 # -0.275491
 1978 -0.602674 # -0.259671
 1979 -0.268141 # -0.490653
 1980 -0.919227 # -0.271527
 1981 0.394313 # -0.302555
 1982 0.35708 # -0.519126
 1983 -0.3714 # 0.389415
 1984 0.249326 # -0.262422
 1985 0.189884 # 0.344267
 1986 0.113172 # 0.483925
 1987 0.31583 # 0.446747
 1988 -0.147574 # 0.399868
 1989 1.38716 # 0.406775
 1990 -0.742459 # 0.296858
 1991 0.436776 # 1.61344
 1992 0.290081 # 0.619711
 1993 -0.719029 # 1.19951
 1994 1.56383 # 1.62067
 1995 -0.1184 # 1.35379
 1996 0.00826561 # -0.278552
 1997 0.26489 # -0.39193
 1998 0.504973 # 0.927352
 1999 -0.0770637 # 0.467636
 2000 1.01504 # 0.305204
 2001 0.396427 # -0.158355
 2002 1.08302 # 1.48169
 2003 1.39628 # 1.66488
 2004 0.415991 # 0.174385
 2005 0.0594356 # 1.15389
 2006 0.00417469 # -0.0909053
 2007 -0.314161 # 0.689467
 2008 -0.00664716 # 1.14874
 2009 0.070972 # 0.399348
 2010 -0.309061 # -0.243743
 2011 -0.72319 # -0.691373
 2012 -1.3122 # -0.278674
 2013 -1.11118 # 0.0256401
 2014 -0.55149 # -0.0193757
#
# all recruitment deviations
#DisplayOnly 0.00172603 # Early_InitAge_15
#DisplayOnly 0.00858505 # Early_InitAge_14
#DisplayOnly 0.0199862 # Early_InitAge_13
#DisplayOnly 0.0375072 # Early_InitAge_12
#DisplayOnly 0.063021 # Early_InitAge_11
#DisplayOnly 0.0998965 # Early_InitAge_10
#DisplayOnly 0.157875 # Early_InitAge_9
#DisplayOnly 0.256438 # Early_InitAge_8
#DisplayOnly 0.415462 # Early_InitAge_7
#DisplayOnly 0.555121 # Early_InitAge_6
#DisplayOnly 0.43463 # Early_InitAge_5
#DisplayOnly 0.278118 # Early_InitAge_4
#DisplayOnly 0.204216 # Early_InitAge_3
#DisplayOnly -0.206412 # Early_InitAge_2
#DisplayOnly -1.0933 # Early_InitAge_1
#DisplayOnly -1.37648 # Main_RecrDev_1950
#DisplayOnly -1.1664 # Main_RecrDev_1951
#DisplayOnly -0.995871 # Main_RecrDev_1952
#DisplayOnly -1.00287 # Main_RecrDev_1953
#DisplayOnly -0.135267 # Main_RecrDev_1954
#DisplayOnly -0.878879 # Main_RecrDev_1955
#DisplayOnly -0.795625 # Main_RecrDev_1956
#DisplayOnly 0.0451022 # Main_RecrDev_1957
#DisplayOnly -0.358654 # Main_RecrDev_1958
#DisplayOnly -0.956664 # Main_RecrDev_1959
#DisplayOnly -1.14939 # Main_RecrDev_1960
#DisplayOnly -0.261324 # Main_RecrDev_1961
#DisplayOnly -0.314537 # Main_RecrDev_1962
#DisplayOnly -0.863137 # Main_RecrDev_1963
#DisplayOnly -0.197228 # Main_RecrDev_1964
#DisplayOnly -0.397854 # Main_RecrDev_1965
#DisplayOnly -0.173652 # Main_RecrDev_1966
#DisplayOnly 0.0624002 # Main_RecrDev_1967
#DisplayOnly -0.061275 # Main_RecrDev_1968
#DisplayOnly 0.0843448 # Main_RecrDev_1969
#DisplayOnly -0.165662 # Main_RecrDev_1970
#DisplayOnly -0.405195 # Main_RecrDev_1971
#DisplayOnly -0.898918 # Main_RecrDev_1972
#DisplayOnly -0.0834374 # Main_RecrDev_1973
#DisplayOnly -0.427511 # Main_RecrDev_1974
#DisplayOnly -0.171772 # Main_RecrDev_1975
#DisplayOnly -0.0331124 # Main_RecrDev_1976
#DisplayOnly -0.275491 # Main_RecrDev_1977
#DisplayOnly -0.259671 # Main_RecrDev_1978
#DisplayOnly -0.490653 # Main_RecrDev_1979
#DisplayOnly -0.271527 # Main_RecrDev_1980
#DisplayOnly -0.302555 # Main_RecrDev_1981
#DisplayOnly -0.519126 # Main_RecrDev_1982
#DisplayOnly 0.389415 # Main_RecrDev_1983
#DisplayOnly -0.262422 # Main_RecrDev_1984
#DisplayOnly 0.344267 # Main_RecrDev_1985
#DisplayOnly 0.483925 # Main_RecrDev_1986
#DisplayOnly 0.446747 # Main_RecrDev_1987
#DisplayOnly 0.399868 # Main_RecrDev_1988
#DisplayOnly 0.406775 # Main_RecrDev_1989
#DisplayOnly 0.296858 # Main_RecrDev_1990
#DisplayOnly 1.61344 # Main_RecrDev_1991
#DisplayOnly 0.619711 # Main_RecrDev_1992
#DisplayOnly 1.19951 # Main_RecrDev_1993
#DisplayOnly 1.62067 # Main_RecrDev_1994
#DisplayOnly 1.35379 # Main_RecrDev_1995
#DisplayOnly -0.278552 # Main_RecrDev_1996
#DisplayOnly -0.39193 # Main_RecrDev_1997
#DisplayOnly 0.927352 # Main_RecrDev_1998
#DisplayOnly 0.467636 # Main_RecrDev_1999
#DisplayOnly 0.305204 # Main_RecrDev_2000
#DisplayOnly -0.158355 # Main_RecrDev_2001
#DisplayOnly 1.48169 # Main_RecrDev_2002
#DisplayOnly 1.66488 # Main_RecrDev_2003
#DisplayOnly 0.174385 # Main_RecrDev_2004
#DisplayOnly 1.15389 # Main_RecrDev_2005
#DisplayOnly -0.0909053 # Main_RecrDev_2006
#DisplayOnly 0.689467 # Main_RecrDev_2007
#DisplayOnly 1.14874 # Main_RecrDev_2008
#DisplayOnly 0.399348 # Main_RecrDev_2009
#DisplayOnly -0.243743 # Main_RecrDev_2010
#DisplayOnly -0.691373 # Main_RecrDev_2011
#DisplayOnly -0.278674 # Main_RecrDev_2012
#DisplayOnly 0.0256401 # Main_RecrDev_2013
#DisplayOnly -0.0193757 # Main_RecrDev_2014
#
#Fishing Mortality info 
0.3 # F ballpark for tuning early phases
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
2.9 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
4  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms
#####9.3.15: initial F in equilibrium#####
#_LO HI INIT PRIOR PR_type SD PHASE
0 1 0 0 -1 99  -1             # BB52_06   1
0 1 0 0 -1 99  -2                  # BB06_15   2
0 1 0 0 -1 99  -1                  # LL1   3
0 1 0 0 -1 99  -1                  # LL2   4
0 1 0 0 -1 99  -1                  # LL3   5
0 1 0 0 -1 99  -1                  # LL4   6
0 1 0 0 -1 99  -1                  # PS_NOR   7
0 1 0 0 -1 99  -2                  # PS_CRO   8
0 1 0 0 -1 99  -1                  # PS_FR   9
0 1 0.01 0.01 -1 99  -1     # PSOTHER   10  fix due to bound
0 1 0 0 -1 99  -1                  # PSINFL   11
0 1 0.015 0.015 -1 99  -1             # TRP1   12
0 1 0 0 -1 99  -2                  # TRP2   13
0 1 0.03 0.01 -1 99  -1      # TRPOTHER   14 fix due to bound
0 1 0.005 0.005 -1 99  -1       # OTR   15  fix due to bound
#
#
#_Q_setup
 # Q_type options:  <0=mirror, 0=float_nobiasadj, 1=float_biasadj, 2=parm_nobiasadj, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
#_for_env-var:_enter_index_of_the_env-var_to_be_linked
#_Den-dep  env-var  extra_se  Q_type
 0 0 0 0 # 1 BB52_06
 0 0 0 0 # 2 BB06_15
 0 0 0 0 # 3 LL1
 0 0 0 0 # 4 LL2
 0 0 0 0 # 5 LL3
 0 0 0 0 # 6 LL4
 0 0 0 0 # 7 PS_NOR
 0 0 0 0 # 8 PS_CRO
 0 0 0 0 # 9 PS_FR
 0 0 0 0 # 10 PSOTHER
 0 0 0 0 # 11 PSINFL
 0 0 0 0 # 12 TRP1
 0 0 0 0 # 13 TRP2
 0 0 0 0 # 14 TRPOTHER
 0 0 0 0 # 15 OTR
 0 0 0 0 # 16 MOR1
 0 0 0 0 # 17 MOR2
 0 0 0 0 # 18 SpBB1
 0 0 0 0 # 19 SPBB2
 0 0 0 0 # 20 JPLL_EM
 0 0 0 0 # 21 NorPS
 0 0 0 0 # 22 JPLL_NEA
 0 0 0 0 # 23 JPLL_NEA2
 0 0 0 0 # 24 LS
 0 0 0 0 # 25 AS
 0 0 0 0 # 26 AS2
#
#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_Q_parms(if_any);Qunits_are_ln(q)
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
 24 0 0 0 # 1 BB52_06
 24 0 0 0 # 2 BB06_15
 24 0 0 0 # 3 LL1
 24 0 0 0 # 4 LL2
 24 0 0 0 # 5 LL3
 15 0 0 3 # 6 LL4
 24 0 0 0 # 7 PS_NOR
 24 0 0 0 # 8 PS_CRO
 27 0 0 5 # 9 PS_FR
 24 0 0 0 # 10 PSOTHER
 15 0 0 9 # 11 PSINFL
 24 0 0 0 # 12 TRP1
 1 0 0 0 # 13 TRP2
 24 0 0 0 # 14 TRPOTHER
 15 0 0 14 # 15 OTR
 15 0 0 12 # 16 MOR1
 15 0 0 13 # 17 MOR2
 15 0 0 1 # 18 SpBB1
 15 0 0 2 # 19 SPBB2
 15 0 0 3 # 20 JPLL_EM
 15 0 0 7 # 21 NorPS
 15 0 0 4 # 22 JPLL_NEA
 15 0 0 5 # 23 JPLL_NEA2
 30 0 0 0 # 24 LS
 30 0 0 0 # 25 AS1
 30 0 0 0 # 26 AS2
#
#_age_selex_types
#_Pattern ___ Male Special
 10 0 0 0 # 1 BB52_06
 10 0 0 0 # 2 BB06_15
 10 0 0 0 # 3 LL1
 10 0 0 0 # 4 LL2
 10 0 0 0 # 5 LL3
 10 0 0 0 # 6 LL4
 10 0 0 0 # 7 PS_NOR
 10 0 0 0 # 8 PS_CRO
 10 0 0 0 # 9 PS_FR
 10 0 0 0 # 10 PSOTHER
 10 0 0 0 # 11 PSINFL
 10 0 0 0 # 12 TRP1
 10 0 0 0 # 13 TRP2
 10 0 0 0 # 14 TRPOTHER
 10 0 0 0 # 15 OTR
 10 0 0 0 # 16 MOR1
 10 0 0 0 # 17 MOR2
 10 0 0 0 # 18 SpBB1
 10 0 0 0 # 19 SPBB2
 10 0 0 0 # 20 JPLL_EM
 10 0 0 0 # 21 JPLL_EM2
 10 0 0 0 # 22 NorPS
 10 0 0 0 # 23 JPLL_NEA
 10 0 0 0 # 24 LS
 11 0 0 0 # 25 AS
 11 0 0 0 # 26 AS2
# sel
 #_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 40 250 77.6762 77.6762 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_1P_1_BB52_06
 -10 3 -2.06394 -2.06394 1 5 2 0 0 0 0 0 0 0 # SizeSel_1P_2_BB52_06
 -5 9 4.46255 4.81298 1 5 -2 0 0 0 0 0 0 0 # SizeSel_1P_3_BB52_06     prior
 -5 9 0.179265 0.179265 1 5 2 0 0 0 0 0 0 0 # SizeSel_1P_4_BB52_06
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_1P_5_BB52_06   fix smooth increase
 -20 10 -999 2 -1 100 -2 0 0 0 0 0 0 0 # SizeSel_1P_6_BB52_06   fix smooth decline

 40 250 97 97  1 5 2 0 0 0 0 0 0 0 # SizeSel_2P_1_BB06_15   priors
 -10 3 -8 -8 1 5 2 0 0 0 0 0 0 0 # SizeSel_2P_2_BB06_15     priors
 -5 9 5 5 1 5 2 0 0 0 0 0 0 0 # SizeSel_2P_3_BB06_15        priors
 -5 9 6.2 6.2 1 5 2 0 0 0 0 0 0 0 # SizeSel_2P_4_BB06_15    priors
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_2P_5_BB06_15     fix smooth increase
 -20 10 -999 2 -1 100 -2 0 0 0 0 0 0 0 # SizeSel_2P_6_BB06_15     fix smooth decline
 #####  we could just make this one asymptotic


 40 330 210.236 120 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_4P_1_LL1  inc bound
 -10 3 -5.06107 -1.16787 -1 1000 -2 0 0 0 0 0 0 0 # SizeSel_4P_2_LL1   top doesn't mater
 -5 12 7.34679 4.81298 -1 1000 3 0 0 0 0 0 0 0 # SizeSel_4P_3_LL1   asc width
 -5 9 5.05524 6.75951 -1 1000 -3 0 0 0 0 0 0 0 # SizeSel_4P_4_LL1  desc width, fix  doesn't matter
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_4P_5_LL1
 -20 10 10 2 -1 100 -3 0 0 0 0 0 0 0 # SizeSel_4P_6_LL1  fix at asymptotic
 #####
 40 250 210.236 120 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_4P_1_LL2
 -10 3 -5.06107 -1.16787 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_4P_2_LL2
 -5 9 5 5 -1 1000 -3 0 0 0 0 0 0 0 # SizeSel_4P_3_LL2    fix at 5 due to high corr with parm 1
 -5 9 5.05524 6.75951 -1 1000 3 0 0 0 0 0 0 0 # SizeSel_4P_4_LL2
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_4P_5_LL2
 -20 10 -1.06752 2 -1 100 3 0 0 0 0 0 0 0 # SizeSel_4P_6_LL2

40 250 210.236 120 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_4P_1_LL3
 -10 3 -0.669697 -1.16787 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_5P_2_LL3
 -5 9 5 5 -1 1000 -3 0 0 0 0 0 0 0 # SizeSel_5P_3_LL3   fix at 5 due to high corr with parm 1
 -5 9 2.18393 6.75951 -1 1000 3 0 0 0 0 0 0 0 # SizeSel_5P_4_LL3
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_5P_5_LL3
 -20 10 5.64177 2 -1 100 3 0 0 0 0 0 0 0 # SizeSel_5P_6_LL3
 #LL 4 mirrors LL1
 #40 250 249.952 120 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_5P_1_LL3
 #-10 3 -0.669697 -1.16787 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_5P_2_LL3
 #-5 9 8.99981 4.81298 -1 1000 3 0 0 0 0 0 0 0 # SizeSel_5P_3_LL3
 #-5 9 2.18393 6.75951 -1 1000 3 0 0 0 0 0 0 0 # SizeSel_5P_4_LL3
 #-999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_5P_5_LL3
 #-20 10 5.64177 2 -1 100 3 0 0 0 0 0 0 0 # SizeSel_5P_6_LL3

 40 250 152.693 156 1  5 2 0 3 1955 1984 0.2 0 0 # SizeSel_6P_1_PS_NOR    prior
 -10 3 -.55  -.55 1  5 2 0 0 0 0 0 0 0 # SizeSel_6P_2_PS_NOR   prior
 -5 9 -5 -5 -1  5 -3 0 0 0 0 0 0 0 # SizeSel_6P_3_PS_NOR   prior
 -5 9 5 5  1  5 3 0 0 0 0 0 0 0 # SizeSel_6P_4_PS_NOR     prior
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_6P_5_PS_NOR
 -20 10 -3.1 -3.1 1 5 3 0 0 0 0 0 0 0 # SizeSel_6P_6_PS_NOR prior

 40 250 76 76 1 0.5 2 0 0 0 0 0 0 0 # SizeSel_7P_1_PS_CRO
 -10 3 -1.16 -1.16 1 5 2 0 0 0 0 0 0 0 # SizeSel_7P_2_PS_CRO prior  sym  beta u
 -5 9 0.56 0.56 1 5 3 0 0 0 0 0 0 0 # SizeSel_7P_3_PS_CRO
 -5 9 7.3  7.3   1 5 3 0 0 0 0 0 0 0 # SizeSel_7P_4_PS_CRO   prior
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_7P_5_PS_CRO
 -20 10 -999 2 -1 100 -3 0 0 0 0 0 0 0 # SizeSel_7P_6_PS_CRO    fix to smooth decline to 0

 0 70 0 0 -1 0 -99 0 0 0 0 0 0 0 # SizeSpline_Code_PS_FR_8
 -0.001 1 0 0 -1 0 -3 0 0 0 0 0 0 0 # SizeSpline_GradLo_PS_FR_8
 -1 0.001 0 0 -1 0 -3 0 0 0 0 0 0 0 # SizeSpline_GradHi_PS_FR_8
 1 300  10 0 -1 0 -99 0 0 0 0 0 0 0 # SizeSpline_Knot_1_PS_FR_8
 1 300 100 0 -1 0 -99 0 0 0 0 0 0 0 # SizeSpline_Knot_2_PS_FR_8
 1 300 150 0 -1 0 -99 0 0 0 0 0 0 0 # SizeSpline_Knot_3_PS_FR_8
 1 350 200 0 -1 0 -99 0 0 0 0 0 0 0 # SizeSpline_Knot_4_PS_FR_8
 1 350 250 0 -1 0 -99 0 0 0 0 0 0 0 # SizeSpline_Knot_5_PS_FR_8
 -9 7  -.5 0 -1 0.001 2 0 0 0 0 0 1 2 # SizeSpline_Val_1_PS_FR_8
 -9 7  .5  0 -1 0.001 2 0 0 0 0 0 1 2 # SizeSpline_Val_2_PS_FR_8
 -9 7  0   0 -1 0.001 -2 0 0 0 0 0 1 2 # SizeSpline_Val_3_PS_FR_8
 -9 7  .5  0 -1 0.001 2 0 0 0 0 0 1 2 # SizeSpline_Val_4_PS_FR_8
 -9 7  -.5 0 -1 0.001 2 0 0 0 0 0 1 2 # SizeSpline_Val_5_PS_FR_8

  40 270 223.508 120 1 5 2 0 0 0 0 0 0 0 # SizeSel_9P_1_PSOTHER  put prior on
 -10 3 -1 -1  -1 1000 -2 0 0 0 0 0 0 0 # SizeSel_9P_2_PSOTHER top width fix at -1
 -5 12 9 9 -1 1000  2 0 0 0 0 0 0 0 # SizeSel_9P_3_PSOTHER             asc width
 -5 9 6.27019 6.75951 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_9P_4_PSOTHER  desc width
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_9P_5_PSOTHER
 -20 10 -3.82955 2 -1 100 2 0 0 0 0 0 0 0 # SizeSel_9P_6_PSOTHER

 #10 300 199.013 150 0 1000 3 0 0 0 0 0 0 0 # SizeSel_11P_1_TRP1
 #10 200 40.6457 90 0 1000 2 0 0 0 0 0 0 0 # SizeSel_11P_2_TRP1   inc bound

  40 270 223.508 120 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_9P_1_TRP1inc upper bound
 -10 3 -1 -1  -1 1000 -2 0 0 0 0 0 0 0 # SizeSel_9P_2_TRP1 top width fix at -1
 -5 12 9 9 -1 1000  2 0 0 0 0 0 0 0 # SizeSel_9P_3_TRP1             asc width
 -5 9 6.27019 6.75951 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_9P_4_TRP1 desc width
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_9P_5_TRP1
 -20 10 -3.82955 2 -1 100 2 0 0 0 0 0 0 0 # SizeSel_9P_6_TRP1

  10 300 203.928 150 0 1000 3 0 0 0 0 0 0 0 # SizeSel_12P_1_TRP2
  10 150 53.2353 90 0 1000 2 0 0 0 0 0 0 0 # SizeSel_12P_2_TRP2

# 10 300 143.819 150 0 1000 3 0 0 0 0 0 0 0 # SizeSel_13P_1_TRPOTHER
# 10 180 41.2539 90 0 1000 2 0 0 0 0 0 0 0 # SizeSel_13P_2_TRPOTHER  inc upper bound

  40 320 223.508 120 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_9P_1_TRPOTHER inc upper bound
 -10 3 -1 -1  -1 1000 -2 0 0 0 0 0 0 0 # SizeSel_9P_2_TRPOTHER top width fix at -1
 -5 12 9 9 -1 1000  2 0 0 0 0 0 0 0 # SizeSel_9P_3_TRPOTHER             asc width
 -5 9 0 0 -1 1000 -2 0 0 0 0 0 0 0 # SizeSel_9P_4_TRPOTHER desc width  fix at 0
 -999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_9P_5_TRPOTHER
 -20 10 -3.82955 2 -1 100 2 0 0 0 0 0 0 0 # SizeSel_9P_6_PTRPOTHER

 #40 250 40.3899 120 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_14P_1_OTR
 #-10 3 2.13519 -1.16787 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_14P_2_OTR
 #-5 9 8.88813 4.81298 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_14P_3_OTR
 #-5 9 3.98919 6.75951 -1 1000 2 0 0 0 0 0 0 0 # SizeSel_14P_4_OTR
 #-999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # SizeSel_14P_5_OTR
 #-20 10 -4.27175 2 -1 100 2 0 0 0 0 0 0 0 # SizeSel_14P_6_OTR

 1 26 2 2 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_23P_1_AS
 1 26 4 4 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_23P_2_AS
 1 26 2 2 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_23P_1_AS
 1 26 4 4 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_23P_2_AS
#_Cond 0 #_custom_sel-env_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no enviro fxns

1 #_custom_sel-blk_setup (0/1) 

# PS_FR_selex block replacement values
-9      7        0       0       -1      0.001    2  # SizeSpline_Val_1_PS_FR_9_BLK1repl_1994
-9      7       -9       0       -1      0.001   -2  # SizeSpline_Val_1_PS_FR_9_BLK1repl_2007  fix at -9
-9      7        0       0       -1      0.001    2  # SizeSpline_Val_2_PS_FR_9_BLK1repl_1994
-9      7        0       0       -1      0.001    2  # SizeSpline_Val_2_PS_FR_9_BLK1repl_2007
-9      7        0       0       -1      0.001   -2  # SizeSpline_Val_3_PS_FR_9_BLK1repl_1994
-9      7        0       0       -1      0.001   -2  # SizeSpline_Val_3_PS_FR_9_BLK1repl_2007
-9      7        0       0       -1      0.001    2  # SizeSpline_Val_4_PS_FR_9_BLK1repl_1994
-9      7        0       0       -1      0.001    2  # SizeSpline_Val_4_PS_FR_9_BLK1repl_2007
-9      7        0       0       -1      0.001    2  # SizeSpline_Val_5_PS_FR_9_BLK1repl_1994
-9      7        0       0       -1      0.001    2  # SizeSpline_Val_5_PS_FR_9_BLK1repl_2007

6 #_selparmdev-phase
2 #_env/block/dev_adjust_method (1=standard; 2=logistic trans to keep in base parm bounds; 3=standard w/ no bound check)
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
1 #_Variance_adjustments_to_input_values
#_fleet: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_add_to_survey_CV
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_add_to_discard_stddev
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_add_to_bodywt_CV
  0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 #_mult_by_lencomp_N
  0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 #_mult_by_agecomp_N
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_mult_by_size-at-age_N
#
4 #_maxlambdaphase
1 #_sd_offset
#
43 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  sizefreq_method
 1 16 1 1 1
 1 17 1 1 1
 1 18 1 1 1
 1 19 1 1 1
 1 20 1 1 1
 1 21 1 0 1
 1 22 1 1 1
 1 23 1 1 1
 1 24 1 1 1
 1 25 1 1 1
 1 26 1 1 1
 4 1 1 1 1
 5 1 1 1 1
 4 2 1 1 1
 5 2 1 1 1
 4 3 1 1 1
 5 3 1 1 1
 4 4 1 1 1
 5 4 1 1 1
 4 5 1 1 1
 5 5 1 1 1
 4 6 1 1 1
 5 6 1 1 1
 4 7 1 1 1
 5 7 1 1 1
 4 8 1 1 1
 5 8 1 1 1
 4 9 1 1 1
 5 9 1 1 1
 4 10 1 1 1
 5 10 1 1 1
 4 11 1 1 1
 5 11 1 1 1
 4 12 1 1 1
 5 12 1 1 1
 4 13 1 1 1
 5 13 1 1 1
 4 14 1 1 1
 5 14 1 1 1
 4 15 1 1 1
 5 15 1 1 1
 11 1 1 1 1
 12 1 1 1 1
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 #_CPUE/survey:_1
#  0 0 0 0 #_CPUE/survey:_2
#  0 0 0 0 #_CPUE/survey:_3
#  0 0 0 0 #_CPUE/survey:_4
#  0 0 0 0 #_CPUE/survey:_5
#  0 0 0 0 #_CPUE/survey:_6
#  0 0 0 0 #_CPUE/survey:_7
#  0 0 0 0 #_CPUE/survey:_8
#  0 0 0 0 #_CPUE/survey:_9
#  0 0 0 0 #_CPUE/survey:_10
#  0 0 0 0 #_CPUE/survey:_11
#  0 0 0 0 #_CPUE/survey:_12
#  0 0 0 0 #_CPUE/survey:_13
#  0 0 0 0 #_CPUE/survey:_14
#  1 1 1 1 #_CPUE/survey:_15
#  1 1 1 1 #_CPUE/survey:_16
#  1 1 1 1 #_CPUE/survey:_17
#  1 1 1 1 #_CPUE/survey:_18
#  1 1 1 1 #_CPUE/survey:_19
#  0 0 0 0 #_CPUE/survey:_20
#  1 1 1 1 #_CPUE/survey:_21
#  1 1 1 1 #_CPUE/survey:_22
#  1 1 1 1 #_CPUE/survey:_23
#  1 1 1 1 #_lencomp:_1
#  1 1 1 1 #_lencomp:_2
#  1 1 1 1 #_lencomp:_3
#  1 1 1 1 #_lencomp:_4
#  1 1 1 1 #_lencomp:_5
#  1 1 1 1 #_lencomp:_6
#  1 1 1 1 #_lencomp:_7
#  1 1 1 1 #_lencomp:_8
#  1 1 1 1 #_lencomp:_9
#  0 0 0 0 #_lencomp:_10
#  1 1 1 1 #_lencomp:_11
#  1 1 1 1 #_lencomp:_12
#  1 1 1 1 #_lencomp:_13
#  1 1 1 1 #_lencomp:_14
#  0 0 0 0 #_lencomp:_15
#  0 0 0 0 #_lencomp:_16
#  0 0 0 0 #_lencomp:_17
#  0 0 0 0 #_lencomp:_18
#  0 0 0 0 #_lencomp:_19
#  0 0 0 0 #_lencomp:_20
#  0 0 0 0 #_lencomp:_21
#  0 0 0 0 #_lencomp:_22
#  0 0 0 0 #_lencomp:_23
#  1 1 1 1 #_init_equ_catch
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

