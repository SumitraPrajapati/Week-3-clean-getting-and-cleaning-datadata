library(dplyr)

## to downlaod zipfile contaning data if it has not been downloaded
projectfile <- "UCI HAR Dataset.zip"
if (!file.exists(projectfile)){
  projectURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(projectURL,projectfile, mode = "curl")
}
if (!file.exists("UCI HAR Dataset")){
  unzip (projectfile)
}

##to read features, activity labels, test and train data

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("ID", "activity"))
testsubject <-read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
Xtest <-read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
Ytest <-read.table("UCI HAR Dataset/test/y_test.txt", col.names = "ID")
trainsubject <-read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
Xtrain <-read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
Ytrain <-read.table("UCI HAR Dataset/train/y_train.txt", col.names = "ID")

## To merge data
X <-rbind (Xtest, Xtrain)
Y <- rbind (Ytest,Ytrain)
Subject <- rbind(testsubject, trainsubject)
Activity <- cbind (X,Y, Subject)

## To extract mean and standard deviation for each measurement

ActivityData <- Activity %>% select(subject,ID, contains ("mean"),contains ("std"))

## Assign descriptive activity names to name the activities in data set
ActivityData$ID <- activities [ActivityData$ID, 2]

## Appropriate labels with descriptive variable names
names(ActivityData)[2] = "activity"
names(ActivityData) <-gsub ("Acc", "Accelerometer", names (ActivityData))
names(ActivityData) <-gsub ("Gyro", "Gyroscope", names (ActivityData))
names(ActivityData) <-gsub ("tbody", "TimeBody", names (ActivityData))
names(ActivityData) <-gsub ("Mag", "Magnitude", names (ActivityData))
names(ActivityData) <-gsub ("^t", "Time", names (ActivityData))
names(ActivityData) <-gsub ("^f", "Frequency", names (ActivityData))
names(ActivityData) <-gsub ("-mean ()", "Mean", names (ActivityData), ignore.case =TRUE)
names(ActivityData) <-gsub ("-std ()", "SandardDeviation", names (ActivityData), ignore.case = TRUE)
names(ActivityData) <-gsub ("-freq()", "Frequency", names (ActivityData), ignore.case = TRUE)
names(ActivityData) <-gsub ("angle", "Angle", names (ActivityData))
names(ActivityData) <-gsub ("gravity", "Gravity", names (ActivityData))


## to make tidydata set for indiviual activity and subject
TidyData <- ActivityData %>%
  group_by(subject, activity)%>%
  summarise_all(funs(mean))
write.table (TidyData, "TidyData.txt", row.name = FALSE)


##output
str(TidyData)
TidyData
