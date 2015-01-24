---
title: "CodeBook.md"
output: html_document
---

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

#### You will be required to submit: 
1. a tidy data set as described below.
2. a link to a Github repository with your script for performing the analysis.
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  


#### The information about data
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#### Requirments
#####1. Merges the training and the test sets to create one data set.
  - Read the data from test/X_test.txt and train/X_train.txt
  - Use rbind() to merge the training and the test
  
#####2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  - grep mean|std from the name of all columns.
  - Extract the measurements on the mean and standard deviation
  - measurements_on_mean: the measurements on the mean
  - measurements_on_std: the measurements on the standard deviation

#####3. Uses descriptive activity names to name the activities in the data set
  - Read activity_labels.txt, train/y_train.txt, and test/y_test.txt
  - Use rbind() to bind the activity of training and test.
  - Add to data set a activity column.
  
#####4. Appropriately labels the data set with descriptive variable names. 
  - Add one more column with the name of the volunteers
  - Clear the name of columns
    + ^t  = time
    + ^f  = frequency
    + Acc   = Accelerometer
    + Gyro  = Gyroscope

#####5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Use new data.table to hold the data
  - Group(activiy, subject) to caculate mean of each variable
  - Use write.table to save the new data to file (tidy_data.txt)
  
  
  