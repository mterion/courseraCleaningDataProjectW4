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

# Merge both dataSets
        mergedDf <- rbind(trainMerged, testMerged)
        rm(trainMerged, testMerged)
        
        mergedDf <- mergedDf %>%
                mutate(id = as.numeric(rownames(mergedDf))) %>%
                mutate(set=as.factor(set), activities=as.factor(activities), subject=as.factor(subject)) %>%
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

# Save dataframe
        save(codebook_data, file="./data/finalData/tidyMergedTrainTestDf")
        #load("./data/finalData/tidyMergedTrainTestDf")


