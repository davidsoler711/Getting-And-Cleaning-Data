#Load the required package for the analysis

library(dplyr)
library(tidyr)

# Download the Information

fileLib <- "Coursera_Final.zip"

# Check if the file exists

if (!file.exists(fileLib)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, fileLib, method="curl")}

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
      unzip(fileLib) 
}

# Create all data frames
# Create the varaible called Features

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("#","func"))

# Create the 6 types of activities
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#Start to create the tables to make the train DF
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$func)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
ytrain2 <- merge(ytrain, activities, by.x = "code", by.y = "code", all.x = TRUE)

#Start to create the tables to make the test DF
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$func)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
ytest2 <- merge(ytest, activities, by.x = "code", by.y = "code", all.x = TRUE)

#Start to merge all data
AllY <- rbind(ytest,ytrain)
AllX <- rbind(xtest,xtrain)
AllSub <- rbind(subtest,subtrain)

Project_Data <- cbind(AllSub, AllY, AllX)


#Select only the data of Means and STD
Final_Data <- select(Project_Data,subject, code, contains("mean"), contains("std"))

#Change the names of the data to a description names
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


#Create the resume group by the 2 variables
ResumenData <- Final_Data %>% group_by(activity, subject) %>% 
      summarise_all(mean)



# Create the final document
write.table(Final_Data, "FinalData.txt", row.name=FALSE)

