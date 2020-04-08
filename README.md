# Coursera: Cleaning Data Project Week4

## Overview
### Orientation
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

### Mission
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement.
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names.
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data
All data can be found into the data folder data that contains two folder subdivisions *sourceData* and *finalData*

1. *sourceData*
Contains all the original data in format txt

  * A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

  * Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. *finalData*
Contains the final - clean - merged data sets used for the analysis.
  * The *metadataFile* to export or share data and metadata if needed. It contains the tidy data set with all metadata and values attached to it.
  * The same tidy data set, representing the merged train and test set, in the R data frame format.
  * The data set containing only the measurements on the mean and standard deviation, in the R data frame format.
  * The data set containing the average of each variable for each activity and each subject.
  * The same data set as the last one, but in txt format


## Scripts
The following scripts can be run :
1. *run_analysis.R*
* Extract, create and merge to make a tidy data set 
* Continue the analysis to answer each of the 5 quiz questions

2. *extractMergeCreateDf.R* file 
* File used in the codebook creation
* Merge, clean and assign labels to the data set ()
* Do the same cleaning operation as the first part of the run analysis file, but separated due to the request of this exercice to have all code in one file *run_analysis.R*

3. *codebook.Rmd* 
* Call/run the *extractMergeCreateDf.R* file
* Add metadata to the tidy data set
* Create the *metadataFile* to export or share the data and metadata
* Create a clean codebook

## Codebook -> Output
The output folder contains the published codebook in html format html to be displayed in a browser. His name is *codebook.html*.

## Figure
Contains the individual descriptive graphs for each variable. It's just a sample, because uploading all graphs would be too heavy.


