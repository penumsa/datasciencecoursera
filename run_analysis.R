## run_analysis.R script - Creates a Tidy data set from a set of data files
## Data file location -
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Other information -
## 1. README.md - Provides information on how the run_analysis.R script works
## 2. CodeBook.md - Describes the variables, data and transformations 
##                  for obtaining the tidy data file from the raw data files
## 
## Step 1 - Download the Zip file to data folder - check if data folder exists
if (!file.exists("data")) {
  dir.create("data")
} else {
  print("Folder data exists!")
}

## Step 2 - Download the Zip file to local "data" folder
##fileURL <- c("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
##download.file(fileURL, destfile = ".\\data\\dataset.zip")

## Step 3 - Extract the files present in the Zip file
## zipFile <- c(".\\data\\dataset.zip")
## unzip(zipFile, exdir = ".\\data")

## Step 4 - Load the data files into data frames
trnXFile <- c(".\\data\\UCI HAR Dataset\\train\\X_train.txt")
testXFile <- c(".\\data\\UCI HAR Dataset\\test\\X_test.txt")
trnyFile <- c(".\\data\\UCI HAR Dataset\\train\\y_train.txt")
testyFile <- c(".\\data\\UCI HAR Dataset\\test\\y_test.txt")
featureFile <- c(".\\data\\UCI HAR Dataset\\features.txt")
subjTrain <- c(".\\data\\UCI HAR Dataset\\train\\subject_train.txt")
subjTest <- c(".\\data\\UCI HAR Dataset\\test\\subject_test.txt")
actvtyFile <- c(".\\data\\UCI HAR Dataset\\activity_labels.txt")
xTrain <- read.table(trnXFile)
xTest <- read.table(testXFile)
yTrain <- read.table(trnyFile)
yTest <- read.table(testyFile)
features <- read.table(featureFile)
sTrain <- read.table(subjTrain)
sTest <- read.table(subjTest)
activities <- read.table(actvtyFile)
names(activities) <- c("activityId","activityName")
## Step 5 - Merge the training and test data sets to create one data set
## Step 5.1 - rbind xTrain and xTest 
## Step 5.2 - rbind yTrain and yTest, change the column name to "activities"
## Step 5.3 - cbind xTrainTest and yTrainTest
## Step 5.4 - rbind sTrain and sTest, change the column name to "subject"
## Step 5.5 - cbind xyTrainTest and sTrainTest
xTrainTest  <- rbind(xTrain, xTest)
yTrainTest  <- rbind(yTrain, yTest)
names(yTrainTest) <- c("Activities")
xyTrainTest <- cbind(xTrainTest, yTrainTest)
sTrainTest  <- rbind(sTrain, sTest)
names(sTrainTest) <- c("subject")
xysTrainTest <- cbind(xyTrainTest, sTrainTest)

## Step 6 - Get all Mean and Standard deviation columns from features
## Regular expression for extracting this - ("[Ss]td|[Mm]ean"
MeanStdCols <- grep("[Ss]td|[Mm]ean", features[,2], value=TRUE)
reqdCols <- features[features$V2 %in% MeanStdCols,]

## Step 7 - Extract Mean and Standard deviation columns from data set
colusu <- c(reqdCols[[1]], 562,563)
dataSet <- xysTrainTest[,colusu]

## Step 8 - Add descriptive activity names (From activities data) to dataset
dataSet <- merge(dataSet, activities, by.x = "Activities", by.y = "activityId", all.x = TRUE)
## Remove the "Activities" numeric column
dataSet <- dataSet[,-1]

##Step 9 - Rename the Mean and Standard deviation columns to valid values
newColNames <- c("tBodyAccmeanX",
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
for (i in 1:length(dataSet)) {names(dataSet)[i] <- newColNames[i]}

## Step 10 - Write Tidy data set from dataframe to output file
write.table(dataSet,".\\data\\tidydata.txt")

## Step 11 - Compute the average of each variable for each activity and each subject

## Step 12 - Write Tidy data set of the dataset of averages computed
