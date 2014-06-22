+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
This submission is the code, data for the project of "Getting and Cleaning Data" course offered through Coursera

This demonstrates an ability to collect, work with, and clean a data set. 
A tidy data set that can be used for later analysis is the result.

Submitted by - Sastry Penumarthy, Submission date - 6/22/2014
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This file describes the variables, the data, and the transformations performed by me to clean up the data. IT explains how 
the run_analysis.R script works to generate the Tidy data file

Script name - run_analysis.R - Creates a Tidy data set from a set of data files

Data file location -
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Other information -
1. README.md - Provides information on how the run_analysis.R script works
2. CodeBook.md - Describes the variables, data and transformations 
                 for obtaining the tidy data file from the raw data files
Objective - Generate a independent tidy data set with the average of each variable for each activity and each subject
Input - Zip file containing the data
output - Text file containing the tidy data set of averages of a set of 86 variables for 6 activities and 30 subjects
The following steps identify the processing steps to arrive at the final tidy data file -
Step 1 - Download the Zip file to data folder - check if data folder exists
The existence of the data folder in the current working directory is ensured first, if it does not exist it is created

Step 2 - Download the Zip file to local "data" folder
Location of the Zip data file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The download.file() function is used for this purpose that uses the source file and the folder where it needs to be downloaded to
as the parameters to download it to a local folder

Step 3 - Extract the files present in the Zip file
The unzip() function is used next to extract the zip file contents

Step 4 - Load the data files into R data frames
File Variable used		Original Data file from zip file
xTrain				X_train.txt			
xTest				X_test.txt
yTrain				y_train.txt
yTest				y_test.txt
features			features.txt
sTrain				subject_train.txt
sTest				subject_test.txt
activities			activity_labels.txt

Step 5 - Merge the training and test data sets to create one data set. The following sub-steps are involved in doing this.
Step 5.0 - Rename the columns of the "activities" data frame to "activityId","activityName", to have a more descriptive context
           and to make the future merge more clear in terms of the variable names specified
Step 5.1 - rbind xTrain and xTest (Create a single data frame for the Train and Test data called "xTrainTest")
Step 5.2 - rbind yTrain and yTest, change the column name to "activities" (Create a single data frame for the activities data and
           change the name of the column to "activities" to avoid a conflict with the already present "V1" column when this will be 	

	   added as an additional column to the data set) into yTrainTest
Step 5.3 - cbind xTrainTest and yTrainTest into a single data frame called "xyTrainTest"
Step 5.4 - rbind sTrain and sTest, change the column name to "subject" - sTrainTest 
Step 5.5 - cbind xyTrainTest and sTrainTest into a single data frame called "xysTrainTest"
xysTrainTest is the combined data set on which the data transformation are applied

Step 6 - Get all Mean and Standard deviation columns from features data
Regular expression for extracting this - "[Ss]td|[Mm]ean"
The column IDs and the corresponding names in the features data are stored in the reqdCols data frame that is created by subsetting 

the features data frame for the specific rows and columns using the specified regular expression

Step 7 - A new data frame - dataSet - is created from the combined data set - xysTrainTest - and has only the Mean and Standard 

deviation columns (and corresponding row data) from the combined data set including the activities and subject columns (and data)

Step 8 - Descriptive activity names (From activities data) are added to the "dataSet" data frame through a left outer join with the 

activities data frame. The "Activities" column that had just the activity numbers is removed from the resulting data frame as well.
The merge (using the merge() function) is a match between the "Activities" column in dataSet data frame and the "activityId" column 

from the activities data frame and a left outer join to get the descriptive activity names for all entries

Step 9 - The Mean and Standard deviation columns are renamed to more descriptive names (identified by - "newColNames" variable)
The following names were used for the descriptive context of the columns in the data set. These names were manually created from the 

columns in the "features" file by removing special characters - "(", ")", "-", "," -- (Braces, hyphen, comma) from the names for the 

