## You should create one R script called run_analysis.R that does the following.
        ## 1) Merges the training and the test sets to create one data set.
        ## 2) Extracts only the measurements on the mean and standard deviation for each measurement.
        ## 3) Uses descriptive activity names to name the activities in the data set
        ## 4) Appropriately labels the data set with descriptive variable names.
        ## 5) From the data set in step 4, creates a second, independent tidy data set with the average 
        ##    of each variable for each activity and each subject.

HAR_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dirCreated <- FALSE
version <- 0

## creates a new base directory specific to this instance of script running
while(dirCreated == FALSE){
        version <- version + 1
        baseDir <- paste("./HARUS Directory ver_", version, sep = "")
        if(!file.exists(baseDir)){
                dir.create(baseDir)
                dirCreated = TRUE
        }
}

## downloads the file, then creates an unzipped version
download.file(HAR_URL, paste(baseDir,"/HARUS.zip", sep = ""))
unzip(paste(baseDir, "/HARUS.zip", sep = ""), exdir = paste(baseDir, "/HARUS", sep = ""))

## reads in the activity labels data
activity_labels_data <- read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/activity_labels.txt", sep = ""))

## reads in the features data
features_data <-  read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/features.txt", sep = ""))

## reads in the testing data
subject_test_data <- read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/test/subject_test.txt", sep = ""))
X_test_data <- read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/test/X_test.txt", sep = ""))
y_test_data <- read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/test/y_test.txt", sep = ""))

## reads in the training data
subject_train_data <- read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/train/subject_train.txt", sep = ""))
X_train_data <- read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/train/X_train.txt", sep = ""))
y_train_data <- read.table(paste(baseDir, "/HARUS/UCI HAR Dataset/train/y_train.txt", sep = ""))

## establish column names for the 561 feature vector datasets
colnames(X_test_data) <- features_data[,2]
colnames(X_train_data) <- features_data[,2]

## establish column names for the activity ids
colnames(y_test_data) <- "activityid"
colnames(y_train_data) <- "activityid"

## establish column names for the subject ids
colnames(subject_test_data) <- "subjectid"
colnames(subject_train_data) <- "subjectid"

## establish column names for the actvity name to id cross reference
colnames(activity_labels_data) <- c("activityid", "activityname")

## binds test data
all_test_data <- cbind(subject_test_data, y_test_data, X_test_data)

## binds training data
all_train_data <- cbind(subject_train_data, y_train_data, X_train_data)

## binds testing and training data together
all_HARUS_data <- rbind(all_test_data, all_train_data)

## pulls in activity names
all_HARUS_data <- merge(activity_labels_data, all_HARUS_data, by = "activityid", all.y = TRUE)

## creates a dataset only containing mean and standard deviation related data
HARUS_cols <- colnames(all_HARUS_data)
retained_cols <- (grepl("subjectid", HARUS_cols) | 
                          grepl("activityid", HARUS_cols) | grepl("activityname", HARUS_cols) |
                          grepl("mean..", HARUS_cols) | grepl("std..", HARUS_cols))
retained_HARUS_data <- all_HARUS_data[,retained_cols == TRUE]

## creates a second dataset w/ average of each variable for each activity and each subject
mean_retained_HARUS_data <- aggregate(. ~subjectid + activityid + activityname, retained_HARUS_data, mean)

## writes a text file of this dataset
write.table(mean_retained_HARUS_data, paste(baseDir, "/mean_retained_HARUS_data.txt", sep = ""), row.names = FALSE)

## script completed
print("run_analysis complete.")