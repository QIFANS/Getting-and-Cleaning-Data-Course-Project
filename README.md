Wearable dataset
==================================================================
This file introduce the steps to get the dataset

Source:Human Activity Recognition Using Smartphones Dataset

the data used:
- 'subject_test.txt' : test subject

- 'subject_train.txt' : training subject

- 'features.txt': List of all feature

- 'train/X_train.txt': Training set

- 'train/y_train.txt': Training labels

- 'test/X_test.txt': Test set

- 'test/y_test.txt': Test labels

The dataset includes the following files:
=========================================

- 'README.md'

- 'CODEBOOK.md' 

- 'run_analysis.R': script to generate the dataset

- 'wearabledataset.txt': first tidy data

- 'wearabledataset_mean_by_group.txt': second tidy data

The process to create the tidy data
====================================

- use tead.table to save each file(txt) of the data used to a variable

- use rbind to merge the train set and the test set

- ues a vector of features to give the names of the features of the merged data set

- use grep to select the mean and standard deviation for each measurement

- merge the test subject and the training subject and replace the numbers with descriptive activity names

- merge the test label and training label

- merge the subject,label and data set to get a new data set

- sort the new data set to get our first tidy data

- for the second tidy data, just use the aggregate to split the data set by suject and label, then compute the average values for each of the subset. 





