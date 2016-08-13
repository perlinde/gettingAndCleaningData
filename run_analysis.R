library(data.table) #Load required packages
library(plyr)

#This code assumes that the file downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#has been unzipped into your working directory with all file names intact.


#Read test data
test <- fread("test/X_test.txt") #This file contains measurement data
testlab <- fread("test/Y_test.txt") #This file contains six different labels, 1-6 that all answer to an activity that is being performed.
test_subjects <- fread("test/subject_test.txt") #This file contains information on the subject performing the activity and being measured.

#Read training data
train <- fread("train/X_train.txt") #This file contains measurement data
trainlab <- fread("train/Y_train.txt") #This file contains six different labels, 1-6 that all answer to an activity that is being performed.
train_subjects <- fread("train/subject_train.txt") #This file contains information on the subject performing the activity and being measured.

#Merge training and testing data sets
xdata <- rbind(test, train)

#Merge labels for training and testing data and name the variable "activity"
labels <- rbind(testlab, trainlab)
names(labels) <- c("activity")

#Merge subject data and name variable "subject"
subjects <- rbind(test_subjects, train_subjects)
names(subjects) <- c("subject")

#Import variable names
features <- fread("features.txt") 

#Use the columns named V2 in the variable "features"" to name the columns in xdata
names(xdata) <- features$V2

#Merge columns to get a complete data frame
alldata <- cbind(xdata, subjects, labels)

#Grab column names for columns including mean() or std () as per the assignment, these are the columns to use for our final tidy data set
meanstd <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

#Concatenate the grabbed columns with the column names "subject" and "activity" for our final data set. 
newcolumns <-c(as.character(meanstd), "subject", "activity" )

#Subset the large data set using the column names above in variable newcolumns to get only the columns we are interested in.
correctdata <- subset(alldata,select=newcolumns)

#Clean up variable names to make the variables more understandable and descriptive to the reader
names(correctdata) <- gsub("^t", "time", names(correctdata))
names(correctdata) <- gsub("Acc", "Accelerometer", names(correctdata))
names(correctdata) <- gsub("-mean", "Mean", names(correctdata))
names(correctdata) <- gsub("-std", "Std", names(correctdata))
names(correctdata) <- gsub("()-X", "X", names(correctdata))
names(correctdata) <- gsub("()-Y", "Y", names(correctdata))
names(correctdata) <- gsub("()-Z", "Z", names(correctdata))
names(correctdata) <- gsub("^f", "frequency", names(correctdata))
names(correctdata) <- gsub("Gyro", "Gyroscope", names(correctdata))
names(correctdata) <-gsub("Mag", "Magnitude", names(correctdata))
names(correctdata) <-gsub("BodyBody", "Body", names(correctdata))

#Read activity labels corresponding to the numbers 1-6 in the labels variable
activityLabels <- fread("activity_labels.txt")

#Exchange the label numbers (1-6) with the actual activity being performed
correctdata$activity <- factor(correctdata$activity, labels=activityLabels$V2)

#Create new tidy dataset ordered by subject and activity with the mean calculated for each activity and subject
finalTidy <- ddply(correctdata, .(subject, activity), function(x) colMeans(x[, 1:66]))

#Write final tidy data set to file
write.table(finalTidy, "finalTidy.txt", row.name=FALSE)

