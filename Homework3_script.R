##########################
## MKTG 4110 Homework 3 ##
##########################

###################
# GETTING STARTED #
###################

## Prepare script file and data
# Download the template and csv data file to desktop

## Open and clear r-studio
# Session -> Clear workspace -> Yes. Or type: rm(list=ls())
rm(list=ls())
# Clear the console
cat('\014')

library(tidyverse)

## Set working directory
# Session -> Set working directory -> Choose directory -> Select desktop -> Open; 



## Open .csv data
katespade = read.csv("katespade.csv", header=TRUE)
options(scipen = 999) ## Avoids scientific notation
