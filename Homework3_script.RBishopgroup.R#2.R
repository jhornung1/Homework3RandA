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


# 1. Define treatment and control groups
treatment <- katespade[katespade$ad == 1, ]
control <- katespade[katespade$ad == 0, ]


# 2. a) Two-sample t-test
ttest_result <- t.test(treatment$choice, control$choice)
print(ttest_result)

# Also calculate the mean purchase rate in both groups
mean_treatment <- mean(treatment$choice)
mean_control <- mean(control$choice)
cat("Treatment group purchase rate:", mean_treatment, "\n")
cat("Control group purchase rate:", mean_control, "\n")

# 3. b) Simple linear regression
reg_model <- lm(choice ~ ad, data = katespade)
summary(reg_model)

# Step 1: Count treatment group users
n_treat <- nrow(treatment)

# Step 2: Purchase rates
rate_treat <- mean(treatment$choice)
rate_control <- mean(control$choice)

# Step 3: Lift
lift <- rate_treat - rate_control

# Step 4: Incremental purchases and revenue, remove uneeded variables from Environment
extra_purchases <- lift * n_treat
rm(lift, n_treat)
incremental_revenue <- extra_purchases * 40
rm(extra_purchases)

# Output
cat("Incremental revenue from ad campaign: $", round(incremental_revenue, 2), "\n")


# 4. Cost of ad-campaign
# Step 1: Count number of treatment and control impressions (the total times each were shown an ad)
total_impressions <- sum(treatment$num_impressions) + sum(control$num_impressions)

# Step 2: Multiply by .009 and ouput to console
total_cost = total_impressions * .009
cat("Total cost of test campaign: ", total_cost)


# 5. ROI on ad campaign
# Step1: Subtract the revenue from ads from the cost of the ads
negative_cost_of_ads = incremental_revenue - total_cost
cat(negative_cost_of_ads)

# Step 2: Divide result by cost
ROI = negative_cost_of_ads / total_cost
cat(round(ROI,4))


# 6. Cost of the control group
# Step 1: Determine the number of members in control group
n_control = nrow(control)

# Step 2: Use rate_treat to estimate how many purchases we would get if control was shown ad
extra_purchases_control = n_control * rate_treat

# Step 3: Calculate additional revenue and output
extra_revenue = extra_purchases_control * 40
cat(extra_revenue)
