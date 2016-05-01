## Getting and Cleaning Data - Project Codebook

This codebook describes the dataset output contained in tidydata.csv which is produced by the run_analysis() function created for the project.

### Data Source

Data for this analysis was taken from the Human Activity Recognition Using Smartphones Dataset. Additional details for this dataset is available from this site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data has been downloaded from the ff. url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### How the output was produced

The data in tidydata.csv contains the average (mean) for all variables referring to mean and standard deviation for activities performed by all subjects from the source data.

The information below describes the steps taken to come up with this data.

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

  * Name of the activity performed by the subject
  * Contains one of the ff: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

2. subjectID

  * ID for the person performing the activity
  * Contains an integer from 1-30

3. timeBodyAccMeanXAxis
  
  * Mean of the measured body accelerator time domain signal along the X-axis

4. timeBodyAccMeanYAxis

  * Mean of the measured body accelerator time domain signal along the Y-axis
  
5. timeBodyAccMeanZAxis

  * Mean of the measured body accelerator time domain signal along the Z-axis

6. timeBodyAccStddevXAxis

  * Standard Deviation of the measured body accelerator time domain signal along the X-axis

7. timeBodyAccStddevYAxis

  * Standard Deviation of the measured body accelerator time domain signal along the Y-axis

8. timeBodyAccStddevZAxis

  * Standard Deviation of the measured body accelerator time domain signal along the Z-axis
  
9. timeGravityAccMeanXAxis

  * Mean of the measured gravity accelerator time domain signal along the X-axis

10. timeGravityAccMeanYAxis

  * Mean of the measured gravity accelerator time domain signal along the Y-axis
  
11. timeGravityAccMeanZAxis

  * Mean of the measured gravity accelerator time domain signal along the Z-axis

12. timeGravityAccStddevXAxis

  * Standard Deviation of the measured gravity accelerator time domain signal along the X-axis

13. timeGravityAccStddevYAxis

  * Standard Deviation of the measured gravity accelerator time domain signal along the Y-axis

14. timeGravityAccStddevZAxis

  * Standard Deviation of the measured gravity accelerator time domain signal along the Z-axis

15. timeBodyAccJerkMeanXAxis

  * Mean of the measured body jerk accelerator time domain signal along the X-axis

16. timeBodyAccJerkMeanYAxis

  * Mean of the measured body jerk accelerator time domain signal along the Y-axis

17. timeBodyAccJerkMeanZAxis

  * Mean of the measured body jerk accelerator time domain signal along the Z-axis

18. timeBodyAccJerkStddevXAxis

  * Standard Deviation of the measured body jerk accelerator time domain signal along the Y-axis

19. timeBodyAccJerkStddevYAxis

  * Standard Deviation of the measured body jerk accelerator time domain signal along the Y-axis

20. timeBodyAccJerkStddevZAxis

  * Standard Deviation of the measured body jerk accelerator time domain signal along the Z-axis

21. timeBodyGyroMeanXAxis

  * Mean of the measured body gyroscope time domain signal along the X-axis

22. timeBodyGyroMeanYAxis  

  * Mean of the measured body gyroscope time domain signal along the Y-axis

23. timeBodyGyroMeanZAxis

  * Mean of the measured body gyroscope time domain signal along the Z-axis

24. timeBodyGyroStddevXAxis

  * Standard Deviation of the measured body gyroscope time domain signal along the X-axis

25. timeBodyGyroStddevYAxis

  * Standard Deviation of the measured body gyroscope time domain signal along the Y-axis

26. timeBodyGyroStddevZAxis

  * Standard Deviation of the measured body gyroscope time domain signal along the Z-axis

27. timeBodyGyroJerkMeanXAxis

  * Mean of the measured body jerk gyroscope time domain signal along the X-axis

28. timeBodyGyroJerkMeanYAxis

  * Mean of the measured body jerk gyroscope time domain signal along the Y-axis

29. timeBodyGyroJerkMeanZAxis

  * Mean of the measured body jerk gyroscope time domain signal along the Z-axis

30. timeBodyGyroJerkStddevXAxis

  * Standard Deviation of the measured body jerk gyroscope time domain signal along the X-axis

31. timeBodyGyroJerkStddevYAxis

  * Standard Deviation of the measured body jerk gyroscope time domain signal along the Y-axis

