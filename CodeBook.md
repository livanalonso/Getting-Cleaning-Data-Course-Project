### Code Book for Getting and Cleaning Data Course Project
---
---
#### Variables

| Variable                 | Description                                  | Units  |
| :------------------------ |:--------------------------------------------| ------|
|fileUrl|URL of the data to be downloaded||
|dir|Path of directory where data was unzipped||  
|path.features|Path to features.txt file ||
|path.activity|Path to activity_labels.txt file||
|path.measurement_train|Path to X_train.txt file||
|path.label_train|Path to y_train.txt file||
|path.subject_train|Path to subject_train.txt file||
|path.measurement_test|Path to X_test.txt file||
|path.label_test|Path to y_test.txt file||
|path.subject_test path|Path to subject_test.txt||
|features.data|Data frame created from reading file with path path.features|| 
|activity.data|Data frame created from reading file with path path.activity||
|measurement_train.data|Data frame created from reading file with path path.measurement_train||
|label_train.data|Data frame created from reading file with path path.label_train||
|subject_train.data|Data frame created from reading file with path path.subject_train||
|measurement_test.data|Data frame created from reading file with path path.measurement_test||
|label_test.data|Data frame created from reading file with path path.label_test||
|subject_test.data|Data frame created from reading file with path path.subject_test||
|measurement_data|Data frame resulted from merging data frames: measurement_train.data and measurement_test.data||
|label_data|Data frame resulted from merging data frames: label_train.data and label_test.data||
|subject_data|Data frame resulted from merging data frames: subject_train.data and subject_test.data||
|merged.sets|Data frame resulted from merging data frames: subject_data,label_data and measurement_data||
|mean.columns|Vector containing indices of names of column where mean was measured ||
|std.columns|Vector containing indices of names of column where mean was measured ||
|dataset_mean.std|Data frame resulted from subsetting only the measurements on the mean and standard deviation for each measurement||


################################################################################
# 3-Uses descriptive activity names to name the activities in the data set
################################################################################

# cut() function divides the range of activity.data[,1] into 6 intervals and codes the values of the column activity.data[,2] according 
# to which interval they fall
merged.sets[,2]<-cut(merged.sets[,2],breaks=length(activity.data[,1]),as.vector(activity.data[,2]))


################################################################################
# 4-Appropriately labels the data set with descriptive variable names. 
################################################################################

colnames(merged.sets)<-c("subject","activity",as.vector(features.data[,2]))



################################################################################
# 5-From the data set in step 4, creates a second, independent tidy data set with 
#   the average of each variable for each activity and each subject.
################################################################################
all.column.names<-colnames(merged.sets)

dataset.average<-aggregate(merged.sets[,3:length(all.column.names)],
                           list("subject"=merged.sets$subject,"activity"=merged.sets$activity), mean)
write.table(dataset.average,file="dataset.step5.txt",row.name=FALSE)





---
---
#### Data:

---
---
#### Transformations (steps) from original data set to tidy data set
---
#####Step I: Download the data of project and unzip the downloaded file

#####Step II: Files were read using read.table() function

#####Step III: Merge the training and test data set (step 1 from assignment)
      a) by using rbind() function and later merge all columns containing subject, activity labels and measurements

#####Step IV: Extracts only the measurements on the mean and standard deviation for each measurement (step 2 from assignment)
        a) By using grepl() function, a logical vector can be created to search matches with mean() and st() labeled columns.
        b) By using which() function, indexes can be extrated
        c) Finally the dataset_mean.st was created subsetting the merge.sets data.table based on a) and b) indexes.

#####Step V: Use descriptive activity names to name the activities in the data set  (step 3 from assignment)
        a) cut() function divides the range of activity.data[,1] into 6 intervals and codes the values of the column
          activity.data[,2] according to which interval they fall.


#####Step VI: Appropriately labels the data set with descriptive variable names (step 4 from assignment)
        a) create new column names for merged.sets using the colnames() function.

#####Step VII: Create a second, independent tidy data set with the average of each variable for each activity and each subject (step 5 from assignment)
          a) Create variable all.column.names with column names from merged.sets.
          b) By using the function aggregate(), the data was splitted into subsets grouping by activity and subject
          c) Finally, the resulting tidy data set was writen to file:  dataset.step5.txt.
