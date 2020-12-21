---
title: "R Notebook"
output: html_notebook
---


<<<<<<< HEAD

The following script prepares, cleans and fixes the data fulfilling 6 main stages
=======
The following script prepares, cleans and fixes the data fulfilling 5 main stages
>>>>>>> 38b14cf4d3a002393f6a91841b9ec28b4208e0e8

0. Load the required package for the analysis

```{r}
library(dplyr)
```
1. Download the Information

```{r}
fileLib <- "Coursera_Final.zip"
if (!file.exists(fileLib)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, fileLib, method="curl")}


if (!file.exists("UCI HAR Dataset")) { 
      unzip(fileLib) 
}
```
2. Assign each data to variables
<<<<<<< HEAD
a. Create the variable features with the file "features.txt", this file has 561 rows and 2 columns. "List of all features"
      
      
```{r}
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("#","func"))

```

b. Create the variable activities with the file "activity_labels.txt", this file has 6 rows and 2 columns. "Links the class labels with their activity name."

```{r}
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

```      

c. Create all the data necesary to make a Data Frame with Train.

subtrain <- "subject_train.txt", this file has 7352 rows, 1 column. "Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. "

xtrain <- "X_train.txt" this file has 7352 rows, 561 columns. Contains recorded train data.

ytrain <- "y_train.txt" this file has 7352 rows, 2 columns. Contains activity code for each row of data in xtrain. I use this variable to stock the data complete with the activity name using merge.


```{r}
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$func)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
ytrain <- merge(ytrain, activities, by.x = "code", by.y = "code", all.x = TRUE)

```   

c. Create all the data necesary to make a Data Frame with Test.

subtest <- "subject_test.txt", this file has 2947  rows, 1 column. "Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. "

xtest <- "X_test.txt" this file has 2947  rows, 561 columns. Contains recorded test data.

ytest <- "y_test.txt" this file has 2947  rows, 2 columns. Contains activity code for each row of data in xtrain. I use this variable to stock the data complete with the activity name using merge.


```{r}
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$func)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
ytest <- merge(ytest, activities, by.x = "code", by.y = "code", all.x = TRUE)

```   

3. Combine all tables and generate a single data frame

AllY <- Combination of all data of ytest and ytrain using rbind. (10299 rows, 1 column) 

AllX <- Combination of all data of xtest and xtrain using rbind. (10299 rows, 561 columns) 

AllSub <- Combination of all data of subtest and subtrain using rbind.

Project_Data <- Combination of all data of subtest and subtrain using cbind


```{r}
AllY <- rbind(ytest,ytrain)
AllX <- rbind(xtest,xtrain)
AllSub <- rbind(subtest,subtrain)

Project_Data <- cbind(AllSub, AllY, AllX)

``` 
4. Extracts only the measurements on the mean and standard deviation for each measurement. 

Using subseting (Select) to extract the columns with the word "mean" or "std" to extract the columns that we want.


```{r}
Final_Data <- select(Project_Data,subject, activity, contains("mean"), contains("std"))

``` 

5. Appropriately labels the data set with descriptive variable names. 
Using the gsub function i replaced the names of the columns, 

All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope

```{r}
Final_Data$code <- activities[Final_Data$code, 2]
names(Final_Data)[2] = "activity"
names(Final_Data)<-gsub("Acc", "Accelerometer", names(Final_Data))
names(Final_Data)<-gsub("Gyro", "Gyroscope", names(Final_Data))
names(Final_Data)<-gsub("BodyBody", "Body", names(Final_Data))
names(Final_Data)<-gsub("Mag", "Magnitude", names(Final_Data))
names(Final_Data)<-gsub("^t", "Time", names(Final_Data))
names(Final_Data)<-gsub("^f", "Frequency", names(Final_Data))
names(Final_Data)<-gsub("tBody", "TimeBody", names(Final_Data))
names(Final_Data)<-gsub("-mean()", "Mean", names(Final_Data), ignore.case = TRUE)
names(Final_Data)<-gsub("-std()", "STD", names(Final_Data), ignore.case = TRUE)
names(Final_Data)<-gsub("-freq()", "Frequency", names(Final_Data), ignore.case = TRUE)
names(Final_Data)<-gsub("angle", "Angle", names(Final_Data))
names(Final_Data)<-gsub("gravity", "Gravity", names(Final_Data))


``` 

6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject

ResumenData (180 rows, 88 columns) 
It is created by making a summary of the information with the "mean" function, grouping by activity and subject


```{r}
ResumenData <- Final_Data %>% group_by(activity, subject) %>% 
      summarise_all(mean)


write.table(Final_Data, "FinalData.txt", row.name=FALSE)


``` 
=======



