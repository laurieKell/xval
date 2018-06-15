#v3.24j
#c growth parameters are estimated
#c spawner-recruitment bias adjustment not tuned for optimality
#_data_and_control_files: complex.dat // complex.ctl
#_ss-v3.24j-opt;_11/14/2012;_stock_synthesis_by_richard_methot_(noaa)_using_admb_10.1
1  #_n_growth_patterns
1 #_n_morphs_within_growthpattern
#_cond 1 #_morph_between/within_stdev_ratio (no read if n_morphs=1)
#_cond  1 #vector_morphdist_(-1_in_first_val_gives_normal_approx)
#
#_cond 0  #  n recruitment designs goes here if n_gp*nseas*area>1
#_cond 0  #  placeholder for recruitment interaction request
#_cond 1 1 1  # example recruitment design element for gp=1, seas=1, area=1
#
#_cond 0 # n_movement_definitions goes here if n_areas > 1
#_cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
1 #_nblock_patterns
2 #_blocks_per_pattern
# begin and end years of blocks
1994 2006 2007 2016
#
0.5 #_fracfemale
3 #_natm_type:_0=1parm; 1=n_breakpoints;_2=lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
#_age_natmort_by gender x growthpattern
0.47 0.37 0.3 0.25 0.21 0.18 0.16 0.15 0.14 0.13 0.12 0.12 0.11 0.11 0.11 0.11 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1
2 # growthmodel: 1=vonbert with l1&l2; 2=richards with l1&l2; 3=age_speciific_k; 4=not implemented
0.5 #_growth_age_for_l1
30 #_growth_age_for_l2 (999 to use as linf)
0 #_sd_add_to_laa (set to 0.1 for ss2 v1.x compatibility)
0 #_cv_growth_pattern:  0 cv=f(laa); 1 cv=f(a); 2 sd=f(laa); 3 sd=f(a); 4 logsd=f(a)
3 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=read fec and wt from wtatage.ss
#_age_maturity by growth pattern
0 0 0 0.25 0.5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
3 #_first_mature_age
1 #_fecundity option:(1)eggs=wt*(a+b*wt);(2)eggs=a*l^b;(3)eggs=a*wt^b; (4)eggs=a+b*l; (5)eggs=a+b*w
0 #_hermaphroditism option:  0=none; 1=age-specific fxn
1 #_parameter_offset_approach (1=none, 2= m, g, cv_g as offset from female-gp1, 3=like ss2 v1.x)
2 #_env/block/dev_adjust_method (1=standard; 2=logistic transform keeps in base parm bounds; 3=standard w/ no bound check)
#
#_growth_parms
#_lo hi init prior pr_type sd phase env-var use_dev dev_minyr dev_maxyr dev_stddev block block_fxn
10 45 32.9541 36 -1 10  -5 0 0 0 0 0 0 0 # l_at_amin_fem_gp_1
200 340 319 319 1 5  4 0 0 0 0 0 0 0 # l_at_amax_fem_gp_1   prior
0.01 0.4 0.22 0.15 -1 0.8   4 0 0 0 0 0 0 0 # vonbert_k_fem_gp_1
-3	3	-0.12	0.58	0	0.8	4	0	0	0	0	0.5	0	0	#	richards_coeff
0.05 0.25 0.1 0.1 -1 0.8  3 0 0 0 0 0 0 0 # cv_young_fem_gp_1
0.02 0.25 0.06 0.1 -1 0.8  3 0 0 0 0 0 0 0 # cv_old_fem_gp_1
-3 3 2.95e-005 2.95e-005 -1 0.8 -3 0 0 0 0 0 0 0 # wtlen_1_fem
-3 4 2.899 2.899 -1 0.8 -3 0 0 0 0 0 0 0 # wtlen_2_fem
3 5 4 4 -1 0.8 -3 0 0 0 0 0 0 0 # mat50%_fem
-7 -3 -5 -5 -1 0.8 -3 0 0 0 0 0 0 0 # mat_slope_fem
-3 3 1 1 -1 0.8 -3 0 0 0 0 0 0 0 # eggs/kg_inter_fem
-3 3 0 0 -1 0.8 -3 0 0 0 0 0 0 0 # eggs/kg_slope_wt_fem
0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # recrdist_gp_1
0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # recrdist_area_1
0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # recrdist_seas_1
0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # cohortgrowdev
#
#_cond 0  #custom_mg-env_setup (0/1)
#_cond -2 2 0 0 -1 99 -2 #_placeholder when no mg-environ parameters
#
#_cond 0  #custom_mg-block_setup (0/1)
#_cond -2 2 0 0 -1 99 -2 #_placeholder when no mg-block parameters
#_cond no mg parm trends
#
#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,malewtlen1,malewtlen2,l1,k
#_cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal mg parameters
#
#_cond -4 #_mgparm_dev_phase
#
#_spawner-recruitment
6 #_sr_function: 2=ricker; 3=std_b-h; 4=scaa; 5=hockey; 6=b-h_flattop; 7=survival_3parm
#_lo hi init prior pr_type sd phase
6 15 7.98019 10.3 -1 10 1 # sr_ln(r0)
0.2 1 0.9 0.9 -1 0.05 -3 # sr_bh_flat_steep
0 2 0.6 0.6 -1 0.2 -5 # sr_sigmar
-5 5 0 0 -1 1 -3 # sr_envlink
-5 5 0 0 -1 1 -2 # sr_r1_offset
0 0 0 0 -1 0 -99 # sr_autocorr
0 #_sr_env_link
0 #_sr_env_target_0=none;1=devs;_2=r0;_3=steepness
0 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1950 # first year of main recr_devs; early devs can preceed this era
2014 # last year of main recr_devs; forecast devs start in following year
6 #_recdev phase
1 # (0/1) to read 13 advanced options
-15 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
6 #_recdev_early_phase
0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1 #_lambda for fcast_recr_like occurring before endyr+1
1931 #_last_early_yr_nobias_adj_in_mpd
1962 #_first_yr_fullbias_adj_in_mpd
1998 #_last_yr_fullbias_adj_in_mpd
2083 #_first_recent_yr_nobias_adj_in_mpd
0.93 #_max_bias_adj_in_mpd (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
0 #_period of cycles in recruitment (n parms read below)
-5 #min rec_dev
7 #max rec_dev
54 #_read_recdevs
#_end of advanced sr options
#
#_placeholder for full parameter lines for recruitment cycles
# specified recr devs to read
#_yr input_value # final_value
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
#displayonly 0.00172603 # early_initage_15
#displayonly 0.00858505 # early_initage_14
#displayonly 0.0199862 # early_initage_13
#displayonly 0.0375072 # early_initage_12
#displayonly 0.063021 # early_initage_11
#displayonly 0.0998965 # early_initage_10
#displayonly 0.157875 # early_initage_9
#displayonly 0.256438 # early_initage_8
#displayonly 0.415462 # early_initage_7
#displayonly 0.555121 # early_initage_6
#displayonly 0.43463 # early_initage_5
#displayonly 0.278118 # early_initage_4
#displayonly 0.204216 # early_initage_3
#displayonly -0.206412 # early_initage_2
#displayonly -1.0933 # early_initage_1
#displayonly -1.37648 # main_recrdev_1950
#displayonly -1.1664 # main_recrdev_1951
#displayonly -0.995871 # main_recrdev_1952
#displayonly -1.00287 # main_recrdev_1953
#displayonly -0.135267 # main_recrdev_1954
#displayonly -0.878879 # main_recrdev_1955
#displayonly -0.795625 # main_recrdev_1956
#displayonly 0.0451022 # main_recrdev_1957
#displayonly -0.358654 # main_recrdev_1958
#displayonly -0.956664 # main_recrdev_1959
#displayonly -1.14939 # main_recrdev_1960
#displayonly -0.261324 # main_recrdev_1961
#displayonly -0.314537 # main_recrdev_1962
#displayonly -0.863137 # main_recrdev_1963
#displayonly -0.197228 # main_recrdev_1964
#displayonly -0.397854 # main_recrdev_1965
#displayonly -0.173652 # main_recrdev_1966
#displayonly 0.0624002 # main_recrdev_1967
#displayonly -0.061275 # main_recrdev_1968
#displayonly 0.0843448 # main_recrdev_1969
#displayonly -0.165662 # main_recrdev_1970
#displayonly -0.405195 # main_recrdev_1971
#displayonly -0.898918 # main_recrdev_1972
#displayonly -0.0834374 # main_recrdev_1973
#displayonly -0.427511 # main_recrdev_1974
#displayonly -0.171772 # main_recrdev_1975
#displayonly -0.0331124 # main_recrdev_1976
#displayonly -0.275491 # main_recrdev_1977
#displayonly -0.259671 # main_recrdev_1978
#displayonly -0.490653 # main_recrdev_1979
#displayonly -0.271527 # main_recrdev_1980
#displayonly -0.302555 # main_recrdev_1981
#displayonly -0.519126 # main_recrdev_1982
#displayonly 0.389415 # main_recrdev_1983
#displayonly -0.262422 # main_recrdev_1984
#displayonly 0.344267 # main_recrdev_1985
#displayonly 0.483925 # main_recrdev_1986
#displayonly 0.446747 # main_recrdev_1987
#displayonly 0.399868 # main_recrdev_1988
#displayonly 0.406775 # main_recrdev_1989
#displayonly 0.296858 # main_recrdev_1990
#displayonly 1.61344 # main_recrdev_1991
#displayonly 0.619711 # main_recrdev_1992
#displayonly 1.19951 # main_recrdev_1993
#displayonly 1.62067 # main_recrdev_1994
#displayonly 1.35379 # main_recrdev_1995
#displayonly -0.278552 # main_recrdev_1996
#displayonly -0.39193 # main_recrdev_1997
#displayonly 0.927352 # main_recrdev_1998
#displayonly 0.467636 # main_recrdev_1999
#displayonly 0.305204 # main_recrdev_2000
#displayonly -0.158355 # main_recrdev_2001
#displayonly 1.48169 # main_recrdev_2002
#displayonly 1.66488 # main_recrdev_2003
#displayonly 0.174385 # main_recrdev_2004
#displayonly 1.15389 # main_recrdev_2005
#displayonly -0.0909053 # main_recrdev_2006
#displayonly 0.689467 # main_recrdev_2007
#displayonly 1.14874 # main_recrdev_2008
#displayonly 0.399348 # main_recrdev_2009
#displayonly -0.243743 # main_recrdev_2010
#displayonly -0.691373 # main_recrdev_2011
#displayonly -0.278674 # main_recrdev_2012
#displayonly 0.0256401 # main_recrdev_2013
#displayonly -0.0193757 # main_recrdev_2014
#
#fishing mortality info
0.3 # f ballpark for tuning early phases
-2001 # f ballpark year (neg value to disable)
3 # f_method:  1=pope; 2=instan. f; 3=hybrid (hybrid is recommended)
2.9 # max f or harvest rate, depends on f_method
# no additional f input needed for fmethod 1
# if fmethod=2; read overall start f value; overall phase; n detailed inputs to read
# if fmethod=3; read n iterations for tuning for fmethod 3
4  # n iterations for tuning f in hybrid method (recommend 3 to 7)
#
#_initial_f_parms
#####9.3.15: initial f in equilibrium#####
#_lo hi init prior pr_type sd phase
0 1 0 0 -1 99  -1             # bb52_06   1
0 1 0 0 -1 99  -2                  # bb06_15   2
0 1 0 0 -1 99  -1                  # ll1   3
0 1 0 0 -1 99  -1                  # ll2   4
0 1 0 0 -1 99  -1                  # ll3   5
0 1 0 0 -1 99  -1                  # ll4   6
0 1 0 0 -1 99  -1                  # ps_nor   7
0 1 0 0 -1 99  -2                  # ps_cro   8
0 1 0 0 -1 99  -1                  # ps_fr   9
0 1 0.01 0.01 -1 99  -1     # psother   10  fix due to bound
0 1 0 0 -1 99  -1                  # psinfl   11
0 1 0.015 0.015 -1 99  -1             # trp1   12
0 1 0 0 -1 99  -2                  # trp2   13
0 1 0.03 0.01 -1 99  -1      # trpother   14 fix due to bound
0 1 0.005 0.005 -1 99  -1       # otr   15  fix due to bound
#
#
#_q_setup
# q_type options:  <0=mirror, 0=float_nobiasadj, 1=float_biasadj, 2=parm_nobiasadj, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
#_for_env-var:_enter_index_of_the_env-var_to_be_linked
#_den-dep  env-var  extra_se  q_type
0 0 0 0 # 1 bb52_06
0 0 0 0 # 2 bb06_15
0 0 0 0 # 3 ll1
0 0 0 0 # 4 ll2
0 0 0 0 # 5 ll3
0 0 0 0 # 6 ll4
0 0 0 0 # 7 ps_nor
0 0 0 0 # 8 ps_cro
0 0 0 0 # 9 ps_fr
0 0 0 0 # 10 psother
0 0 0 0 # 11 psinfl
0 0 0 0 # 12 trp1
0 0 0 0 # 13 trp2
0 0 0 0 # 14 trpother
0 0 0 0 # 15 otr
0 0 0 0 # 16 mor1
0 0 0 0 # 17 mor2
0 0 0 0 # 18 spbb1
0 0 0 0 # 19 spbb2
0 0 0 0 # 20 jpll_em
0 0 0 0 # 21 norps
0 0 0 0 # 22 jpll_nea
0 0 0 0 # 23 jpll_nea2
0 0 0 0 # 24 ls
0 0 0 0 # 25 as
0 0 0 0 # 26 as2
#
#_cond 0 #_if q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_q_parms(if_any);qunits_are_ln(q)
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_pattern discard male special
24 0 0 0 # 1 bb52_06
24 0 0 0 # 2 bb06_15
24 0 0 0 # 3 ll1
24 0 0 0 # 4 ll2
24 0 0 0 # 5 ll3
15 0 0 3 # 6 ll4
24 0 0 0 # 7 ps_nor
24 0 0 0 # 8 ps_cro
27 0 0 5 # 9 ps_fr
24 0 0 0 # 10 psother
15 0 0 9 # 11 psinfl
24 0 0 0 # 12 trp1
1 0 0 0 # 13 trp2
24 0 0 0 # 14 trpother
15 0 0 14 # 15 otr
15 0 0 12 # 16 mor1
15 0 0 13 # 17 mor2
15 0 0 1 # 18 spbb1
15 0 0 2 # 19 spbb2
15 0 0 3 # 20 jpll_em
15 0 0 7 # 21 norps
15 0 0 4 # 22 jpll_nea
15 0 0 5 # 23 jpll_nea2
30 0 0 0 # 24 ls
30 0 0 0 # 25 as1
30 0 0 0 # 26 as2
#
#_age_selex_types
#_pattern ___ male special
10 0 0 0 # 1 bb52_06
10 0 0 0 # 2 bb06_15
10 0 0 0 # 3 ll1
10 0 0 0 # 4 ll2
10 0 0 0 # 5 ll3
10 0 0 0 # 6 ll4
10 0 0 0 # 7 ps_nor
10 0 0 0 # 8 ps_cro
10 0 0 0 # 9 ps_fr
10 0 0 0 # 10 psother
10 0 0 0 # 11 psinfl
10 0 0 0 # 12 trp1
10 0 0 0 # 13 trp2
10 0 0 0 # 14 trpother
10 0 0 0 # 15 otr
10 0 0 0 # 16 mor1
10 0 0 0 # 17 mor2
10 0 0 0 # 18 spbb1
10 0 0 0 # 19 spbb2
10 0 0 0 # 20 jpll_em
10 0 0 0 # 21 jpll_em2
10 0 0 0 # 22 norps
10 0 0 0 # 23 jpll_nea
10 0 0 0 # 24 ls
11 0 0 0 # 25 as
11 0 0 0 # 26 as2
# sel
#_lo hi init prior pr_type sd phase env-var use_dev dev_minyr dev_maxyr dev_stddev block block_fxn
40 250 76.1545115239 77.6762 -1 1000 0 0 0 0 0 0 0 0 # sizesel_1p_1_bb52_06
-10 3 -4.84891040553 -2.06394 1 5 0 0 0 0 0 0 0 0 # sizesel_1p_2_bb52_06
-5 9 4.46255000000 4.81298 1 5 -2 0 0 0 0 0 0 0 # sizesel_1p_3_bb52_06 prior
-5 9 5.45251517197 0.179265 1 5 0 0 0 0 0 0 0 0 # sizesel_1p_4_bb52_06
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_1p_5_bb52_06 fix smooth increase
-20 10 -999.000000000 2 -1 100 -2 0 0 0 0 0 0 0 # sizesel_1p_6_bb52_06 fix smooth decline
40 250 93.2340045904 97 1 5 0 0 0 0 0 0 0 0 # sizesel_2p_1_bb06_15 priors
-10 3 -1.68424972694 -8 1 5 0 0 0 0 0 0 0 0 # sizesel_2p_2_bb06_15 priors
-5 9 3.93072868375 5 1 5 0 0 0 0 0 0 0 0 # sizesel_2p_3_bb06_15 priors
-5 9 2.53459675959 6.2 1 5 0 0 0 0 0 0 0 0 # sizesel_2p_4_bb06_15 priors
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_2p_5_bb06_15 fix smooth increase
-20 10 -999.000000000 2 -1 100 -2 0 0 0 0 0 0 0 # sizesel_2p_6_bb06_15 fix smooth decline
#####  we could just make this one asymptotic
40 330 270.785903699 120 -1 1000 0 0 0 0 0 0 0 0 # sizesel_4p_1_ll1 inc bound
-10 3 -5.06107000000 -1.16787 -1 1000 -2 0 0 0 0 0 0 0 # sizesel_4p_2_ll1 top doesn't mater
-5 12 8.95793942414 4.81298 -1 1000 0 0 0 0 0 0 0 0 # sizesel_4p_3_ll1 asc width
-5 9 5.05524000000 6.75951 -1 1000 -3 0 0 0 0 0 0 0 # sizesel_4p_4_ll1 desc width, fix doesn't matter
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_4p_5_ll1
-20 10 10.0000000000 2 -1 100 -3 0 0 0 0 0 0 0 # sizesel_4p_6_ll1 fix at asymptotic
#####
40 250 151.893990387 120 -1 1000 0 0 0 0 0 0 0 0 # sizesel_4p_1_ll2
-10 3 -1.51766478844 -1.16787 -1 1000 0 0 0 0 0 0 0 0 # sizesel_4p_2_ll2
-5 9 5.00000000000 5 -1 1000 -3 0 0 0 0 0 0 0 # sizesel_4p_3_ll2 fix at 5 due to high corr with parm 1
-5 9 7.30424927910 6.75951 -1 1000 0 0 0 0 0 0 0 0 # sizesel_4p_4_ll2
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_4p_5_ll2
-20 10 -2.09912710725 2 -1 100 0 0 0 0 0 0 0 0 # sizesel_4p_6_ll2
40 250 196.432000132 120 -1 1000 0 0 0 0 0 0 0 0 # sizesel_4p_1_ll3
-10 3 -1.26726306261 -1.16787 -1 1000 0 0 0 0 0 0 0 0 # sizesel_5p_2_ll3
-5 9 5.00000000000 5 -1 1000 -3 0 0 0 0 0 0 0 # sizesel_5p_3_ll3 fix at 5 due to high corr with parm 1
-5 9 3.70495333097 6.75951 -1 1000 0 0 0 0 0 0 0 0 # sizesel_5p_4_ll3
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_5p_5_ll3
-20 10 -2.99736619853 2 -1 100 0 0 0 0 0 0 0 0 # sizesel_5p_6_ll3
#ll 4 mirrors ll1
#40 250 249.952 120 -1 1000 2 0 0 0 0 0 0 0 # sizesel_5p_1_ll3
#-10 3 -0.669697 -1.16787 -1 1000 2 0 0 0 0 0 0 0 # sizesel_5p_2_ll3
#-5 9 8.99981 4.81298 -1 1000 3 0 0 0 0 0 0 0 # sizesel_5p_3_ll3
#-5 9 2.18393 6.75951 -1 1000 3 0 0 0 0 0 0 0 # sizesel_5p_4_ll3
#-999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_5p_5_ll3
#-20 10 5.64177 2 -1 100 3 0 0 0 0 0 0 0 # sizesel_5p_6_ll3
40 250 148.095091201 156 1 5 0 0 3 1955 1984 0.2 0 0 # sizesel_6p_1_ps_nor prior
-10 3 0.626442965106 -.55 1 5 0 0 0 0 0 0 0 0 # sizesel_6p_2_ps_nor prior
-5 9 -5.00000000000 -5 -1 5 -3 0 0 0 0 0 0 0 # sizesel_6p_3_ps_nor prior
-5 9 2.55147339790 5 1 5 0 0 0 0 0 0 0 0 # sizesel_6p_4_ps_nor prior
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_6p_5_ps_nor
-20 10 -4.34983122763 -3.1 1 5 0 0 0 0 0 0 0 0 # sizesel_6p_6_ps_nor prior
40 250 77.0953545925 76 1 0.5 0 0 0 0 0 0 0 0 # sizesel_7p_1_ps_cro
-10 3 -0.558549663073 -1.16 1 5 0 0 0 0 0 0 0 0 # sizesel_7p_2_ps_cro prior sym beta u
-5 9 1.96907435257 0.56 1 5 0 0 0 0 0 0 0 0 # sizesel_7p_3_ps_cro
-5 9 2.12632493806 7.3 1 5 0 0 0 0 0 0 0 0 # sizesel_7p_4_ps_cro prior
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_7p_5_ps_cro
-20 10 -999.000000000 2 -1 100 -3 0 0 0 0 0 0 0 # sizesel_7p_6_ps_cro fix to smooth decline to 0
0 70 0.00000000000 0 -1 0 -99 0 0 0 0 0 0 0 # sizespline_code_ps_fr_8
-0.001 1 0.00000000000 0 -1 0 -3 0 0 0 0 0 0 0 # sizespline_gradlo_ps_fr_8
-1 0.001 0.00000000000 0 -1 0 -3 0 0 0 0 0 0 0 # sizespline_gradhi_ps_fr_8
1 300 10.0000000000 0 -1 0 -99 0 0 0 0 0 0 0 # sizespline_knot_1_ps_fr_8
1 300 100.000000000 0 -1 0 -99 0 0 0 0 0 0 0 # sizespline_knot_2_ps_fr_8
1 300 150.000000000 0 -1 0 -99 0 0 0 0 0 0 0 # sizespline_knot_3_ps_fr_8
1 350 200.000000000 0 -1 0 -99 0 0 0 0 0 0 0 # sizespline_knot_4_ps_fr_8
1 350 250.000000000 0 -1 0 -99 0 0 0 0 0 0 0 # sizespline_knot_5_ps_fr_8
-9 7 -3.31446970944 0 -1 0.001 0 0 0 0 0 0 1 2 # sizespline_val_1_ps_fr_8
-9 7 0.847301110817 0 -1 0.001 0 0 0 0 0 0 1 2 # sizespline_val_2_ps_fr_8
-9 7 0.00000000000 0 -1 0.001 -2 0 0 0 0 0 1 2 # sizespline_val_3_ps_fr_8
-9 7 -0.0844844184673 0 -1 0.001 0 0 0 0 0 0 1 2 # sizespline_val_4_ps_fr_8
-9 7 -7.83606891862 0 -1 0.001 0 0 0 0 0 0 1 2 # sizespline_val_5_ps_fr_8
40 270 202.778143574 120 1 5 0 0 0 0 0 0 0 0 # sizesel_9p_1_psother put prior on
-10 3 -1.00000000000 -1 -1 1000 -2 0 0 0 0 0 0 0 # sizesel_9p_2_psother top width fix at -1
-5 12 8.68246553828 9 -1 1000 0 0 0 0 0 0 0 0 # sizesel_9p_3_psother asc width
-5 9 7.68836892500 6.75951 -1 1000 0 0 0 0 0 0 0 0 # sizesel_9p_4_psother desc width
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_9p_5_psother
-20 10 -1.95282840346 2 -1 100 0 0 0 0 0 0 0 0 # sizesel_9p_6_psother
#10 300 199.013 150 0 1000 3 0 0 0 0 0 0 0 # sizesel_11p_1_trp1
#10 200 40.6457 90 0 1000 2 0 0 0 0 0 0 0 # sizesel_11p_2_trp1   inc bound
40 270 245.033234593 120 -1 1000 0 0 0 0 0 0 0 0 # sizesel_9p_1_trp1inc upper bound
-10 3 -1.00000000000 -1 -1 1000 -2 0 0 0 0 0 0 0 # sizesel_9p_2_trp1 top width fix at -1
-5 12 7.89360639836 9 -1 1000 0 0 0 0 0 0 0 0 # sizesel_9p_3_trp1 asc width
-5 9 -4.63598746578 6.75951 -1 1000 0 0 0 0 0 0 0 0 # sizesel_9p_4_trp1 desc width
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_9p_5_trp1
-20 10 -10.6745017037 2 -1 100 0 0 0 0 0 0 0 0 # sizesel_9p_6_trp1
10 300 184.190178776 150 0 1000 0 0 0 0 0 0 0 0 # sizesel_12p_1_trp2
10 150 22.4469405186 90 0 1000 0 0 0 0 0 0 0 0 # sizesel_12p_2_trp2
# 10 300 143.819 150 0 1000 3 0 0 0 0 0 0 0 # sizesel_13p_1_trpother
# 10 180 41.2539 90 0 1000 2 0 0 0 0 0 0 0 # sizesel_13p_2_trpother  inc upper bound
40 320 248.193177029 120 -1 1000 0 0 0 0 0 0 0 0 # sizesel_9p_1_trpother inc upper bound
-10 3 -1.00000000000 -1 -1 1000 -2 0 0 0 0 0 0 0 # sizesel_9p_2_trpother top width fix at -1
-5 12 9.20927805300 9 -1 1000 0 0 0 0 0 0 0 0 # sizesel_9p_3_trpother asc width
-5 9 0.00000000000 0 -1 1000 -2 0 0 0 0 0 0 0 # sizesel_9p_4_trpother desc width fix at 0
-999 15 -999.000000000 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_9p_5_trpother
-20 10 -13.3740985694 2 -1 100 0 0 0 0 0 0 0 0 # sizesel_9p_6_ptrpother
#40 250 40.3899 120 -1 1000 2 0 0 0 0 0 0 0 # sizesel_14p_1_otr
#-10 3 2.13519 -1.16787 -1 1000 2 0 0 0 0 0 0 0 # sizesel_14p_2_otr
#-5 9 8.88813 4.81298 -1 1000 2 0 0 0 0 0 0 0 # sizesel_14p_3_otr
#-5 9 3.98919 6.75951 -1 1000 2 0 0 0 0 0 0 0 # sizesel_14p_4_otr
#-999 15 -999 -1 -1 5 -3 0 0 0 0 0 0 0 # sizesel_14p_5_otr
#-20 10 -4.27175 2 -1 100 2 0 0 0 0 0 0 0 # sizesel_14p_6_otr
1 26 2.00000000000 2 -1 99 -1 0 0 0 0 0 0 0 # agesel_23p_1_as
1 26 4.00000000000 4 -1 99 -1 0 0 0 0 0 0 0 # agesel_23p_2_as
1 26 2.00000000000 2 -1 99 -1 0 0 0 0 0 0 0 # agesel_23p_1_as
1 26 4.00000000000 4 -1 99 -1 0 0 0 0 0 0 0 # agesel_23p_2_as
#_cond 0 #_custom_sel-env_setup (0/1)
#_cond -2 2 0 0 -1 99 -2 #_placeholder when no enviro fxns
1 #_custom_sel-blk_setup (0/1)
# ps_fr_selex block replacement values
-9      7        0       0       -1      0.001    2  # sizespline_val_1_ps_fr_9_blk1repl_1994
-9      7       -9       0       -1      0.001   -2  # sizespline_val_1_ps_fr_9_blk1repl_2007  fix at -9
-9      7        0       0       -1      0.001    2  # sizespline_val_2_ps_fr_9_blk1repl_1994
-9      7        0       0       -1      0.001    2  # sizespline_val_2_ps_fr_9_blk1repl_2007
-9      7        0       0       -1      0.001   -2  # sizespline_val_3_ps_fr_9_blk1repl_1994
-9      7        0       0       -1      0.001   -2  # sizespline_val_3_ps_fr_9_blk1repl_2007
-9      7        0       0       -1      0.001    2  # sizespline_val_4_ps_fr_9_blk1repl_1994
-9      7        0       0       -1      0.001    2  # sizespline_val_4_ps_fr_9_blk1repl_2007
-9      7        0       0       -1      0.001    2  # sizespline_val_5_ps_fr_9_blk1repl_1994
-9      7        0       0       -1      0.001    2  # sizespline_val_5_ps_fr_9_blk1repl_2007
6 #_selparmdev-phase
2 #_env/block/dev_adjust_method (1=standard; 2=logistic trans to keep in base parm bounds; 3=standard w/ no bound check)
#
# tag loss and tag reporting parameters go next
0  # tg_custom:  0=no read; 1=read if tags exist
#_cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
1 #_variance_adjustments_to_input_values
#_fleet: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_add_to_survey_cv
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_add_to_discard_stddev
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_add_to_bodywt_cv
0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 0.0001 #_mult_by_lencomp_n
0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 #_mult_by_agecomp_n
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_mult_by_size-at-age_n
#
4 #_maxlambdaphase
1 #_sd_offset
#
43 # number of changes to make to default lambdas (default value is 1.0)
# like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=sizefreq; 7=sizeage; 8=catch;
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=crashpen; 14=morphcomp; 15=tag-comp; 16=tag-negbin
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
#  0 0 0 0 #_cpue/survey:_1
#  0 0 0 0 #_cpue/survey:_2
#  0 0 0 0 #_cpue/survey:_3
#  0 0 0 0 #_cpue/survey:_4
#  0 0 0 0 #_cpue/survey:_5
#  0 0 0 0 #_cpue/survey:_6
#  0 0 0 0 #_cpue/survey:_7
#  0 0 0 0 #_cpue/survey:_8
#  0 0 0 0 #_cpue/survey:_9
#  0 0 0 0 #_cpue/survey:_10
#  0 0 0 0 #_cpue/survey:_11
#  0 0 0 0 #_cpue/survey:_12
#  0 0 0 0 #_cpue/survey:_13
#  0 0 0 0 #_cpue/survey:_14
#  1 1 1 1 #_cpue/survey:_15
#  1 1 1 1 #_cpue/survey:_16
#  1 1 1 1 #_cpue/survey:_17
#  1 1 1 1 #_cpue/survey:_18
#  1 1 1 1 #_cpue/survey:_19
#  0 0 0 0 #_cpue/survey:_20
#  1 1 1 1 #_cpue/survey:_21
#  1 1 1 1 #_cpue/survey:_22
#  1 1 1 1 #_cpue/survey:_23
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
#  1 1 1 1 #_crashpenlambda
0 # (0/1) read specs for more stddev reporting
# 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, n selex bins, growth pattern, n growth ages, natage_area(-1 for all), natage_yr, n natages
# placeholder for vector of selex bins to be reported
# placeholder for vector of growth ages to be reported
# placeholder for vector of natages ages to be reported
999
