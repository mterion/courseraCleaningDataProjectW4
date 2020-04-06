#Extract - merge and create data frame

#ImportData
library(dplyr)

# TrainDataSet
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
                rename(labels = V1) %>%
                select(id, labels)

        trainSubj <- trainSubj %>%
                mutate(id = rownames(trainSubj)) %>%
                rename(subject = V1) %>%
                select(id, subject)
        
        #Merge
        trainMerged <- full_join(trainSet, trainLab, by = "id") %>%
                full_join(trainSubj, by = "id") %>%
                mutate(set = 1) %>%
                select(set, labels, subject, V1:V561)

        #Delete unused DataFrames
        rm(trainSet, trainLab, trainSubj)

# TestDataSet
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
                rename(labels = V1) %>%
                select(id, labels)
        
        testSubj <- testSubj %>%
                mutate(id = rownames(testSubj)) %>%
                rename(subject = V1) %>%
                select(id, subject)
        
        #Merge
        testMerged <- full_join(testSet, testLab, by = "id") %>%
                full_join(testSubj, by = "id") %>%
                mutate(set = 2) %>%
                select(set, labels, subject, V1:V561)

        #Delete unused DataFrames
        rm(testSet, testLab, testSubj)

# Merge both dataSets
        mergedDf <- rbind(trainMerged, testMerged)
        rm(trainMerged, testMerged)
        
        mergedDf <- mergedDf %>%
                mutate(id = as.numeric(rownames(mergedDf))) %>%
                mutate(set=as.factor(set), labels=as.factor(labels), subject=as.factor(subject)) %>%
                select(id, set:V561) 

# Dict creation: data frame with two columns for labeling variables + values
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
        
         
        
        
        
        