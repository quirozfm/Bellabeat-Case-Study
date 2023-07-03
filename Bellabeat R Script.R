# II. Ask

#The key business question we aim to answer is: How are consumers using Bellabeat's smart devices, and what insights can we gather about their health patterns?

# III. Prepare

# Load necessary libraries
install.packages(c("here", "skimr", "tidyverse","tidyr", "dplyr", "janitor", "readr","ggplot2"))
library(here)
library(skimr)
library(tidyverse)
library(tidyr)
library(dplyr)
library(janitor)
library(readr)
library(ggplot2)

# Load data
GreatValueFitbit <- read_csv("F:/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")


# Data cleaning and manipulation
colnames(GreatValueFitbit)
skim_without_charts(GreatValueFitbit)

# Selecting required columns
Activity_Distribution <- subset(GreatValueFitbit, select = c("VeryActiveMinutes", "FairlyActiveMinutes", "LightlyActiveMinutes", "SedentaryMinutes"))
summary_Activity_Distribution <- summary(Activity_Distribution)
print(summary_Activity_Distribution)

# Transforming the dataframe to long format for plotting
library(tidyr) # Make sure you have the 'tidyr' package installed for 'pivot_longer'
Activity_Distribution_long <- pivot_longer(Activity_Distribution, cols = everything(), names_to = "ActivityType", values_to = "Minutes")

# Plotting activity distribution
library(ggplot2) # Make sure you have the 'ggplot2' package installed for the 'ggplot' function
ggplot(Activity_Distribution_long, aes(x = ActivityType, y = Minutes)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Activity Distribution", x = "Activity Type", y = "Minutes")

# Calculating total active minutes and plotting its relation with calories
GreatValueFitbit$TotalActiveMinutes <- GreatValueFitbit$VeryActiveMinutes + GreatValueFitbit$FairlyActiveMinutes + GreatValueFitbit$LightlyActiveMinutes
ggplot(GreatValueFitbit, aes(x = TotalActiveMinutes, y = Calories)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relationship between Activity and Calorie Burn", x = "Total Active Minutes", y = "Calories Burned")


# Reading sleep data
sleep_data <- read.csv("F:/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")
# Selecting last 30 rows of the data
sleep_data <- tail(sleep_data, 30) 

# Adding a 'DayIndex' column to the sleep data, assuming that rows are sorted by date
sleep_data$DayIndex <- seq_len(nrow(sleep_data))

# Reshaping the data to long format
sleep_data_long <- pivot_longer(sleep_data, c(TotalTimeInBed, TotalMinutesAsleep), names_to = "SleepMetric", values_to = "Value")

# Plotting average sleep over time
ggplot(sleep_data_long, aes(x = DayIndex, y = Value, fill = SleepMetric)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Average Sleep Over Time", x = "Day", y = "Average Sleep (Minutes)", fill = "Sleep Metric")

## Look into what days of the month peak for sleep.
# Selecting last 30 rows of the data
sleep_data <- tail(sleep_data, 30) 

# Calculating average sleep time in bed and asleep
avg_sleep_data <- sleep_data %>%
  summarise(AverageTimeInBed = mean(TotalTimeInBed),
            AverageMinutesAsleep = mean(TotalMinutesAsleep))
print(avg_sleep_data)

# Adding a 'DayIndex' column to the sleep data, assuming that rows are sorted by date
sleep_data$DayIndex <- seq_len(nrow(sleep_data))

# Calculating daily average sleep time
sleep_data$AvgSleepTime <- (sleep_data$TotalTimeInBed + sleep_data$TotalMinutesAsleep) / 2

# Converting SleepDay column to Date format (assuming it is in 'm/d/yyyy' format)
sleep_data$SleepDay <- as.Date(sleep_data$SleepDay, format = "%m/%d/%Y")

# Plotting average sleep over time
ggplot(sleep_data, aes(x = SleepDay, y = AvgSleepTime)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme_minimal() +
  labs(title = "Average Sleep Over Time", x = "Day", y = "Average Sleep (Minutes)")

