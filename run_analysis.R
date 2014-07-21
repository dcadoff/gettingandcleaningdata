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

trainsubjects <- read.table("./train/subject_train.txt")
testsubjects <- read.table("./test/subject_test.txt")

## Add column names to raw data tables
names(xtrainrawdata) <- columnnames[,2]
names(xtestrawdata) <- columnnames[,2]

#combinetestsubjectandactivity <- cbind(testsubjects, ytestrawdata)
#combinetrainsubjectandactivity <- cbind(trainsubjects, ytrainrawdata)

#alltraindata <- cbind(combinetrainsubjectandactivity, xtrainrawdata)
#alltestdata <- cbind(combinetestsubjectandactivity, xtestrawdata)

#colnames(alltraindata)[1] <- "Subject"
#colnames(alltraindata)[2] <- "Activity Type"
#colnames(alltestdata)[1] <- "Subject"
#colnames(alltestdata)[2] <- "Activity Type"

combinerawdata <- rbind(xtrainrawdata, xtestrawdata)

subsetdata <- grep("[sS]td|[mM]ean", colnames(combinerawdata))

cleandata <- combinerawdata[,subsetdata]

combinetestsubjectandactivity <- cbind(testsubjects, ytestrawdata)
combinetrainsubjectandactivity <- cbind(trainsubjects, ytrainrawdata)

subjectactivity <- rbind(combinetrainsubjectandactivity, combinetestsubjectandactivity)
colnames(subjectactivity)[1] <- "Subject"
colnames(subjectactivity)[2] <- "Activity Type"

finalrawdata <- cbind(subjectactivity, cleandata)
