
library(dplyr)

## ------------------------------------------------------------------------------------------------
## Download and unzip datasets. Note that files will be uncompressed under 
## sub-folder "UCI HAR Dataset"
## ------------------------------------------------------------------------------------------------
##filedir <- "C:/Coursera/Getting and Cleaning Data"
##setwd(filedir)
##url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##download.file(url, "UCI.zip")
##unzip("UCI.zip")

## ------------------------------------------------------------------------------------------------
## Read training data
## ------------------------------------------------------------------------------------------------
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt") 
train_label <- read.table("./UCI HAR Dataset/train/y_train.txt") 
train_data_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt") 

## ------------------------------------------------------------------------------------------------
## Read test data
## ------------------------------------------------------------------------------------------------
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt") 
test_label <- read.table("./UCI HAR Dataset/test/y_test.txt") 
test_data_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt") 

## ------------------------------------------------------------------------------------------------
## Read lists: feature names and activity labels
## ------------------------------------------------------------------------------------------------
feature_name <- read.table("./UCI HAR Dataset/features.txt")
names(feature_name) <- c("FeatureId", "FeatureName")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("ActivityId", "ActivityName")

## ------------------------------------------------------------------------------------------------
## Gather datasets and give appropriate names
## ------------------------------------------------------------------------------------------------
joined_data <- rbind(train_data,test_data) 
names(joined_data) = gsub("[()-]","",feature_name[[2]]) 
joined_labels <- rbind(train_label,test_label) 
names(joined_labels) = c("ActivityId") 
joined_subjects <- rbind(train_data_subject,test_data_subject) 
names(joined_subjects) = c("SubjectId") 

## ------------------------------------------------------------------------------------------------
## Extract only the measurements on the mean and standard deviation for each measurement
## ------------------------------------------------------------------------------------------------
mean_cols <- grep("mean",feature_name[[2]]) 
std_cols <- grep("std",feature_name[[2]]) 
measure_cols <- c(mean_cols, std_cols) 
joined_data <- joined_data[measure_cols]

## ------------------------------------------------------------------------------------------------
## Combine subjects, labels and observations
## ------------------------------------------------------------------------------------------------
activities <- merge(activity_labels, joined_labels, "ActivityId") 
obs <- cbind(joined_subjects, activities, joined_data)
averages = obs %>% group_by(ActivityName, SubjectId) %>% summarize_all(funs(mean))

## ------------------------------------------------------------------------------------------------
## Write to a file
## ------------------------------------------------------------------------------------------------
##write.table(obs, "clean_data_obs.txt") 
write.table(averages,"clean_data_avg.txt",row.name=FALSE) 

