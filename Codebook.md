## Getting and Cleaning Data - Project Codebook

This codebook describes the dataset output contained in tidydata.csv which is produced by the run_analysis() function created for the project.

### Data Source

Data for this analysis was taken from the Human Activity Recognition Using Smartphones Dataset. Additional details for this dataset is available from this site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data has been downloaded from the ff. url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### How the output was produced

The data in tidydata.csv contains the average (mean) for all variables referring to mean and standard deviation for activities performed by all subjects from the source data.

To come up with this data, the ff. steps were taken:

1. The ff. files were read from the data source

  * 'features.txt': List of all measurements taken
  * 'activity_labels.txt': List of all activities performed by subjects along with their reference ID

  * 'train/X_train.txt': The training observations
  * 'train/y_train.txt': The activities performed for the observations in the training data
  * 'train/subject_train.txt': The subjects performing the activities for the observations in the training data

  * 'test/X_test.txt': The test observations
  * 'test/y_test.txt': The activities performed for the observations in the test data
  * 'test/subject_test.txt': The subjects performing the activities for the observations in the test data

2. The train and test data were merged into a single dataset by putting the activities, and subjects as additional columns and then binding the train and test sets together. Sample code is found below

```
test <- cbind(testSubject, testActivities, testData)
train <- cbind(trainSubject, trainActivities, trainData)
mergedData <- rbind(test, train)
```


### List of Variables
activityName	
subjectID	
timeBodyAccMeanXAxis
timeBodyAccMeanYAxis
timeBodyAccMeanZAxis
timeBodyAccStddevXAxis	
timeBodyAccStddevYAxis	
timeBodyAccStddevZAxis	
timeGravityAccMeanXAxis	
timeGravityAccMeanYAxis	
timeGravityAccMeanZAxis	
timeGravityAccStddevXAxis	
timeGravityAccStddevYAxis	
timeGravityAccStddevZAxis	
timeBodyAccJerkMeanXAxis	
timeBodyAccJerkMeanYAxis	
timeBodyAccJerkMeanZAxis	
timeBodyAccJerkStddevXAxis	
timeBodyAccJerkStddevYAxis	
timeBodyAccJerkStddevZAxis	
timeBodyGyroMeanXAxis	
timeBodyGyroMeanYAxis	
timeBodyGyroMeanZAxis	
timeBodyGyroStddevXAxis	
timeBodyGyroStddevYAxis	
timeBodyGyroStddevZAxis	
timeBodyGyroJerkMeanXAxis	
timeBodyGyroJerkMeanYAxis	
timeBodyGyroJerkMeanZAxis	
timeBodyGyroJerkStddevXAxis	
timeBodyGyroJerkStddevYAxis	
timeBodyGyroJerkStddevZAxis	
timeBodyAccMagMean	
timeBodyAccMagStddev	
timeGravityAccMagMean	
timeGravityAccMagStddev	
timeBodyAccJerkMagMean	
timeBodyAccJerkMagStddev	
timeBodyGyroMagMean	
timeBodyGyroMagStddev	
timeBodyGyroJerkMagMean	
timeBodyGyroJerkMagStddev	
freqBodyAccMeanXAxis	
freqBodyAccMeanYAxis	
freqBodyAccMeanZAxis	
freqBodyAccStddevXAxis	
freqBodyAccStddevYAxis	
freqBodyAccStddevZAxis	
freqBodyAccJerkMeanXAxis	
freqBodyAccJerkMeanYAxis	
freqBodyAccJerkMeanZAxis	
freqBodyAccJerkStddevXAxis	
freqBodyAccJerkStddevYAxis	
freqBodyAccJerkStddevZAxis	
freqBodyGyroMeanXAxis	
freqBodyGyroMeanYAxis	
freqBodyGyroMeanZAxis	
freqBodyGyroStddevXAxis	
freqBodyGyroStddevYAxis	
freqBodyGyroStddevZAxis	
freqBodyAccMagMean	
freqBodyAccMagStddev	
freqBodyBodyAccJerkMagMean	
freqBodyBodyAccJerkMagStddev	
freqBodyBodyGyroMagMean	
freqBodyBodyGyroMagStddev	
freqBodyBodyGyroJerkMagMean	
freqBodyBodyGyroJerkMagStddev