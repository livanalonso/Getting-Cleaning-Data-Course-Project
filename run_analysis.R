# Set working directory
setwd("~/Documents/Livan/Programming/Courses/Coursera_Getting&CleaningData/Project")

# Download the data for the project
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="dataset.zip",method="curl")
        
# unzip data
unzip("dataset.zip")

# Remove zip file
file.remove("dataset.zip")
dir<-"UCI HAR Dataset"

# path to common files
path.features<-paste(dir,"/features.txt",sep="")
path.activity<-paste(dir,"/activity_labels.txt",sep="")


# path to train folder files
# 
path.measurement_train<-paste(dir,"/train/X_train.txt",sep="")
path.label_train<-paste(dir,"/train/y_train.txt",sep="")
path.subject_train<-paste(dir,"/train/subject_train.txt",sep="")

# path to test folder files
path.measurement_test<-paste(dir,"/test/X_test.txt",sep="")
path.label_test<-paste(dir,"/test/y_test.txt",sep="")
path.subject_test<-paste(dir,"/test/subject_test.txt",sep="")


# Reading files
features.data<-read.table(path.features,header = FALSE)
activity.data<-read.table(path.activity,header = FALSE)

measurement_train.data<-read.table(path.measurement_train,header = FALSE)
label_train.data<-read.table(path.label_train,header = FALSE)
subject_train.data<-read.table(path.subject_train,header = FALSE)

measurement_test.data<-read.table(path.measurement_test,header = FALSE)
label_test.data<-read.table(path.label_test,header = FALSE)
subject_test.data<-read.table(path.subject_test,header = FALSE)


################################################################################
# 1-Merges the training and the test sets to create one data set.

# Merging train and test data by using rbind() function
measurement_data<-rbind(measurement_train.data,measurement_test.data)
label_data<-rbind(label_train.data,label_test.data)
subject_data<-rbind(subject_train.data,subject_test.data)

# Merging all columns containing subject, activity label and measurements information
merged.sets<-cbind(subject_data,label_data,measurement_data)


################################################################################
# 2-Extracts only the measurements on the mean and standard deviation for each measurement. 

# By using grepl() function, a logical vector can be created to search matches with mean() and st() labeled columns.
# By using which() function, indexes can be extrated
mean.columns<-which(grepl("mean\\(\\)",features.data[,2]))
st.columns<-which(grepl("std\\(\\)",features.data[,2]))

# create dataset_mean.st containing subject, label information and mean() and std() measurements
# 2 was sumed because first two columns correspond to subject and label data 
dataset_mean.st<-merged.sets[, c(1:2,2+mean.columns,2+st.columns) ]


################################################################################
# 3-Uses descriptive activity names to name the activities in the data set

# cut() function divides the range of activity.data[,1] into 
merged.sets[,2]<-cut(merged.sets[,2],breaks=length(activity.data[,1]),as.vector(activity.data[,2]))


################################################################################
# 4-Appropriately labels the data set with descriptive variable names. 
colnames(merged.sets)<-c("subject","activity",as.vector(features.data[,2]))



################################################################################
# 5-From the data set in step 4, creates a second, independent tidy data set with 
#   the average of each variable for each activity and each subject.
