#---------------------------------------------------------------------------------      								
#	INPUT DATA FILE FOR VPA2-box PROJECT bluefin east 2010										
# data entry is free-format.  Null lines and comments must be											
# initiated here by pound signs (#) asterisks (*) or dashes (-).  Do not,											
# however, interrupt a stream of vector inputs with a comment.											
#---------------------------------------------------------------------------------											
#---------------------------------------------------------------------------------											
# Enter control information common to both areas/stocks											
#---------------------------------------------------------------------------------
 1		MODEL_TYPE  (1 = diffusion , 2 = overlap, 3 = sex-specific)
 1		N_BOX  {number of sexes/areas/stocks -- enter 1 or 2}
500		N_LOOPS {number of bootstrap projections, enter 0 if only a single deterministic run and a negative integer if you want the program to check the ASC-II file bad.out for bad runs}
 80		CI {confidence interval in percent (e.g., 80)}
-911		SEED {random number seed (should be a negative integer)}
 4		PATCH (>0)=number of recruitments replace with estimates from spawner-recruit curve, (<=0)=don t do it
 1		YR_BOX (1)=maximize y/r and msy of sex/area/stock 1 alone, or (2) of sex/area/stock 2 alone, or (3) of both stocks combined
 0		SR_BOX recruitment depends on fecundity of (1) sex 1 only, (2) sex 2 only, or (3) both sexes combined
 1		SEX_FRACTION = fraction of population belonging to sex 1 at age of recruitment (immaterial if SR_BOX<1 or N_box=1)
 1		WEIGHT_TYPE (0) use growth curve for all weights (1) use growth curve only for plus group projections, (2) do not use growth curve at all
 1968 2015 2050 	{FIRST year, LAST year in data, Last year to PROJECT}
 1 10 10 	First age followed by last ages for sex/area/stock 1 and 2 (a total of three entries)
#-------------------------------------------------------------------------											
# Enter the selectivity option: two positive integers indicate the first and 
#      last years for a geometric mean of the F's at age.  Any negative value indicates
#      that the user specified vector in the selectivity file are to be used (otherwise
#      the selectivity file values are used to modify the geometric mean)				
# 1997 1999  Values in 2002 Base
 2012 2014
#-------------------------------------------------------------------------											
# Enter the first and last years to use for recruitment and the first and last years for ssb
# 1976 1996  1991 2001  Values in 2002 Base ? For benchmarks?											
# 1990 2001  2000 2004  Values in 2006 Base ? For benchmarks?, 2000,2004 is the hinge point time period
 2006 2011 2000 2004
# Error type for recruitment projections and fitting spawner-recruit curves (1=lognormal, 2=normal)
  1 
#-------------------------------------------------------------------------											
# Enter area specific growth information for area/stock1											
#-------------------------------------------------------------------------
 1			N_GEARS (area 1)
-40			average age of the plus-group at the BEGINNING of the last year (-x) = compute from growth curve
0 0 0.25 0.5 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 		Maturity fraction
# curve type (1=von Bertalanffy or Chapman Richards, 2=Gompertz)
# |  Linfinity
# |  |     k
# |  |     |      tO
# |  |     |      |         Chapman-Richards skew parameter (m=1 for von Bert) - ignored if Gompertz used
# |  |     |      |         |     weight parameter a of w=al^b
# |  |     |      |         |     |          weight parameter b of w=al^b
# |  |     |      |         |     |          |       time of year for growth equation (in months)
# |  |     |      |         |     |          |       |    offset (months) to be subtracted from vpa age to get growth curve age
# |  |     |      |         |     |          |       |      |
   1 318.9 0.093 -0.97 1 0.0000350801 2.878450899 6 4		SSB
   1 318.9 0.093 -0.97 1 0.0000350801 2.878450899 6 4  	fishery
#-------------------------------------------------------------------------
# Enter area specific growth information for area/stock 2 (if any)							
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
# Enter file information
#-------------------------------------------------------------------------
# file type (0=asc-ii, default=VPA-2box binary format)
# |   file name
# |   |
  	0	quotas.txt
  	1	NAA.OUT
  	1	FAA.OUT
  	0	waa.txt
  	0	caa.txt
  	0	maa.txt
  	0	Sel.txt
  	0	recruit.txt
  	0	Trans.txt
  	0	discards.txt
#-------------------------------------------------------------------------		
# Enter names of optional input files (0=asc-ii,-9 = ignore)		
#------------------------------------------------------------------------- 		
  -9 recmod.txt         proportion from each fishery that is discarded	
  -9 NSIG.txt     	variance in abundance estimates for last year	
  -9 FSIG.txt     	variance in fishing mortality rate estimates for last year	
#-------------------------------------------------------------------------		
# Other optional inputs		
#------------------------------------------------------------------------- 		
# fractional change in M to define interval for random uniform deviate:  lower limit M = #(1-input)*Mbase, upper limit of M = (1+input)*Mbase), value <= 0 means do not do it		
 0
# bias-correct recruitment with lognormal error structure (value <= 0 means do not do it)		
# |  estimate recruitment autocorrelation parameter  (value <= 0 means do not do it)		
# |  |		
 1	1
# spawning potential ratio targets (enter three fractional values, e.g., 0.25 for 25% SPR)		
 0.4 0.3 0.2
# END OF FILE