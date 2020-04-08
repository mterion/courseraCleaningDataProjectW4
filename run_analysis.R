#Run Analysis

#-------------------------------------------------------------------------------------------------------------------------------------
#Extract - merge and create data frame
#------------------------------------------------------------------------------------------------------------------------------------



#1)ImportData
        library(dplyr)
        library(labelled)
        
        #TrainDataSet
                #Extract
                trainSet <- read.table("./data/sourceData/train/X_train.txt", header = FALSE)
                trainLab <- read.table("./data/sourceData/train/y_train.txt", header = FALSE)
                trainSubj <- read.table("./data/sourceData/train/subject_train.txt", header = FALSE)
                
                #Clean
                trainSet <- trainSet %>%
                        mutate(id = rownames(trainSet)) %>%
                        select(id, V1:V561)
                
                trainLab <- trainLab %>%
                        mutate(id = rownames(trainLab)) %>%
                        rename(activities = V1) %>%
                        select(id, activities)
                
                trainSubj <- trainSubj %>%
                        mutate(id = rownames(trainSubj)) %>%
                        rename(subject = V1) %>%
                        select(id, subject)

                #Merge
                trainMerged <- full_join(trainSet, trainLab, by = "id") %>%
                        full_join(trainSubj, by = "id") %>%
                        mutate(set = 1) %>%
                        select(set, activities, subject, V1:V561)
                
                #Delete unused DataFrames
                rm(trainSet, trainLab, trainSubj)

        #TestDataSet
                #Extract
                testSet <- read.table("./data/sourceData/test/X_test.txt", header = FALSE)
                testLab <- read.table("./data/sourceData/test/y_test.txt", header = FALSE)
                testSubj <- read.table("./data/sourceData/test/subject_test.txt", header = FALSE)
                
                #Clean
                testSet <- testSet %>%
                        mutate(id = rownames(testSet)) %>%
                        select(id, V1:V561)
                
                testLab <- testLab %>%
                        mutate(id = rownames(testLab)) %>%
                        rename(activities = V1) %>%
                        select(id, activities)
                
                testSubj <- testSubj %>%
                        mutate(id = rownames(testSubj)) %>%
                        rename(subject = V1) %>%
                        select(id, subject)
                
                #Merge
                testMerged <- full_join(testSet, testLab, by = "id") %>%
                        full_join(testSubj, by = "id") %>%
                        mutate(set = 2) %>%
                        select(set, activities, subject, V1:V561)
                
                #Delete unused DataFrames
                rm(testSet, testLab, testSubj)

                
#2) Merge both dataSets
                mergedDf <- rbind(trainMerged, testMerged)
                rm(trainMerged, testMerged)
        
                mergedDf <- mergedDf %>%
                        mutate(id = as.numeric(rownames(mergedDf))) %>%
                        mutate(set=as.factor(set), activities=as.factor(activities), subject=as.factor(subject)) %>%
                        select(id, set, subject, activities:V561) 

                
# 3) Dict creation: data frame with two columns for labeling variables + values
                #1st column = variable names
                #2nd colun = variable value
                library(codebook)
                library(labelled)
                library(dplyr)  #To reshape the imported dict df into a list
                
                #Create a df on the base of the variable names of the merged file
                variable <- names(mergedDf)
                varDf <- as.data.frame(variable) %>%
                        mutate(labelGroupOr = if_else((between(row_number(), 1, 4)),TRUE, FALSE))
                
                #labels : create 2 character vectors
                lab1 <- c(NA,NA,NA,NA) # Label name suppressed because identicalto var name = looking bad in codebook df 
                lab2 <- read.table("./data/sourceData/features.txt", header = FALSE) %>%
                        pull(V2) %>%
                        as.character()
                
                labelDf1 <- varDf %>%
                        mutate(label = NA, valueLabels = NA) %>%
                        filter(labelGroupOr == TRUE) %>%
                        mutate(label = lab1)
                
                labelDf2 <- varDf %>%
                        mutate(label = NA, valueLabels = NA) %>%
                        filter(labelGroupOr == FALSE) %>%
                        mutate(label = lab2)
                
                labelMergedDf <- rbind(labelDf1, labelDf2) %>%
                        mutate(variable = as.character(variable)) %>%
                        select(-(labelGroupOr))
                
                rm(labelDf1,labelDf2, lab1, lab2, variable, varDf)
                
