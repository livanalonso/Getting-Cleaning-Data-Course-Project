### Code Book for Getting and Cleaning Data Course Project
---
---
#### Variables:
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
