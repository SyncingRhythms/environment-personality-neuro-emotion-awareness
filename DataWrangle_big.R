##### Data Wrangle 


## Libarary shit 

# library(dplyr)
# library(tidyverse)
# library(fauxnaif)
# library(summarytools)
# library(psych)
# library(DescTools)
library(MplusAutomation)
library(scales)

## Set working directory 

# file.choose()

setwd("/home/cglab/projects/abcd/data/abcd5.1-rser")


df <- read.csv('abcd5.1_rtmri_2b_epn_cort_subc_net_ders_thrt_demo1_qcr_urg_dep_wide_lf_hses.csv', na.strings = c("", "NaN", "nan", "NA"))


### process and save to dat for Mplus
# change extreme flags to NA
# df[df > 700] <- NA
# df[df < -700] <- NA
# change threat9 to threatf since ending number thats not a wave is confusing
names(df)[names(df) == 'Threat9'] <- 'Threatf'
# change HSES1 to DEPRV since ending number thats not a wave is confusing
names(df)[names(df) == 'HSES1'] <- 'Deprv'
# change ders_aware_clar_score_7 to Idntify7 to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_aware_clar_score_7'] <- 'Identify'
# change ders__name for ease of reading and to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_nonaccept_score_3_7'] <- 'NonAcpt'
# change to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_goals_score_3_7'] <- 'Goal'
# change to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
names(df)[names(df) == 'ders_impulse_score_3_7'] <- 'Impulse'

# change ders_aware_clar_score_9 to Idntify9 to match Smith et al., 2024; JPpBA ABCD substudy ders factor structure
# names(df)[names(df) == 'Idntify9'] <- 'ders_aware_clar_score_9'

# quadratic and cubic terms
df$ThrtfSQ <- df$Threatf**2
df$ThrtfCB <- df$Threatf**3
df$DeprvSQ <- df$Deprv**2
df$DeprvCB <- df$Deprv**3
# scale them
df$SThrtfSQ <- scale(df$ThrtfSQ)
df$SThrtfCB <- scale(df$ThrtfCB)
df$SDeprvSQ <- scale(df$DeprvSQ)
df$SDeprvCB <- scale(df$DeprvCB)
df$famID1 <- as.integer(df$famID1+1)
# df$MotT5 <- df$MotT2
# age in years
# df$agey <- df$age/12
# standardize some variables
# df$SrnkDif <- scale(df$AmygRnkDif)
df$Spropense <- rescale(df$prpensit1, to=c(0, 1))
df$Spedu <- scale(df$pedu1)
df$Sagey <- scale(df$agey1)
df$Sincome <- scale(df$income1)
df$Srace <- scale(df$race1)
# average of left and right precuneus
df$ePrecun1 <- rowMeans(df[,c('ePreCunL1', 'ePreCunR1')], na.rm=TRUE)
df$pPrecun1 <- rowMeans(df[,c('pPreCunL1', 'pPreCunR1')], na.rm=TRUE)
df$nPrecun1 <- rowMeans(df[,c('nPreCunL1', 'nPreCunR1')], na.rm=TRUE)
# df$SalVTA1 <- df$sa_ngd_vta_yr1
# df$SalVTA5 <- df$sa_ngd_vta_yr2
setwd("/home/cglab/projects/abcd/rser")
prepareMplusData(df, "ABCD_RSER_big_7-3-24.dat")