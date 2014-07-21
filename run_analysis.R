## This script does the following:
## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names. 
## 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## WARNING: Script and data need to be in the same working directory to run properly!  Data needs to
## retain the same sub-directories, too.

## Load raw data into data tables
        xtrainrawdata <- read.table("./train/X_train.txt")
        ytrainrawdata <- read.table("./train/y_train.txt")
        xtestrawdata <- read.table("./test/X_test.txt")
        ytestrawdata <- read.table("./test/y_test.txt")

## Load column variable names and activity labels
        columnnames <- read.table("features.txt")
        activities <- read.table("activity_labels.txt")

## Load subject IDs
        trainsubjects <- read.table("./train/subject_train.txt")
        testsubjects <- read.table("./test/subject_test.txt")

## Add column names to raw data tables
        names(xtrainrawdata) <- columnnames[,2]
        names(xtestrawdata) <- columnnames[,2]

## Combine training and test data sets
        combinerawdata <- rbind(xtrainrawdata, xtestrawdata)

## Subset by Mean and Standard Deviation
        subsetdata <- grep("[sS]td|-[mM]ean", colnames(combinerawdata))
        cleandata <- combinerawdata[,subsetdata]

## Drop meanFreq from remaining data; Mean Frequency is a weighted average not a standard mean
        subsetdata <- grep("Freq", colnames(cleandata), invert = TRUE)
        cleandata <- cleandata[,subsetdata]

## Create subject and activity data set
        combinetestsubjectandactivity <- cbind(testsubjects, ytestrawdata)
        combinetrainsubjectandactivity <- cbind(trainsubjects, ytrainrawdata)
        subjectactivity <- rbind(combinetrainsubjectandactivity, combinetestsubjectandactivity)

## Add column names for subject and activity       
        colnames(subjectactivity)[1] <- "Subject"
        colnames(subjectactivity)[2] <- "ActivityType"

## Creat tidy variable names
        colnames2 <- colnames(cleandata)
        colnames2 <- sub("-X", "Xaxis", colnames2)
        colnames2 <- sub("-Y", "Yaxis", colnames2)
        colnames2 <- sub("-Z", "Zaxis", colnames2)
        colnames2 <- sub("\\(\\)", "", colnames2)
        colnames2 <- sub("-mean()", "Mean", colnames2)
        colnames2 <- sub("-std", "StandardDeviation", colnames2)
        colnames2 <- sub("^f", "FrequencySignal", colnames2)
        colnames2 <- sub("^t", "TimeSignal", colnames2)
        colnames2 <- sub("Acc", "Acceleration", colnames2)
        colnames2 <- sub("Mag", "Magnitude", colnames2)
        colnames2 <- sub("Gyro", "Gyroscope", colnames2)

## Add tidy variable names to cleaned data set
        names(cleandata) <- colnames2

## Combine subject, activity and cleaned data set
        finalrawdata <- cbind(subjectactivity, cleandata)

## Merge activity labels with combined data set
## Note: merging adds an extra column that needs to be deleted; Also, changes the order of the columns
## which needs to be restored. Finally, Activity column name needs to be restored.
        
        finalrawdata <- merge(activities, finalrawdata, by.y = "ActivityType", by.x = "V1")
        finalrawdata$V1 <- NULL
        finalrawdata <- finalrawdata[c(2,1,3:68)]
        colnames(finalrawdata)[2] <- "ActivityType"

#Sort data set by Subject then by Activity Type
        sorteddata <- finalrawdata[with(finalrawdata, order(finalrawdata[,1], finalrawdata[,2])), ]

## Aggregate data set by Subject and Activity.  Find mean of each aggregated subset.
        aggregatemean <- aggregate(sorteddata[, 3:68], by = list(sorteddata$Subject, sorteddata$ActivityType), FUN = mean)
        colnames(aggregatemean)[1:2] <- c("Subject", "Activity")

## Write tidy data set to text file
        write.table(aggregatemean, "tidy_data.txt", row.names = FALSE)


