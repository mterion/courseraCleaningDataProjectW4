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
                mutate(set = "training") %>%
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
                mutate(set = "test") %>%
                select(set, labels, subject, V1:V561)

        #Delete unused DataFrames
        rm(testSet, testLab, testSubj)

# Merge both dataSets
        mergedDf <- rbind(trainMerged, testMerged)
        rm(trainMerged, testMerged)
        
        mergedDf <- mergedDf %>%
                mutate(id = as.numeric(rownames(mergedDf))) %>%
                select(id, set:V561)

