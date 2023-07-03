# How Can a Wellness Technology Play it Smart

![Alt Text](https://github.com/quirozfm/Bellabeat-Case-Study/blob/main/Bellabeatlogo.png)

[Follow Along Presentation](Bellabeatppt.pdf)

I. Executive Summary

Bellabeat, a high-tech manufacturer specializing in health-focused products for women, aims to better understand its customers' behavior through the analysis of smart device usage data. Through this understanding, Bellabeat seeks to enhance its marketing strategies and product development. This case study leverages the data from fitness trackers like Fitbit and Bellabeat's Leaf wellness tracker, focusing on metrics such as activity, sleep, and stress.

II. Ask

The key business question we aim to answer is: How are consumers using Bellabeat's smart devices, and what insights can we gather about their health patterns?

III. Prepare

We used the Fitbit Fitness Tracker dataset and data from Bellabeat's devices. The dataset includes measures of physical activity, sleep quality, and heart rate. These data are considered reliable, as they come directly from users' trackers, making it a firsthand source. 
[Download archive.zip](https://github.com/quirozfm/Bellabeat-Case-Study/blob/main/archive.zip)

R.

    install.packages("here")
    library(here)
    install.packages("skimr")
    library(skimr)
    install.packages(tidyverse)
    library(tidyverse)
    install.packages("dplyer")
    library(dplyer)
    install.packages("janitor")
    library(janitor)
    library(readr)
    
    Your Choosing <-read_csv("Your File.csv")
    
    
    
  
IV. Process

We performed thorough data cleaning, ensuring the data was suitable for analysis. For the particular data we were interested in we did not have to deal with missing variables or duplicates. We did however, have to create an index for ease of plotting. 

a. Boxplot
The first graph is a boxplot that showcases the distribution of different types of activities (Very Active, Fairly Active, Lightly Active, and Sedentary). This plot was chosen because it provides a visual summary of multiple aspects of the distribution of a dataset, including the median, quartiles, outliers, and overall spread of the data. This helps to understand how much time users typically spend in each activity level, which is crucial in knowing their preferences and habits.

b. Scatterplot of Total Activity Minutes and Calories Burned

The second graph is a scatterplot showing the relationship between the total active minutes and the calories burned by the users. It also includes a line of best fit to make the relationship clearer. This plot was chosen as it gives a visual representation of the correlation between the two variables. If there's a strong relationship, this could be key in understanding how activity levels affect calorie burn, which could be useful information for users aiming for weight loss or maintenance.

c. Barplot of Average Time in Bed and Time Asleep

The third graph is a barplot comparing the average time users spend in bed and the actual time they are asleep. This graph was chosen because it helps understand the sleep patterns of users - how long they are spending in bed versus how much of that time is spent asleep. This could provide insights into potential issues such as difficulty falling asleep or staying asleep, which could be areas Bellabeat might want to address in their products or services.
~~~
colnames(GreatValueFitbit)

skim_without_charts(GreatValueFitbit)
    
Activity_Distribution <- subset(GreatValueFitbit, select = c("VeryActiveMinutes", "FairlyActiveMinutes", "LightlyActiveMinutes", "SedentaryMinutes"))
summary_Activity_Distribution <- summary(Activity_Distribution)
print(summary_Activity_Distribution)
# Melt the dataframe to long format for plotting
Activity_Distribution_long <- Activity_Distribution %>%
  pivot_longer(cols = everything(), names_to = "ActivityType", values_to = "Minutes")

ggplot(Activity_Distribution_long, aes(x = ActivityType, y = Minutes)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Activity Distribution", x = "Activity Type", y = "Minutes")

GreatValueFitbit$TotalActiveMinutes <- GreatValueFitbit$VeryActiveMinutes + GreatValueFitbit$FairlyActiveMinutes + GreatValueFitbit$LightlyActiveMinutes

ggplot(GreatValueFitbit, aes(x = TotalActiveMinutes, y = Calories)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relationship between Activity and Calorie Burn", x = "Total Active Minutes", y = "Calories Burned")

TotalActiveMinutes <- subset (GreatValueFitbit, select = c(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes,Calories))
str(TotalActiveMinutes)

sleep_data <- read.csv("F:/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")
sleep <- subset(sleep_data, select =c(TotalTimeInBed, TotalTimeAsleep)
summary(sleep)

sleep_data$Index <- seq.int(nrow(sleep_data))

sleep_data <- tail(sleep_data, 30) 
          
avg_sleep_data <- sleep_data %>%
group_by(Index) %>%
summarise(AverageTimeInBed = mean(TotalTimeInBed),
AverageMinutesAsleep = mean(TotalMinutesAsleep))               

ggplot(avg_sleep_data, aes(x = factor(Index))) +
  geom_bar(aes(y = AverageTimeInBed), stat = "identity", fill = "darkblue", alpha = 0.7, width = 0.4, position = 'dodge') +
  geom_bar(aes(y = AverageMinutesAsleep), stat = "identity", fill = "darkgreen", alpha = 0.7, width = 0.4, position = 'dodge') +
  labs(x = "Index", y = "Average Time (minutes)",
title = "Comparison of Average Time in Bed and Time Asleep") +
theme_minimal()               

~~~
    
V. Analyze

Activity Levels:

We found a strong correlation between physical activity and the calories burned, indicating that as physical activity increased, so did the calories burned. Notably, the majority of users were more lightly active or sedentary. We also found that 'Very Active Minutes' tend to be less common, suggesting that most users are not involved in intense workouts regularly.

![Alt Text](https://github.com/quirozfm/Bellabeat-Case-Study/blob/main/Activity%20Distribution%20Box.jpeg) ![Alt Text](https://github.com/quirozfm/Bellabeat-Case-Study/blob/main/Activity%20Index%20%20scaled.jpeg)
![Alt Text](https://github.com/quirozfm/Bellabeat-Case-Study/blob/main/Activity%20vs%20Calorie%20Burn%20Scatter.jpeg)

Sleep Patterns:

Our analysis showed that users often get less than the recommended 7-9 hours of sleep per night. This lack of sleep can influence overall fitness, energy levels, and other aspects of daily life.
![Alt Text](https://github.com/quirozfm/Bellabeat-Case-Study/blob/main/avgSleepOverTime.jpeg)
![Alt Text](https://github.com/quirozfm/Bellabeat-Case-Study/blob/main/Sleep%20over%20time.jpeg)

VI. Share

Based on our findings, we would recommend the following strategies:

Promote Active Lifestyle: Our analysis indicates that many users fall into the lightly active or sedentary category. We suggest promoting an active lifestyle with features encouraging movement throughout the day. For example, we could add reminders to stand up or walk around every hour.

Sleep Education: We suggest launching an educational campaign about the importance of sleep for overall health. This campaign can include sleep hygiene tips, benefits of good sleep, and a comparison of users' current sleep patterns with recommended standards.

Enhanced Features: Developing features that allow users to set sleep and activity goals could foster engagement. A reward system for achieving these goals can serve as motivation for users to lead a healthier lifestyle.

VII. Act

Our next steps involve implementing the proposed product features and marketing strategies. We should continue monitoring user data to assess the impact of these changes and adapt our strategies accordingly. Additionally, further analysis could explore correlations between sleep data and other data from the tracker, such as physical activity or heart rate.

VIII. Further Data Exploration

Further, it could be beneficial to collect additional user information like dietary habits, stress levels, and health history. This data could help us understand our users better and guide more personalized product features and marketing strategies. 
