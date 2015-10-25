==================================================================
Script: run_analysis.r
==================================================================
Eric Jung
==================================================================

This readme file describes the script written for the course project for the "Getting and Cleaning Data" course
offered by JHU through Coursera, October 2015.

The purpose of the script is to run several operations on the UCI data set for wearables motion data 
supplied by the Samsung Galaxy SII device available at: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data provides 561 attributes per run for 30 users, where
each user made several runs of different activities, including walking, laying, etc.

The script run_analysis.r can be run directly from the console. The following files should be placed 
into the same working directory as the script (as specified by the assignment:

- 'features.txt'
- 'activity_labels.txt'
- 'train/X_train.txt'
- 'train/y_train.txt'
- 'test/X_test.txt'
- 'test/y_test.txt'


The script itself runs as a single file using several of the input files from the UCI
data set. The data set includes the actual Samsung observation data as well as several
files stating field definitions, labels, and so forth. The data set is created and summarized
as specified by the assignment, and using the field def files, the field definitions are also 
assigned. The final output of the script is a file which averages the mean and std deviation 
measurements per subject per activity -> e.g. a particular subject may have run 60 "WALKING" activity 
measurements, and the data from these 60 runs is averaged into a single record.

======================================
Input file descriptions

- 'features.txt': List of all features - this gives labels for all 561 variables in the data set, and grep() is used to filter for only mean and std dev measurements
- 'activity_labels.txt': Links the class labels with their activity name. For simplicity, the 6 activities were hard-coded into the
- 'train/X_train.txt': Training set - gives the data for the training set runs
- 'train/y_train.txt': Training labels - gives the subject numbers for each run in the X_train set.(1-30 for the 30 different participants in the study)
- 'test/X_test.txt': Test set - gives the data for the test set runs
- 'test/y_test.txt': Test labels - gives the subject numbers for each run in the X_test set.(1-30 for the 30 different participants in the study)


======================================
Output:

course_project_output_20151025.txt: the output file containing the write.table() output of the final data set. As described,
the final output is a file which averages the mean and std deviation  measurements per subject per activity, amounting to 
180 runs combinations of subject (30 participants) and activities (6 different activities), e.g. a particular subject may 
have run 60 "WALKING" activity measurements, and the data from these 60 runs is averaged into a single record.

Command to open data:
read.table("course_project_output_20151025.txt", stringsAsFactors = FALSE, header = TRUE)

======================================
Details of the measurements taken (source: UCI)

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

====================================== 
codebook:

The final output contains 82 variables, and 180 rows as mentioned above

 [1] "Subject" - valued 1-30 for the 30 subjects of the study                              
 [2] "Activity" - description of activity - (WALKING, WALKING_UPSTAIRS, WALKING_UPSTAIRS, SITTING, STNA
 [3] "Number_of_Observations" - the number of observations made for the Subject/Activity combination in that row

The remaining variables all have the format:

	Average.meastype.meas-stat.plane

Average - this refers to the average of several observations for a particular Subject/Activity combo
Meastype - the measurement type made by the samsung device
meas-stat - mean or std for "mean" values made per measurement or "std" for standard deviations
plane - X/Y/Z for the three planes of movement

The units per measurement all align with the units for the original data set for the unaveraged values.

 [4] "Average.tBodyAcc.mean.X" 
 [5] "Average.tBodyAcc.mean.Y"              
 [6] "Average.tBodyAcc.mean.Z"   
 [7] "Average.tBodyAcc.std.X"               
 [8] "Average.tBodyAcc.std.Y"               
 [9] "Average.tBodyAcc.std.Z"               
[10] "Average.tGravityAcc.mean.X"           
[11] "Average.tGravityAcc.mean.Y"           
[12] "Average.tGravityAcc.mean.Z"           
[13] "Average.tGravityAcc.std.X"            
[14] "Average.tGravityAcc.std.Y"            
[15] "Average.tGravityAcc.std.Z"            
[16] "Average.tBodyAccJerk.mean.X"          
[17] "Average.tBodyAccJerk.mean.Y"          
[18] "Average.tBodyAccJerk.mean.Z"          
[19] "Average.tBodyAccJerk.std.X"           
[20] "Average.tBodyAccJerk.std.Y"           
[21] "Average.tBodyAccJerk.std.Z"           
[22] "Average.tBodyGyro.mean.X"             
[23] "Average.tBodyGyro.mean.Y"             
[24] "Average.tBodyGyro.mean.Z"             
[25] "Average.tBodyGyro.std.X"              
[26] "Average.tBodyGyro.std.Y"              
[27] "Average.tBodyGyro.std.Z"              
[28] "Average.tBodyGyroJerk.mean.X"         
[29] "Average.tBodyGyroJerk.mean.Y"         
[30] "Average.tBodyGyroJerk.mean.Z"         
[31] "Average.tBodyGyroJerk.std.X"          
[32] "Average.tBodyGyroJerk.std.Y"          
[33] "Average.tBodyGyroJerk.std.Z"          
[34] "Average.tBodyAccMag.mean"             
[35] "Average.tBodyAccMag.std"              
[36] "Average.tGravityAccMag.mean"          
[37] "Average.tGravityAccMag.std"           
[38] "Average.tBodyAccJerkMag.mean"         
[39] "Average.tBodyAccJerkMag.std"          
[40] "Average.tBodyGyroMag.mean"            
[41] "Average.tBodyGyroMag.std"             
[42] "Average.tBodyGyroJerkMag.mean"        
[43] "Average.tBodyGyroJerkMag.std"         
[44] "Average.fBodyAcc.mean.X"              
[45] "Average.fBodyAcc.mean.Y"              
[46] "Average.fBodyAcc.mean.Z"              
[47] "Average.fBodyAcc.std.X"               
[48] "Average.fBodyAcc.std.Y"               
[49] "Average.fBodyAcc.std.Z"               
[50] "Average.fBodyAcc.meanFreq.X"          
[51] "Average.fBodyAcc.meanFreq.Y"          
[52] "Average.fBodyAcc.meanFreq.Z"          
[53] "Average.fBodyAccJerk.mean.X"          
[54] "Average.fBodyAccJerk.mean.Y"          
[55] "Average.fBodyAccJerk.mean.Z"          
[56] "Average.fBodyAccJerk.std.X"           
[57] "Average.fBodyAccJerk.std.Y"           
[58] "Average.fBodyAccJerk.std.Z"           
[59] "Average.fBodyAccJerk.meanFreq.X"      
[60] "Average.fBodyAccJerk.meanFreq.Y"      
[61] "Average.fBodyAccJerk.meanFreq.Z"      
[62] "Average.fBodyGyro.mean.X"             
[63] "Average.fBodyGyro.mean.Y"             
[64] "Average.fBodyGyro.mean.Z"             
[65] "Average.fBodyGyro.std.X"              
[66] "Average.fBodyGyro.std.Y"              
[67] "Average.fBodyGyro.std.Z"              
[68] "Average.fBodyGyro.meanFreq.X"         
[69] "Average.fBodyGyro.meanFreq.Y"         
[70] "Average.fBodyGyro.meanFreq.Z"         
[71] "Average.fBodyAccMag.mean"             
[72] "Average.fBodyAccMag.std"              
[73] "Average.fBodyAccMag.meanFreq"         
[74] "Average.fBodyBodyAccJerkMag.mean"     
[75] "Average.fBodyBodyAccJerkMag.std"      
[76] "Average.fBodyBodyAccJerkMag.meanFreq" 
[77] "Average.fBodyBodyGyroMag.mean"        
[78] "Average.fBodyBodyGyroMag.std"         
[79] "Average.fBodyBodyGyroMag.meanFreq"    
[80] "Average.fBodyBodyGyroJerkMag.mean"    
[81] "Average.fBodyBodyGyroJerkMag.std"     
[82] "Average.fBodyBodyGyroJerkMag.meanFreq"



Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: eajung@gmail.com