86 columns that represented Mean and Std
New descriptive names used for the Mean and standard deviation in the data frame dataSet are as follows -
		("tBodyAccmeanX",
                 "tBodyAccmeanY",
                 "tBodyAccmeanZ",
                 "tBodyAccstdX",
                 "tBodyAccstdY",
                 "tBodyAccstdZ",
                 "tGravityAccmeanX",
                 "tGravityAccmeanY",
                 "tGravityAccmeanZ",
                 "tGravityAccstdX",
                 "tGravityAccstdY",
                 "tGravityAccstdZ",
                 "tBodyAccJerkmeanX",
                 "tBodyAccJerkmeanY",
                 "tBodyAccJerkmeanZ",
                 "tBodyAccJerkstdX",
                 "tBodyAccJerkstdY",
                 "tBodyAccJerkstdZ",
                 "tBodyGyromeanX",
                 "tBodyGyromeanY",
                 "tBodyGyromeanZ",
                 "tBodyGyrostdX",
                 "tBodyGyrostdY",
                 "tBodyGyrostdZ",
                 "tBodyGyroJerkmeanX",
                 "tBodyGyroJerkmeanY",
                 "tBodyGyroJerkmeanZ",
                 "tBodyGyroJerkstdX",
                 "tBodyGyroJerkstdY",
                 "tBodyGyroJerkstdZ",
                 "tBodyAccMagmean",
                 "tBodyAccMagstd",
                 "tGravityAccMagmean",
                 "tGravityAccMagstd",
                 "tBodyAccJerkMagmean",
                 "tBodyAccJerkMagstd",
                 "tBodyGyroMagmean",
                 "tBodyGyroMagstd",
                 "tBodyGyroJerkMagmean",
                 "tBodyGyroJerkMagstd",
                 "fBodyAccmeanX",
                 "fBodyAccmeanY",
                 "fBodyAccmeanZ",
                 "fBodyAccstdX",
                 "fBodyAccstdY",
                 "fBodyAccstdZ",
                 "fBodyAccmeanFreqX",
                 "fBodyAccmeanFreqY",
                 "fBodyAccmeanFreqZ",
                 "fBodyAccJerkmeanX",
                 "fBodyAccJerkmeanY",
                 "fBodyAccJerkmeanZ",
                 "fBodyAccJerkstdX",
                 "fBodyAccJerkstdY",
                 "fBodyAccJerkstdZ",
                 "fBodyAccJerkmeanFreqX",
                 "fBodyAccJerkmeanFreqY",
                 "fBodyAccJerkmeanFreqZ",
                 "fBodyGyromeanX",
                 "fBodyGyromeanY",
                 "fBodyGyromeanZ",
                 "fBodyGyrostdX",
                 "fBodyGyrostdY",
                 "fBodyGyrostdZ",
                 "fBodyGyromeanFreqX",
                 "fBodyGyromeanFreqY",
                 "fBodyGyromeanFreqZ",
                 "fBodyAccMagmean",
                 "fBodyAccMagstd",
                 "fBodyAccMagmeanFreq",
                 "fBodyBodyAccJerkMagmean",
                 "fBodyBodyAccJerkMagstd",
                 "fBodyBodyAccJerkMagmeanFreq",
                 "fBodyBodyGyroMagmean",
                 "fBodyBodyGyroMagstd",
                 "fBodyBodyGyroMagmeanFreq",
                 "fBodyBodyGyroJerkMagmean",
                 "fBodyBodyGyroJerkMagstd",
                 "fBodyBodyGyroJerkMagmeanFreq",
                 "angletBodyAccMeangravity",
                 "angletBodyAccJerkMeangravityMean",
                 "angletBodyGyroMeangravityMean",
                 "angletBodyGyroJerkMeangravityMean",
                 "angleXgravityMean",
                 "angleYgravityMean",
                 "angleZgravityMean",
                 "subject",
                 "activityName")
The column names are updated using the "names() <- newColNames" construct by iterating over the names and assigning the corresponding 

name from the new names listed above. There are a total of 88 - 86 (New descriptions) + 2 (One for subject and one for activity 

description) - in the resulting dataSet data frame

Step 10 - the data in the dataSet data frame is written out to a text file (Named "TidyData.txt")using the "write.file()" function. 
It has 10299 rows and 88 columns

Step 11 - Next, the average of each variable for each activity and each subject is computed and the results stored in a new data 

frame called "MeanData". This results in a data frame of 180 (30 subjects x 6 activities) and 88 columns (Mean values of 86 data 

variables + one for activity and one for subject)
The means of the variables by Activity and by subject is computed using the "aggregate()" function

Step 12 - The MeanData data frame containing the mean values by  computed
The data set (Named "FinalData.txt") is written out to a text file using the "write.file()" function. It has 180 rows and 88 columns
This is the file that has been submitted as the Tidy Data file
