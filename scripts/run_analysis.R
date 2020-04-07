#Run Analysis

#Question 1:
        #Merges the training and the test sets to create one data set.
        rm(list = ls())
        source("./scripts/extractMergeCreateDf.R")
        df <- codebook_data; rm(codebook_data)

#Question2:
        #Extracts only the measurements on the mean and standard deviation for each measurement.
        library(labelled)
        target <- look_for(df, "mean", "std")
        targetVar <- target$variable
        
        dfMeanStd <- df %>%
                select(id:subject, targetVar)
        save(dfMeanStd, file="./data/finalData/dfMeanStd")
        rm(target, targetVar)
        
#Question3 + 4:
        # Uses descriptive activity names to name the activities in the data set
        # -> Already done at question 1

#Question5:
        # From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        dfAver <- dfMeanStd %>%
                group_by_at(vars(activities, subject)) %>%
                summarise_at(vars(V1:V561), mean, na.rm=TRUE) %>%
                copy_labels_from(dfMeanStd)     # Need this, bec if not, dplyr will drop labels
        
        save(dfAver, file="./data/finalData/dfAver")
        