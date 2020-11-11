
# Load packages
library(dplyr)

# Download data
path <- setwd("/Users/lernerlab/Desktop/Rscript/ProgrammingAssignment4")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))

# Assign variable and print to view contents
dataInitial <- unzip(zipfile = "dataFiles.zip")
dataInitial

# Assign variables to dataset columns
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1 Merge the training and the test sets to create one data set
ySet <- rbind(y_train, y_test)
xSet <- rbind(x_train, x_test)
Subject <- rbind(subject_train, subject_test)
mergedData <- cbind(Subject, ySet, xSet)

# 2 Extract only the measurements on the mean and standard deviation for each measurement
meanStd <- mergedData %>% select(subject, code, contains("mean"), contains("std"))

# 3 Use descriptive activity names to name the activities in the data set
meanStd$code <- activities[meanStd$code, 2]

# 4 Appropriately label the data set with descriptive variable names
names(meanStd)[2] = "activity"
names(meanStd) <- gsub("Acc", "Accelerometer", names(meanStd))
names(meanStd) <- gsub("Gyro", "Gyroscope", names(meanStd))
names(meanStd) <- gsub("BodyBody", "Body", names(meanStd))
names(meanStd) <- gsub("Mag", "Magnitude", names(meanStd))
names(meanStd) <- gsub("^t", "Time", names(meanStd))
names(meanStd) <- gsub("^f", "Frequency", names(meanStd))
names(meanStd) <- gsub("tBody", "TimeBody", names(meanStd))
names(meanStd) <- gsub("-mean()", "Mean", names(meanStd), ignore.case = TRUE)
names(meanStd) <- gsub("-std()", "STD", names(meanStd), ignore.case = TRUE)
names(meanStd) <- gsub("-freq()", "Frequency", names(meanStd), ignore.case = TRUE)
names(meanStd) <- gsub("angle", "Angle", names(meanStd))
names(meanStd) <- gsub("gravity", "Gravity", names(meanStd))

# 5 From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
avg <- meanStd %>%
    group_by(subject, activity) %>%
    summarize_all(list(mean))
write.table(avg, "avg.txt", row.name=FALSE)
