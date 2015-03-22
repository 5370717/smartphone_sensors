# smartphone_sensors
Getting and Cleaning Data Course Project

### Explanation of the file smartphone_sensor_data.txt

This data set was obtained by processing raw data set of smartphone sensors.
Initial set contained herein https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
This set consists of two sets of test and train.
For processing applied R version 3.1.3, RStudio Version 0.98.1091, and packages dplyr, stringr and tidyr.


The algorithm of data processing is:
  1.Merges the training and the test sets to create one data set;
  2.Extracts only the measurements on the mean and standard deviation for each measurement;
  3.Uses descriptive activity names to name the activities in the data set;
  4.Appropriately labels the data set with descriptive variable names;
  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
The script is in the file run_analysis.R

