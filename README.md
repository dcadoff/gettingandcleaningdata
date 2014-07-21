## Readme: Getting and Cleaning Data Course Project
### Script Description:
* This code book desbribes the script **run_analysis.R** script found in this repository.
* The script summarizes data obtained by measuring data from a Samsung Galaxy S II smart phone on the waist.  
* A more detailed description of the data can be found here:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* Experiments were performed with 30 volunteers within an age bracket of 19-48 years.  Each person performed six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* This script averages measurement data for all mean and standard deviation measurements.

### Script Results:
* tidydata.txt - The tidy data set for this project, one record per subject and activity with averages for all test measurements (total of 180 records) in TXT format.  The data set is 180 rows by 68 columns.  66 columns of mean and standard deviation averages and 1 column for subject ID and 1 column for activity type.

### Assumptions:
* The script assumes this data has been downloaded and unzipped into the working directory:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

* I did not keep any meanFreq() or Angle measurements.  I looked for simple, straightfoward means and standard deviation measurements.  That left 66 mean and standard deviation columns in the data set. 

* I used CamelCase for column names. The column names were getting too long to be readable with all lower case.  There were several discussions in the forum, for example: https://class.coursera.org/getdata-005/forum/thread?thread_id=129#post-499, that discussed this issue.  The conclusion seemed to be that the data was tidy if there were no special characters and was human readable.  I believe CamelCase made these extremely long column names human readable.

###Files Used
* /UCI HAR Dataset/features.txt - Gives names for each field of data in the measurement set.
* /UCI HAR Dataset/test/X_test.txt - Actual measurement data for the test data set.
* /UCI HAR Dataset/train/X_train.txt - Actual measurement data for the train data set.
* /UCI HAR Dataset/test/subject_test.txt - Ties each test back to the subject the test was performed on.
* /UCI HAR Dataset/train/subject_train.txt - Ties each test back to the subject the test was performed on.
* /UCI HAR Dataset/test/y_test.txt - Gives an activity number for the measurement.
* /UCI HAR Dataset/train/y_train.txt - Gives an activity number for the measurement.
* /UCI HAR Dataset/activity_labels.txt - Translates activity numbers into descriptions.  
 
### Script Processing Step by Step:

### This script does the following:
####1) Merges the training and the test sets to create one data set.

* Load raw data into data tables

* Load column variable names and activity labels
       
* Load subject IDs

* Add column names to raw data tables

* Combine training and test data sets

####2) Extracts only the measurements on the mean and standard deviation for each measurement.

* Subset by Mean and Standard Deviation

* Drop meanFreq from remaining data; Mean Frequency is a weighted average not a standard mean
        
####3) Uses descriptive activity names to name the activities in the data set

* Tidy up activity data
 
* Create subject and activity data set

* Add column names for subject and activity       

####4) Appropriately labels the data set with descriptive variable names. 

* Create tidy variable names

* Add tidy variable names to cleaned data set
        
* Combine subject, activity and cleaned data set

* Merge activity labels with combined data set
        
####5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

* Sort data set by Subject then by Activity Type

* Aggregate data set by Subject and Activity.  Find mean of each aggregated subset.
        
* Write tidy data set to text file

###Data Dictionary

Code Book for tidydata.txt can be found here: https://github.com/dcadoff/gettingandcleaningdata/blob/master/CodeBook.md
        