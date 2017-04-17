=================================================================
Week 4 Assignment
=================================================================

CS

=================================================================
Instructions
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

Review Criteria
The submitted data set is tidy. 
The Github repo contains the required scripts.
GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables 
and summaries calculated, along with units, and any other relevant information.
The README that explains the analysis files is clear and understandable.
The work submitted for this project is the work of the student who submitted it.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.
			
- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

****Not Used****
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Steps taken

1 Merges the training and the test sets to create one data set.

-Used read.table to put each of the files into a dataframe
-combine them using rbind and cbind to make one data set

2 Extracts only the measurements on the mean and standard deviation for each measurement. 
-Added names to the columns from the features.txt to allow from grepl to get only standard deviation and mean columns
-cleaned up special characters and made labels lower

3 Uses descriptive activity names to name the activities in the data set
-added column names to activity data frame to allow to merge easier
-merged the combine dataset with activity_labels to get the written activities
-dropped the activity numbered column

4 Appropriately labels the data set with descriptive variable names.
-I don't really now how you can make these labels readable not really understanding the data so I had just made them lower and cleaned them up.
 
5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
-loaded sqldf 
-used sqldf command to group by subject and activity, then average all columns ***this is probably not a great way to do it but after hours of frustation I settled on it
-cleand up the headers again
-wrote the output to a file MyTidy.csv

Built a codebook to explain the data and is in githup repository.  codebook.doc
All files are in githup repository

To load my .csv file use the following
mydata <- read.table("./MyTidy.csv", header = TRUE, sep=",")

Thank you for grading my assignment!  I am struggling with this so I hope reviewing it isn't to terrible!

