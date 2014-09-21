##
## Determine the best hospital in a state related to outcomes for a specified
## health problem
##
## the input is state and outcome (issue being investigated)
##

run_analysis <- function() {
  #
  # read the test data in and build a consolidated table.
  #
  test_data     <-  read.table('UCI HAR Dataset/test/X_test.txt', header=FALSE)
  test_subject  <-  read.table('UCI HAR Dataset/test/subject_test.txt', header=FALSE)
  test_activity <-  read.table('UCI HAR Dataset/test/y_test.txt', header=FALSE)
  #
  # Column bind the parts into a single test dataset
  #
  all_test <- cbind( test_subject, test_activity, test_data )
  #
  # now pull together the training data..
  #
  train_data     <- read.table('UCI HAR Dataset/train/X_train.txt', header=FALSE)
  train_subject  <- read.table('UCI HAR Dataset/train/subject_train.txt', header=FALSE)
  train_activity <- read.table('UCI HAR Dataset/train/y_train.txt', header=FALSE)
  #
  # Column bind all the training data into a single dataset
  #
  all_train <- cbind( train_subject, train_activity, train_data)
  #
  # unify the test and training data using row binding...
  #
  complete_data_set <- rbind( all_test, all_train )
  #
  # remove the temp tables... (trim our memory footprint -- just to be nice :)
  #
  rm(test_data, test_subject, test_activity, train_data, train_subject, train_activity)
  rm( all_test, all_train )
  #
  # setup some colnames we use below.
  #
  colnames(complete_data_set) <- c("Subject", "Activity")
  #
  # Replace the numbers with Descriptive Activities.
  #1 WALKING
  #2 WALKING_UPSTAIRS
  #3 WALKING_DOWNSTAIRS
  #4 SITTING
  #5 STANDING
  #6 LAYING
  #
  complete_data_set$Activity[complete_data_set$Activity == 1] <- "Walking"
  complete_data_set$Activity[complete_data_set$Activity == 2] <- "Walking Upstairs"
  complete_data_set$Activity[complete_data_set$Activity == 3] <- "Walking Downstairs"
  complete_data_set$Activity[complete_data_set$Activity == 4] <- "Sitting"
  complete_data_set$Activity[complete_data_set$Activity == 5] <- "Standing"
  complete_data_set$Activity[complete_data_set$Activity == 6] <- "Laying"
  
 #
 # using offsets in meansandstd measures.txt (offset by 2 cols since we added a subject
 # activities column to the dataset) we setup our subset of the dataset.
 #
  mean_and_std_data <- complete_data_set[c(1:2, 3:8, 43:48, 83:88, 
                                           123:128, 163:168, 203:204,
                                           216:217, 229:230, 242:243, 
                                           255:256, 268:273, 
                                           296:298, 347:352, 
                                           375:377, 426:431, 
                                           454:456, 505:506, 515, 518:519, 531:532,
                                           541, 544:545, 555)]  
 #
 # setup our descriptive column names
 #
  colnames(mean_and_std_data) <- c("Subject", "Activity", 
                                   "BodyAcc-mean()-X",
                                   "BodyAcc-mean()-Y",
                                   "BodyAcc-mean()-Z",
                                   "BodyAcc-std()-X",
                                   "BodyAcc-std()-Y",
                                   "BodyAcc-std()-Z",
                                   "GravityAcc-mean()-X",
                                   "GravityAcc-mean()-Y",
                                   "GravityAcc-mean()-Z",
                                   "GravityAcc-std()-X",
                                   "GravityAcc-std()-Y",
                                   "GravityAcc-std()-Z",
                                   "BodyAccJerk-mean()-X",
                                   "BodyAccJerk-mean()-Y",
                                   "BodyAccJerk-mean()-Z",
                                   "BodyAccJerk-std()-X",
                                   "BodyAccJerk-std()-Y",
                                   "BodyAccJerk-std()-Z",
                                   "BodyGyro-mean()-X",
                                   "BodyGyro-mean()-Y",
                                   "BodyGyro-mean()-Z",
                                   "BodyGyro-std()-X",
                                   "BodyGyro-std()-Y",
                                   "BodyGyro-std()-Z",
                                   "BodyGyroJerk-mean()-X",
                                   "BodyGyroJerk-mean()-Y",
                                   "BodyGyroJerk-mean()-Z",
                                   "BodyGyroJerk-std()-X",
                                   "BodyGyroJerk-std()-Y",
                                   "BodyGyroJerk-std()-Z",
                                   "BodyAccMag-mean()",
                                   "BodyAccMag-std()",
                                   "GravityAccMag-mean()",
                                   "GravityAccMag-std()",
                                   "BodyAccJerkMag-mean()",
                                   "BodyAccJerkMag-std()",
                                   "BodyGyroMag-mean()",
                                   "BodyGyroMag-std()",
                                   "BodyGyroJerkMag-mean()",
                                   "BodyGyroJerkMag-std()",
                                   "BodyAcc-mean()-X",
                                   "BodyAcc-mean()-Y",
                                   "BodyAcc-mean()-Z",
                                   "BodyAcc-std()-X",
                                   "BodyAcc-std()-Y",
                                   "BodyAcc-std()-Z",
                                   "BodyAcc-meanFreq()-X",
                                   "BodyAcc-meanFreq()-Y",
                                   "BodyAcc-meanFreq()-Z",
                                   "BodyAccJerk-mean()-X",
                                   "BodyAccJerk-mean()-Y",
                                   "BodyAccJerk-mean()-Z",
                                   "BodyAccJerk-std()-X",
                                   "BodyAccJerk-std()-Y",
                                   "BodyAccJerk-std()-Z",
                                   "BodyAccJerk-meanFreq()-X",
                                   "BodyAccJerk-meanFreq()-Y",
                                   "BodyAccJerk-meanFreq()-Z",
                                   "BodyGyro-mean()-X",
                                   "BodyGyro-mean()-Y",
                                   "BodyGyro-mean()-Z",
                                   "BodyGyro-std()-X",
                                   "BodyGyro-std()-Y",
                                   "BodyGyro-std()-Z",
                                   "BodyGyro-meanFreq()-X",
                                   "BodyGyro-meanFreq()-Y",
                                   "BodyGyro-meanFreq()-Z",
                                   "BodyAccMag-mean()",
                                   "BodyAccMag-std()",
                                   "BodyAccMag-meanFreq()",
                                   "BodyBodyAccJerkMag-mean()",
                                   "BodyBodyAccJerkMag-std()",
                                   "BodyBodyGyroMag-mean()",
                                   "BodyBodyGyroMag-std()",
                                   "BodyBodyGyroMag-meanFreq()",
                                   "BodyBodyGyroJerkMag-mean()",
                                   "BodyBodyGyroJerkMag-std()",
                                   "BodyBodyGyroJerkMag-meanFreq()"
                                   )
 ##
 # Melt our dataset, such that the variables are all flattened into one column
 #
 new_data <- melt( mean_and_std_data, id.vars= c("Subject", "Activity"))
 ##
 # get the mean by variable, and subject and activity.
 #
 meansOfSubjectByActivtity <- dcast(new_data, Subject + Activity ~ variable, mean)
 ##
 ## write this table out as a tidy dataset.
 ##
 write.table(meansOfSubjectByActivtity, "MeansBySubjectAndActivity.txt", 
             row.name=FALSE, 
             sep="\t")
}