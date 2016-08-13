#Codebook

This codebook is associated with the run_analysis.R file written for the course project in the Coursera course "Getting and cleaning data".

The code in run_analysis.R assumes that the data set has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped into the working directory.

##Dataset
The project is using the "Human Activity Recognition Using Smartphones Dataset", version 1.0 from the Smartlab laboratory. The initial large data set consists of data from 30 volunteerns in the age bracket of 19-48 years, each performing six different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

The information provided on each record:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The data is captured 3-dimensionally with an X, Y and Z axis.The data set is split into a training and a test group, with the training group consisting of 70% of the volunteers. 

The files in the data set that will be used in the run_analysis.R script are the following:

###Test data
- X_test.txt *This file contains measurement data*
- Y_test.txt *This file contains six different labels, 1-6 that all answer to an activity that is being performed*
- subject_test.txt *This file contains information on the subject performing the activity and being measured*

###Training data
- X_train.txt *This file contains measurement data*
- Y_train.txt *This file contains six different labels, 1-6 that all answer to an activity that is being performed*
- subject_train.txt *This file contains information on the subject performing the activity and being measured*

##Other
- features.txt *Contains the variable names for the data in the X-files above*
- activity_labels.txt *Contains the names of the acitivities being performed corresponding to the 1-6 labels in the Y-files above*


##Methodology and variables

- After reading the data into R the script merges the test and training measurement data as well as the labels data for the test and training part of the data set. It also labels the column in the *activity* variable as "activity" to make it more intuitive. The script also merges the *subjects* data and names the column in this variable "subject".
- The script then moves on to import the variable names from the features.txt file and assign them to the variables in the *xdata* variable containing the measurement data.
- The next step is to merge the *xdata*, *subject* and *labels* variables throught the cbind() function to get a complete data frame, *alldata*
- As the assignment says to extract only the measurements on the mean and standard deviation, the script goes on to grab (using the ```grep()``` function) all the column names containing mean() or std() and store them in the *meanstd* variable. The next step is to concatenate the *meanstd* variable with the strings "subject" and "activity" in the *newcolumns* variable, and then go on to subset these columns from the *alldata* data frame into the *correctdata* data frame so that we have information on the acitivity and the subject as well as the measurement data, but only for the mean and standard deviation measurements.
- The column names in the *correctdata* then gets cleaned up the be more easily readable and understandable to a reader.
- The next step is to read the **activity_labels.txt** file, containing the different activities corresponding to a number 1-6 in the activity column in the *correctdata* data frame, and then exchange the number in the data frame with the actual activity being performed using the ```factor()``` function.
- Finally, using the ```ddply()``` function from the plyr package, we create a new data frame called *finalTidy* that calculates the mean for each activity and subject as per the assignment instructions. This final tidy data set is then written to file and consists of 180 rows (30 subjects * 6 activities).

##Final data set
The final tidy data set consists of 180 rows and 68 columns, 66 of which are measurements, with the measures being the mean for each subject and activity on the measures grabbed by the run_analysis.R script, which are either means or standard deviations. 
The names of the columns can be obtained by the ```colnames(finalTidy)``` command. The columns have been renamed to make it easier to the reader to understand what each variable is measuring. 

