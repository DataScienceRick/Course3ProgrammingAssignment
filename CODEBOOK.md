## mean_retained_HARUS_data Codebook

The mean_retained_HARUS_data.txt file is a tidy set derived via the following files:  
* activity_labels.txt
* features.txt
* subject_test.txt
* X_test.txt
* y_test.txt
* subject_train.txt
* X_train.txt
* y_train.txt  
  
The raw files containing this data can be found here:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
  
Additional details surrounding this raw data can be found by reading the README.txt and features.txt files. All units in mean_retained_HARUS_data.txt were unchanged from the original raw dataset.  
  
The mean_retained_HARUS_data.txt file was derived by:
1. Binding the columns of the subject_test.txt, X_test.txt, and y_test.txt files.  
2. Binding the columns of the subject_train.txt, X_train.txt, and y_train,txt files.
3. Binding the rows of the datasets established in steps 1 and 2.  
4. Merging the activity names from activity_labels into the dataset created in step 3.
5. Removing all columns from the dataset in step 4 that do not contain mean or standard deviation information (except for subject id, activity id, and activity name)  
6. Summarizing each variable by mean from the dataset in step 5, while grouping by subject id and activity.
  
