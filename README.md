# run_analysis.R script
The run_analysis.R script will download the dataset this is found in the below url:
_https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip_
To avoid potential conflicts with this data already being downloaded, it will create a new directory specific for each instance of running.
Once downloaded, the script will unzip the dataset, and will begin reading in the following files:
* activity_labels.txt
* features.txt
* subject_test.txt
* X_test.txt
* y_test.txt
* subject_train.txt
* X_train.txt
* y_train.txt
The script will then establish column names for each of the test and train data files.
Once established, the script will bind the datasets together into a single dataset (all_HARUS_data) that contains all data that is related to the aforementioned files.
The script will then create a second dataset that excludes elements from this dataset that are not related to mean or std (retained_HARUS_data).
The script will then create another dataset from retained_HARUS_data that summarizes the mean of each retained variable by subjectid and activityid.
This new dataset is then written to a text file within the directory used to run this script.