32. timeBodyGyroJerkStddevZAxis

  * Standard Deviation of the measured body jerk gyroscope time domain signal along the Z-axis

33. timeBodyAccMagMean

  * Mean of the magnitude of the three-dimensional body accelerator time domain signals 

34. timeBodyAccMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body accelerator time domain signals 

35. timeGravityAccMagMean

  * Mean of the magnitude of the three-dimensional gravity accelerator time domain signals 

36. timeGravityAccMagStddev

  * Standard deviation of the magnitude of the three-dimensional gravity accelerator time domain signals 

37. timeBodyAccJerkMagMean

  * Mean of the magnitude of the three-dimensional body jerk accelerator time domain signals 

38. timeBodyAccJerkMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body jerk accelerator time domain signals 

39. timeBodyGyroMagMean

  * Mean of the magnitude of the three-dimensional body gyroscope time domain signals 

40. timeBodyGyroMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body gyroscope time domain signals 

41. timeBodyGyroJerkMagMean

  * Mean of the magnitude of the three-dimensional body jerk gyroscope time domain signals 

42. timeBodyGyroJerkMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body jerk gyroscope time domain signals 

43. freqBodyAccMeanXAxis

  * Mean of the measured body accelerator frequency domain signal along the X-axis
  
44. freqBodyAccMeanYAxis

  * Mean of the measured body accelerator frequency domain signal along the Y-axis

45. freqBodyAccMeanZAxis

  * Mean of the measured body accelerator frequency domain signal along the Z-axis

46. freqBodyAccStddevXAxis

  * Standard Deviation of the measured body accelerator frequency domain signal along the X-axis

47. freqBodyAccStddevYAxis

  * Standard Deviation of the measured body accelerator frequency domain signal along the Y-Axis

48. freqBodyAccStddevZAxis

  * Standard Deviation of the measured body accelerator frequency domain signal along the Z-axis

49. freqBodyAccJerkMeanXAxis

  * Mean of the measured body jerk accelerator frequency domain signal along the X-axis

50. freqBodyAccJerkMeanYAxis

  * Mean of the measured body jerk accelerator frequency domain signal along the Y-axis

51. freqBodyAccJerkMeanZAxis

  * Mean of the measured body jerk accelerator frequency domain signal along the Z-axis

52. freqBodyAccJerkStddevXAxis

  * Standard Deviation of the measured body jerk accelerator frequency domain signal along the X-axis

53. freqBodyAccJerkStddevYAxis

  * Standard Deviation of the measured body jerk accelerator frequency domain signal along the Y-axis

54. freqBodyAccJerkStddevZAxis

  * Standard Deviation of the measured body jerk accelerator frequency domain signal along the Z-axis

55. freqBodyGyroMeanXAxis

  * Mean of the measured body jerk gyroscope frequency domain signal along the X-axis 

56. freqBodyGyroMeanYAxis

  * Mean of the measured body jerk gyroscope frequency domain signal along the Y-axis 

57. freqBodyGyroMeanZAxis

  * Mean of the measured body jerk gyroscope frequency domain signal along the Z-axis

58. freqBodyGyroStddevXAxis

  * Standard Deviation of the measured body jerk gyroscope frequency domain signal along the X-axis 

59. freqBodyGyroStddevYAxis

  * Standard Deviation of the measured body jerk gyroscope frequency domain signal along the Y-axis 

60. freqBodyGyroStddevZAxis

  * Standard Deviation of the measured body jerk gyroscope frequency domain signal along the Z-axis 

61. freqBodyAccMagMean

  * Mean of the magnitude of the three-dimensional body accelerator frequency domain signals 

62. freqBodyAccMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body accelerator frequency domain signals 

63. freqBodyBodyAccJerkMagMean

  * Mean of the magnitude of the three-dimensional body jerk accelerator frequency domain signals 

64. freqBodyBodyAccJerkMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body jerk accelerator frequency domain signals 

65. freqBodyBodyGyroMagMean

  * Mean of the magnitude of the three-dimensional body gyroscope frequency domain signals 

66. freqBodyBodyGyroMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body gyroscope frequency domain signals 
  
67. freqBodyBodyGyroJerkMagMean

  * Mean of the magnitude of the three-dimensional body jerk gyroscope frequency domain signals 

68. freqBodyBodyGyroJerkMagStddev

  * Standard Deviation of the magnitude of the three-dimensional body jerk gyroscope frequency domain signals 