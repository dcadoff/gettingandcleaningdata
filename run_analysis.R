## You should create one R script called run_analysis.R that does the following. 
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Script and data need to be in the same working directory to run properly

## Load raw data into data tables
xtrainrawdata <- read.table("./train/X_train.txt")
ytrainrawdata <- read.table("./train/y_train.txt")
xtestrawdata <- read.table("./test/X_test.txt")
ytestrawdata <- read.table("./test/y_test.txt")

columnnames <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

## Add column names to raw data tables
names(xtrainrawdata) <- columnnames[,2]
names(xtestrawdata) <- columnnames[,2]