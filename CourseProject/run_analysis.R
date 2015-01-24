
getting_cleaning_data <- function() {
  
  message("Loading package ...")
  library(data.table)
  library(dplyr)
  
  message("")
  message("Merge the datas")
  ### 1.Merges the training and the test sets to create one data set.
  message("Read data from test/X_test.txt file")
  test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
  message("Read data from train/X_train.txt")
  train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
  message("Merges the training and the test sets")
  tidy_data <- rbind(test, train)
  # not use 'test' and 'train' any more, remove it
  rm(test)
  rm(train)
  
  message("")
  message("Extracts the data")
  ### 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  # Read the features
  message("Read data from features.txt file")
  features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
  names(features) <- c("feature_id", "feature_name")
  # Name the columns of tidy_data
  names(tidy_data) <- features$feature_name
  
  # mean
  message("Extracts the measurements on the mean")
  cols_of_mean <- (grep("mean", features$feature_name))
  measurements_on_mean <- tidy_data[, cols_of_mean]
  
  # standard deviation
  message("Extracts the measurements on the standard deviation")
  cols_of_std <- (grep("std", features$feature_name))
  measurements_on_std <- tidy_data[, cols_of_std]
  # not use 'features' any more, remove it
  rm(features)
  
  
  message("")
  message("Name the activities")
  ### 3.Uses descriptive activity names to name the activities in the data set
  message("Read data from test/y_test.txt file")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
  message("Read data from train/y_train.txt file")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
  message("rbind y_test.txt and y_train.txt")
  activities <- rbind(y_test, y_train)
  
  message("Name the activities in the data set")
  names(activities) <- "activity_id"
  tidy_data$activity <- activities$activity_id
  tidy_data$activity[tidy_data$activity == 1] <- "WALKING"
  tidy_data$activity[tidy_data$activity == 2] <- "WALKING_UPSTAIRS"
  tidy_data$activity[tidy_data$activity == 3] <- "WALKING_DOWNSTAIRS"
  tidy_data$activity[tidy_data$activity == 4] <- "SITTING"
  tidy_data$activity[tidy_data$activity == 5] <- "STANDING"
  tidy_data$activity[tidy_data$activity == 6] <- "LAYING"
  # not use 'activites' any more, remove it
  rm(activities)
  rm(y_test)
  rm(y_train)
    
  
  message("")
  message("Labels the data set with descriptive variable names")
  ### 4.Appropriately labels the data set with descriptive variable names. 
  message("Read test/subject_test.txt")
  message("train/subject_train.txt")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  message("rbind the subject_test.txt and subject_train.txt")
  subjects <- rbind(subject_test, subject_train)
  names(subjects) <- "subject_id"
  # add the 'subject_id' and 'subject' columns to data
  tidy_data$subject <- subjects$subject_id
  
  # name the volunteers
  message("Name the volunteers")
  for (i in 1:30) {
    tidy_data$subject[tidy_data$subject == i] <- paste("Volunteer", i)
  }
  
  # ^t  = time; 
  # ^f  = frequency
  # Acc   = Accelerometer
  # Gyro  = Gyroscope
  message("Re-Name the name of columns")
  names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
  names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
  names(tidy_data) <- gsub("^t", "time", names(tidy_data))
  names(tidy_data) <- gsub("^f", "frequency", names(tidy_data))
  
  
  message("")
  message("Write to file")
  ### 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  data_tb <- data.table(tidy_data)
  message("The average of variables by activity and subject")
  data <- data_tb[, lapply(.SD, mean), by = 'activity,subject']
  message("Write the final data to tify_data.txt file")
  write.table(data, "tidy_data.txt", row.names = FALSE)

}
