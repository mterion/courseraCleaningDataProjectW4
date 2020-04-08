# Codebook -> simple version describing variables

## Information
Description
Dataset name: Human Activity Recognition Using Smartphones Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

## Metadata for search engines
Temporal Coverage: Spring 2013
Spatial Coverage: Online
Citation: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab - Non Linear Complex Systems Laboratory. DITEN - Università degli Studi di Genova.
URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Date published: 2013-04-24
Creator:Emmanuel Clivaz


## Description of the final dataset *tidyDatSetStep5.txt*
This data set contains the average of each variable for each activity and each subject from the Human Activity Recognition Using Smartphones Data Set.

### Description:
Data in dataset contains 180 rows and 70 variables names containing the exact elements of either mean() or std()
  
The whole data set has been grouped by 
  *subject
  *activities
to give the average of each variable for each subject and activity

**Subject**
The ID of the test subject numbered sequentially from 1 to 30

 **Activity**:
The type of activity performed when the measurements were taken. The activities column has  6 types of activies : 
1. Walking
1. Walking_Upstairs
1. Walking_Downstairs
1. Sitting
1. Standing
1. Laying
  
**Measurements** 
"tBodyAcc-mean()-X"	
"tBodyAcc-mean()-Y"	
"tBodyAcc-mean()-Z"	
"tBodyAcc-std()-X"	
"tBodyAcc-std()-Y"	
"tBodyAcc-std()-Z"	
"tGravityAcc-mean()-X"	
"tGravityAcc-mean()-Y"	
"tGravityAcc-mean()-Z"	
"tGravityAcc-std()-X"	
"tGravityAcc-std()-Y"	
"tGravityAcc-std()-Z"	
"tBodyAccJerk-mean()-X"	
"tBodyAccJerk-mean()-Y"	
"tBodyAccJerk-mean()-Z"	
"tBodyAccJerk-std()-X"	
"tBodyAccJerk-std()-Y"	
"tBodyAccJerk-std()-Z"	
"tBodyGyro-mean()-X"	
"tBodyGyro-mean()-Y"	
"tBodyGyro-mean()-Z"	
"tBodyGyro-std()-X"	
"tBodyGyro-std()-Y"	
"tBodyGyro-std()-Z"	
"tBodyGyroJerk-mean()-X"	
"tBodyGyroJerk-mean()-Y"	
"tBodyGyroJerk-mean()-Z"	
"tBodyGyroJerk-std()-X"	
"tBodyGyroJerk-std()-Y"	
"tBodyGyroJerk-std()-Z"	
"tBodyAccMag-mean()"	
"tBodyAccMag-std()"	
"tGravityAccMag-mean()"	
"tGravityAccMag-std()"	
"tBodyAccJerkMag-mean()"	
"tBodyAccJerkMag-std()"	
"tBodyGyroMag-mean()"	
"tBodyGyroMag-std()"	
"tBodyGyroJerkMag-mean()"	
"tBodyGyroJerkMag-std()"	
"fBodyAcc-mean()-X"	
"fBodyAcc-mean()-Y"	
"fBodyAcc-mean()-Z"	
"fBodyAcc-std()-X"	
"fBodyAcc-std()-Y"	
"fBodyAcc-std()-Z"	
"fBodyAccJerk-mean()-X"	
"fBodyAccJerk-mean()-Y"	
"fBodyAccJerk-mean()-Z"	
"fBodyAccJerk-std()-X"	
"fBodyAccJerk-std()-Y"	
"fBodyAccJerk-std()-Z"	
"fBodyGyro-mean()-X"	
"fBodyGyro-mean()-Y"	
"fBodyGyro-mean()-Z"	
"fBodyGyro-std()-X"	
"fBodyGyro-std()-Y"	
"fBodyGyro-std()-Z"	
"fBodyAccMag-mean()"	
"fBodyAccMag-std()"	
"fBodyBodyAccJerkMag-mean()"	
"fBodyBodyAccJerkMag-std()"	
"fBodyBodyGyroMag-mean()"	
"fBodyBodyGyroMag-std()"	
"fBodyBodyGyroJerkMag-mean()"	
"fBodyBodyGyroJerkMag-std()"