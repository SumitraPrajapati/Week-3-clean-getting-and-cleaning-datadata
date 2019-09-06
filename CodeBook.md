run_analysis contains data preparation and 5 steps in the course which are as follow:

1. Download data from UCI HAR Dataset folder provided in the course link.

2. To read and assign variables to each data (i.e. features, activity labels, test and train data)
i. features <- features.txt: 561 rows and 2 columns
The data in features come from acccelerometer and gyroscope tAcc-XYZ and tGyro-XYZ
ii. activities <- activity_Labels.txt: 6 rows and 2 columns
Gives list of activities performed
iii. testsubject <- test/subject_test.txt: 2947 rows and 1 column
contains test data of 9 volunteers subject being observed
iv. Xtest <- test/X_test.txt: 2947 rows and 561 columns
contains recorded features test data
iv. Ytest <- test/y_test.txt: 2947 rows and 1 column
contains test data of activites
v. trainsubject <- train/subject_train.txt : 7352 rows and 1 column
contains train data of 21 volunteers subjects being observed
vi. Xtrain <- train/X_train.txt: 7352 rows and 561 columns
contains recorded features test data
vii. Ytrain <- train/y_train.txt:7352 rows and 1 column
contains train data of activites

3. To creat new data set from test and train data
X data set is created by merging Xtest and Xtrain using rbind () function:10299 rows and 561 columns
Y data set is created by merging Ytest and Ytrain using rbind () function: 10299 rows and 1 columns
Subject data set is created by merging testsubject and trainsubject data using rbind () function:10299 rows and 1 column
Activity data set is created by merging X, Y, and Subject using cbind() function: 10299 rows and 561 columns

4. To extract mean and standard deviation for each measurement
ActivityData data set is created by subsetting Acitivty, where only columns: subject and ID is selected and the measurement on the mean and standard for each measurement is performed.

5. Assign descriptive activity names to name the activities in data set
All the numbers in ID colum of ActivityData is replaced with coresponding activity taken from second column of the activities variables.

6. Appropriate labels with descriptive variable names
ID column in the ActivityData is renamed with activities
All Acc in column names is replaced with Accelerometer
All Gyro in column name is replaced with Gyroscope
All Mag in column name is replaced with Magnitude
All Bodybody in column name is replaced with body
All the coumn name starting with f is repaced with Frequency
All the column name starting with t is replaced with Time

7. to creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData is created by summarizing ActivityData where mean (average) of each variable for individual subject and individual activity created after using group_by subject and activity function 
Export final TidyData into TidyData.txt file



