# Code Book

The script used to tidy up the data can be found in run_analysis.R. Here is a brief overview of the contents in the R script.

## Preliminary
- The dataset was downloaded and necessary packages were loaded.
- The initial dataset was assigned to the variable dataInitial.
- Column names from the dataset were assigned a variable respective to their original name.

## Project Objectives
1. Merge the training and the test sets to create one data set
    - The training and test sets were merged together to create one data set. First, by binding the y (train /test) sets together, the x sets together, and the subject set together. Then merging the merged sets.
2. Extract only the measurements on the mean and standard deviation for each measurement
    - From the mergedData set, the mean and standard deviation were extracted.
3. Use descriptive activity names to name the activities in the data set
    - The numbers from the code column of the meanStd dataset were replaced with names from the second column of the activities variable
4. Appropriately label the data set with descriptive variable names
    - Column names from the data set were renamed to be more descriptive. Shortened/abbreviated column names were labeled to display their full name (eg. Acc to Accelerometer, f to frequency, etc.)
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
    - The avg variable uses the data from meanStd and exports a txt file presenting the average of each variable for each activity and subject.

