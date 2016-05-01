## Getting and Cleaning Data - Project Codebook

This codebook describes the dataset output contained in tidydata.csv which is produced by the run_analysis() function created for the project.

### Data Source

Data for this analysis was taken from the Human Activity Recognition Using Smartphones Dataset. Additional details for this dataset is available from this site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data has been downloaded from the ff. url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### How the output was produced

The data in tidydata.csv contains the average (mean) for all variables referring to mean and standard deviation for activities performed by all subjects from the source data.

To come up with this data, the ff. steps were taken:

1. The ff. files were read from the data source

  * 'features.txt': List of all measurements taken stored in `features`
  * 'activity_labels.txt': List of all activities performed by subjects along with their reference ID stored in `activities`

  * 'train/X_train.txt': The training observations stored in `testData`
  * 'train/y_train.txt': The activities performed for the observations in the training data. Stored in `testActivities`
  * 'train/subject_train.txt': The subjects performing the activities for the observations in the training data. Stored in `testSubject`

  * 'test/X_test.txt': The test observations stored in `trainData`
  * 'test/y_test.txt': The activities performed for the observations in the test data. Stored in `trainActivities`
  * 'test/subject_test.txt': The subjects performing the activities for the observations in the test data stored in `trainSubject` 
  
2. The `testdata` and `trainData` columns were labelled using the measurements list in features.txt. The columns of `testActivities` and `trainActivities` were named `activityID`. The columns of `testSubject` and `trainSubject` were named `subjectID`.

3. The train and test data were merged into a single dataset called `mergedData` by putting the activities, and subjects as additional columns and then binding the train and test sets together. Sample code is found below.

  ```
  test <- cbind(testSubject, testActivities, testData)
  train <- cbind(trainSubject, trainActivities, trainData)
  mergedData <- rbind(test, train)
  ```

4. From the merged dataset, a new one called `mergedMeanStd` was created with the subjectID, activityID columns and measurements with Mean() and Std() in their column names.

  ```
  meanStdCols <- grep("mean\\(\\)|std\\(\\)", names(mergedData))
  mergedMeanStd <- mergedData[, c(1, 2, meanStdCols)]
  ```

5. Descriptive activity names were put into the `mergedMeanStd` by joining the dataset with the `activities` data using the `activityID` as reference.

  ```
  mergedMeanStd <- tbl_df(merge(activities, mergedMeanStd) %>% select(-activityID))
  ```

6. The column names of `mergedMeanStd` were cleaned up using the substitutions below:

  * - : hyphens were omitted from the column names
  * t : t at the start of the column names were changed to time
  * f : f at the start of column names were changed to frequency
  * () : open and close parentheses were omitted
  * mean : changed to Mean for follow naming format (Camel Case)
  * std : changed to Stddev to be more descriptive
  * X : X at the end of the column names were changed to XAxis to be more descriptive
  * Y : Y at the end of the column names were changed to YAxis to be more descriptive
  * Z : Z at the end of the column names were changed to ZAxis to be more descriptive 
  
6. A smaller dataset called `dataSummary` with the the average of each variable for each activity and each subject was created by grouping the `mergedMeanStd` dataset by activityName and subjectID and then running a summary on it. Code for this is found below.

  ```
  dataSummary <- group_by(mergedMeanStd, activityName, subjectID) %>% summarize_each(funs(mean))
  ```

7. Finally, `dataSummary` was written into a file named tidydata.csv with comma used as separator

  ```
  write.table(dataSummary, file="tidyData.csv", row.name=FALSE, sep = ",")
  ```
  
### List of Variables

1. activityName
2. subjectID
3. timeBodyAccMeanXAxis
4. timeBodyAccMeanYAxis
5. timeBodyAccMeanZAxis
6. timeBodyAccStddevXAxis
7. timeBodyAccStddevYAxis
8. timeBodyAccStddevZAxis
9. timeGravityAccMeanXAxis
10. timeGravityAccMeanYAxis
11. timeGravityAccMeanZAxis
12. timeGravityAccStddevXAxis
13. timeGravityAccStddevYAxis
14. timeGravityAccStddevZAxis
15. timeBodyAccJerkMeanXAxis
16. timeBodyAccJerkMeanYAxis
17. timeBodyAccJerkMeanZAxis
18. timeBodyAccJerkStddevXAxis
19. timeBodyAccJerkStddevYAxis
20. timeBodyAccJerkStddevZAxis
21. timeBodyGyroMeanXAxis
22. timeBodyGyroMeanYAxis
23. timeBodyGyroMeanZAxis
24. timeBodyGyroStddevXAxis
25. timeBodyGyroStddevYAxis
26. timeBodyGyroStddevZAxis
27. timeBodyGyroJerkMeanXAxis
28. timeBodyGyroJerkMeanYAxis
29. timeBodyGyroJerkMeanZAxis
30. timeBodyGyroJerkStddevXAxis
31. timeBodyGyroJerkStddevYAxis
32. timeBodyGyroJerkStddevZAxis
33. timeBodyAccMagMean
34. timeBodyAccMagStddev
35. timeGravityAccMagMean
36. timeGravityAccMagStddev
37. timeBodyAccJerkMagMean
38. timeBodyAccJerkMagStddev
39. timeBodyGyroMagMean
40. timeBodyGyroMagStddev
41. timeBodyGyroJerkMagMean
42. timeBodyGyroJerkMagStddev
43. freqBodyAccMeanXAxis
44. freqBodyAccMeanYAxis
45. freqBodyAccMeanZAxis
46. freqBodyAccStddevXAxis
47. freqBodyAccStddevYAxis
48. freqBodyAccStddevZAxis
49. freqBodyAccJerkMeanXAxis
50. freqBodyAccJerkMeanYAxis
51. freqBodyAccJerkMeanZAxis
52. freqBodyAccJerkStddevXAxis
53. freqBodyAccJerkStddevYAxis
54. freqBodyAccJerkStddevZAxis
55. freqBodyGyroMeanXAxis
56. freqBodyGyroMeanYAxis
57. freqBodyGyroMeanZAxis
58. freqBodyGyroStddevXAxis
59. freqBodyGyroStddevYAxis
60. freqBodyGyroStddevZAxis
61. freqBodyAccMagMean
62. freqBodyAccMagStddev
63. freqBodyBodyAccJerkMagMean
64. freqBodyBodyAccJerkMagStddev
65. freqBodyBodyGyroMagMean
66. freqBodyBodyGyroMagStddev
67. freqBodyBodyGyroJerkMagMean
68. freqBodyBodyGyroJerkMagStddev
