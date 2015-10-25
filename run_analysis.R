## run_analysis.r
## description - takes the data set from UCI samsung galaxy wearable
## work and performs several functions
## 1. merges test/train data
## 2. renames variables based on label info provided by UCI
## 3. accurately and appropriately describes activity occurring during each observation set (each row)
## 3. takes only the subset of data relating to means/stddevs out of the 561 observations
## 4. Creates a summary output that takes mean of the observations per subject per activity-type

## load libraries
library(dplyr)
library(Hmisc)
library(data.table)

## read in data - each run is 561 observations
traindata <- read.table("X_train.txt")
testdata <- read.table("X_test.txt")

## read in labels - 1-6 for the different activities
trainlabels <- read.table("y_train.txt", )
testlabels <- read.table("y_test.txt")
activity_translation = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

## read in subject - this is 1-30 for the 30 different test subjects
trainsubject<- read.table("subject_train.txt")
testsubject<- read.table("subject_test.txt")

## read in feature list, get column #s for means, stddevs, and label vector
features <- read.table("features.txt")
mean_std_cols = integer(0)
mean_std_cols <- c(mean_std_cols, grep("mean",features$V2))
mean_std_cols <- c(mean_std_cols, grep("std",features$V2))
mean_std_cols<-sort(mean_std_cols)
obs_labels <-  features$V2[mean_std_cols]
obs_labels<-gsub("\\(\\)","",obs_labels)
obs_labels<-gsub("-",".",obs_labels)


## part 1: merge data set, and part2:extracts only measurements of mean/std
fulldata <- rbind(traindata[,mean_std_cols],testdata[,mean_std_cols])

## part 3: descriptive activity names added - 
##         achieved by adding columns for participant number and activity
## part 4: appropriately labels data set with descriptive variable names
colnames(fulldata)<- obs_labels ## add labels to data

## add columns to the FRONT of the line for activity, participant number and labels
fulldata<-cbind(activity_translation[c(trainlabels$V1,testlabels$V1)], fulldata)
fulldata<-cbind(c(trainsubject$V1,testsubject$V1), fulldata)
colnames(fulldata)[1:2] <- c("Subject", "Activity")

## part 5: create a new dataframe with means of all observations 
fulldata_summary <- select(fulldata,3:81)[FALSE,] ## create empty dataset

activity_vec <- vector("character", length = 0)
subject_vec <- vector("integer", length = 0)
sample_vec <- vector("integer", length =0)
for (subject in 1:max(unique(fulldata$Subject))){
  for (activity in activity_translation){
    #print(subject)
    #print(activity)
    subdata = select(fulldata[fulldata$Subject == subject & fulldata$Activity == activity,],3:81)
    subvector = apply(subdata,2,mean)
    if (dim(subdata)[1]>0){
      subject_vec <- c(subject_vec,subject)
	activity_vec <- c(activity_vec,activity)
	sample_vec <- c(sample_vec,dim(subdata)[1])
	fulldata_summary <- rbind(fulldata_summary,subvector)
      ##print(subvector)
    }
  }
}

## labels columns as necessary to have useful variable names
colnames(fulldata_summary) <- paste("Average.",obs_labels,sep ="")
fulldata_summary<-cbind(subject_vec,activity_vec,sample_vec,fulldata_summary)
colnames(fulldata_summary)[1:3] <- c("Subject","Activity","Number_of_Observations")

## outputs tab separated by white space (default seperator)
write.table(fulldata_summary, "course_project_output_20151025.txt", row.names=FALSE)