#3) Labelling

                # Value Labels
                labVal <- read.table("./data/sourceData/activity_labels.txt", header = FALSE) %>%
                        pull(V2) %>%
                        as.character()
                
                #Create just a string of label to be later integrated into the dict valueLabel col
                labelString <- as.character()
                r = 1
                for(i in labVal) {
                        labelString <- paste(labelString,r, i)
                        r = r+1
                }
                
                labelString <- tolower(labelString)
                
                #integrate value label into dict
                labelMergedDf [1,3] <- "Observation id number" # id
                labelMergedDf [2,3] <- "1 training 2 set" # set : 1 = training, 2 = test
                labelMergedDf [3,3] <- labelString
                labelMergedDf [4,3] <- "Subject id number"
                rm(labVal,i,r, labelString)
                
                
                #Labels : Variables
                # Dict : Import
                codebook_data <- mergedDf; rm(mergedDf)
                dict <- labelMergedDf; rm(labelMergedDf)
                
                #df expected => 2 col df : 1st col var name, 2nd col var labels / use dplyr
                var_label(codebook_data) <- dict %>%
                        select(variable, label) %>%
                        dict_to_list()  # will make a list to be used as label which requires list format
                
                #Labels : Values
                labVal <- read.table("./data/sourceData/activity_labels.txt", header = FALSE) %>%
                        pull(V2) %>%
                        as.character() %>%
                        tolower()
                
                labVal <- sub("_", " ", labVal)
                
                codebook_data$activities <- factor(codebook_data$activities, levels = c(1,2,3,4,5,6), labels= labVal)
                
                codebook_data$set <- factor(codebook_data$set, levels = c(1,2), labels = c("train", "test"))
                rm(labVal)

                
#4) Save dataframe
                save(codebook_data, file="./data/finalData/tidyMergedTrainTestDf")
                rm(dict)


#-------------------------------------------------------------------------------------------------------------------------------------
# QUESTIONS
#-----------------------------------------------------------------------------------------------------------------------------------------

                
#Question 1:
                
        #Merges the training and the test sets to create one data set.
        df <- codebook_data; rm(codebook_data)

# Result recorded in the data frame name df

#----------------
                
                
#Question2:
                
        #Extracts only the measurements on the mean and standard deviation for each measurement.
                # Given the fact that I am using labels for variable to keep the name of variable simple to work with
                # I had to do the following process to extract only the variables with label mean() and std()
        
        # Make a logical vector
        meanStdVect <- grepl("mean[:():]", var_label(df)) | grepl("std[:():]", var_label(df))
        
        # Make a variable names vector
        varNameVect <- names(df)
        
        # Create with both a dataframe and filter rows based on TRUE
        targetDf <- data.frame(varNameVect, meanStdVect) %>%
                filter(meanStdVect == TRUE)
        
        # Create a variable name vector out of this data frame
        targetVar <- targetDf$varNameVect
        
        # Filter the main dataset with the help of the variable name vector
        dfMeanStd <- df %>%
                select(id:activities, targetVar)

        # Result recorded in the data frame named dfMeanStd
        save(dfMeanStd, file="./data/finalData/dfMeanStd")
        rm(targetVar, varNameVect, meanStdVect, targetDf)
        
        
        

        
        
#----------------

                       
#Question3 + 4:
        # Uses descriptive activity names to name the activities in the data set
        # -> Already done in previous stages -> the data frame df is cleaned with descriptive activity names and labels attached to each variable

#----------------

        
#Question5:
        # From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        dfAver <- dfMeanStd %>%
                group_by_at(vars(activities, subject)) %>%
                summarise_at(vars(V1:V543), mean, na.rm=TRUE) %>%
                copy_labels_from(dfMeanStd) %>%     # Need this, bec if not, dplyr will drop labels
                arrange(subject, activities) %>%
                select(subject, activities, V1:V543)
        
        save(dfAver, file="./data/finalData/dfAver")
        
       
        #TXT Format:
        # The export in TXT format do not keep variable labels
                # Therefore, variable labels were copied as variable label (Column names in the data frame) 
        
        labelsVect <- dfAver %>%
                copy_labels_from(dfMeanStd) %>%
                var_label() %>%
                as.character()
        labelsVect[1] <- colnames(dfAver)[1]
        labelsVect[2] <- colnames(dfAver)[2]
        colnames(dfAver) <- labelsVect
        dfAverTXT <- remove_var_label(dfAver)
        
        save(dfAverTXT, file="./data/finalData/dfAverTXT")
        rm(labelsVect)

                
# Write table in TXT
        # txt tab separated is very good to share files as they can easily be opened in excel
        
        write.table(dfAverTXT, "./data/finalData/tidyDatSetStep5.txt",sep="\t",row.names = FALSE)
 
