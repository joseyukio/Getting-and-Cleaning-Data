## Course Project
## Author: Jose Yukio Akazawa
## Date: July, 2015


## Load the packages used in this script.
library(dplyr) ## used at step 2
library(reshape2) ## used at step 5

# Set the working directory to course project
setwd("Course Project/")

## 1 - Merges the training and the test sets to create one data set.
####################################################################

## Read train data.
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

## Read test data.
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)

## Assign the name of the column "subject"
names(subjectTest) <- c("subject")
names(subjectTrain) <- c("subject")

## Assign the name of the column "activity"
names(yTrain) <- c("activity")
names(yTest) <- c("activity")

## Assign the names of the features
namesTemp <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
names(xTrain) <- namesTemp$V2
names(xTest) <- namesTemp$V2

## Combine the columns subject, activity and data set.
trainCombined <- cbind(subjectTrain, yTrain, xTrain)
testCombined <- cbind(subjectTest, yTest, xTest)

## Combine the rows from train and test data set
combinedData <- rbind(trainCombined, testCombined)

## 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
##############################################################################################

## Use select_vars to get the column names which contain mean or std
## I'm considering that only "pure" mean and std are required. 
## For instance this kind of measurements "gravityMean" is not considered
onlyMean <- select_vars(names(combinedData), contains("mean()"))
onlyStd <- select_vars(names(combinedData), contains("std()"))
## Now get only the observations with mean and std. Keep the subject and activity columns.
extractMeanStd <- combinedData[c("subject", "activity", onlyMean, onlyStd)]

## 3 -Uses descriptive activity names to name the activities in the data set
############################################################################

## Read the activity labels file into R.
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
## Assign the labels to activities. activityLabels has 2 columns that
## associate the numeric values (V1) to the activity names (V2).
## Reference for value labels: http://www.statmethods.net/input/valuelabels.html
combinedData$activity <- factor(combinedData$activity, levels = as.character(activityLabels$V1), labels = activityLabels$V2)

## 4 -Appropriately labels the data set with descriptive variable names.
########################################################################

## This was already done as part of step 1.
## So the variable combinedData already contains all descriptive variable names.

## 5 - From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.
############################################################################

## I'm assuming here that this exercise asks for the data set obtained in
## step 1 and processed in step 4. In my case combinedData.
## So, I'm not using the output from step 3 (mean and std) since
## in that step no data set was requested.

## First obtain a long format sing melt. subject and activity are the
## id variables and all the rest measured variables.
tmpMelt <- melt(combinedData, id=c("subject","activity"))

## Now cast to wide format and apply mean on all measured variables.
tidyData <- dcast(tmpMelt, subject+activity ~ variable, mean)

## Create a file with independent tidy data set.
write.table(tidyData,file = "tidyData.txt", row.names = FALSE)







