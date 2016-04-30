# Getting and Cleaning Data Course Project
run_analysis <- function(x = "getdata-projectfiles-UCI HAR Dataset.zip") {
  
# Step 1: Setup and load required packages
# List of packages for session
message("Loading required packages...")
pkgList = c("stringr", "dplyr", "tidyr")

# Install CRAN packages (if not already installed)

instPkgs <- pkgList %in% installed.packages()
if(length(pkgList[!instPkgs]) > 0) install.packages(pkgList[!instPkgs])

# Load packages into session 
lapply(pkgList, library, character.only=TRUE)

# Check if files are available in working directory, if not, download

if (!file.exists(x)) {
  message(paste("Unable to find ", x,
              " in working directory. Please ensure you have the zipped dataset in ", getwd()))
  return()
}

# Read datasets from zipfile
message("Found dataset zip file. Reading data...")
zipFile <- file.path(getwd(), x)

features <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "features.txt")))
activities <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "activity_labels.txt")))

testSubject <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "test", "subject_test.txt")))
testActivities <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "test", "y_test.txt")))
testData <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "test", "X_test.txt")))

trainSubject <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "train", "subject_train.txt")))
trainActivities <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "train", "y_train.txt")))
trainData <- read.table(unz(zipFile, file.path("UCI HAR Dataset", "train", "X_train.txt")))

# Close open file connections
closeAllConnections()

# Set labels for datasets, this labels the data set with descriptive variable names
message("Processing Data...")
names(testData) <- features[,2]
names(trainData) <- features[,2]
names(activities) <- c("activityID", "activityName")
names(testSubject) <- c("subjectID")
names(trainSubject) <- c("subjectID")
names(testActivities) <- c("activityID")
names(trainActivities) <- c("activityID")

# Merge the training and the test sets to create one data set
test <- cbind(testSubject, testActivities, testData)
train <- cbind(trainSubject, trainActivities, trainData)
mergedData <- rbind(test, train)

# Extract the measurements on the mean and standard deviation for each measurement
meanStdCols <- grep("mean\\(\\)|std\\(\\)", names(mergedData))
mergedMeanStd <- mergedData[, c(1, 2, meanStdCols)]

# Use descriptive activity names to name the activities in the data set
mergedMeanStd <- tbl_df(merge(activities, mergedMeanStd) %>% select(-activityID))

# Appropriately label the data set with descriptive variable names
names(mergedMeanStd) <- gsub("-", "", names(mergedMeanStd))
names(mergedMeanStd) <- gsub("^t", "time", names(mergedMeanStd))
names(mergedMeanStd) <- gsub("^f", "freq", names(mergedMeanStd))
names(mergedMeanStd) <- gsub("mean\\(\\)", "Mean", names(mergedMeanStd))
names(mergedMeanStd) <- gsub("std\\(\\)", "Stddev", names(mergedMeanStd))
names(mergedMeanStd) <- gsub("X$", "XAxis", names(mergedMeanStd))
names(mergedMeanStd) <- gsub("Y$", "YAxis", names(mergedMeanStd))
names(mergedMeanStd) <- gsub("Z$", "ZAxis", names(mergedMeanStd))

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
dataSummary <- group_by(mergedMeanStd, activityName, subjectID) %>% summarize_each(funs(mean))

# Write a file with the resulting tidy data set
write.table(dataSummary, file="tidyData.csv", row.name=FALSE, sep = ",")

message(paste("Data processing completed. You may find results in ", file.path(getwd(), "tidyData.csv")))

}