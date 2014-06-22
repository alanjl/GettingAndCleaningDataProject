ReadMe 
======

This markdown explains my run_analysis.R script for the Getting and Cleaning Data project.

Overall Approach
----------------
The approach follows the 5 step outline given in the instructions for the project. Some parts
of the steps are implemented out of order, as following the outline exactly results in some issues for the approach that I have taken, e.g. lost columns for activity and subject.

1. Take X_test and X_train data files and read them into data frames with the same names
2. Extract the variable (columns) that have 'mean' or 'std' in their names.
3. Add descriptive names to the activities.  For this I have used the content of the activity_labels.txt file to produce factors.  The levels of the factor correspond with the order of the labels, so this is straight-forward.
4. Add descriptive variable names.  This is based on the content of the features.txt file.  First read the file into a data frame.  Grep is used to produce names that match the 'mean' and 'std' strings. The Gsub function is used to remove and modify unwanted characters such as '-', '(' and ')'.  The Gsub function is used with the perl=TRUE option to remove '-' and uppercase the next word in the string.  That allows for 'CamelCase' variable names.
5. Create a second independant tidy dataset with the average of each variable for each activity and each subject.  Here the aggregate function is used.  This produces the desired result in one line of code.  This relies on the activities being a factor, and on the subject ids being coerced to a factor.

Detailed Explanation
--------------------

 Notes: 
 1. Inertial signal files are ignored here.  These have already been heavily processed
   to produce the X_test and X_train data sets.  Further processing of these is outside the 
   scope of this project.
   
 2. The following is the actual code of my run_analysis.R with comments.  This has been formatted to suit markdown.
 
 Convention: this is some comment about the code.
 >this.is.an <- example.of.code()  

Preliminary step: retrieve the data from the Coursera site & extract with R script, and expand in the working directory. The submission instructions say that the script can assume the data is in the working directory. So automated download is not required.

Get the test dataset
read the subject test data set
this contains the subject id for each row of data (observation)
>subjectTest <- read.table("./data/test/subject_test.txt")

read the X_test data
this contains the interesting data
>X_test <- read.table("./data/test/X_test.txt")

read the numeric labels for the dataset
These are the activity ids.
>activityTest <- read.table("./data/test/y_test.txt")

read the activities id => label mapping
>activities <- read.table("./data/activity_labels.txt")

read the subject training data set
this contains the subject id for each row of data (observation)
>subjectTrain <- read.table("./data/train/subject_train.txt")

read the X_train data
this contains the interesting data
>X_train <- read.table("./data/train/X_train.txt")

read the numeric lables for the dataset
These are the activity ids.
>activityTrain <- read.table("./data/train/y_train.txt")


Merge the data frames into one 

Requirement 1.
Merge the training and test sets to produce one data set.

combine the X_test and X_train into one data frame
>X_all <- rbind(X_test, X_train)

 combine the subject ids from the test and train data sets.
>subject <- rbind(subjectTest, subjectTrain)

 combine the activity ids from the test and train data sets.
>activity <- rbind(activityTest, activityTrain)


 At this point we have all of the data required to make one large data frame.
 But, first we want to extract only the variables/features that have a mean 
 or standard deviation in the name.

Requirement 2.
 Extracts only the measurements on the mean and standard deviation for each measurement. 
 read the features.  These are the descriptive variable names.  
 They need to be processed further.  This set includes meanFreq.
>features <- read.table("./data/features.txt")  
>extractIndex <- c(grep("-mean", features$V2),grep("-std", features$V2))  
>extractIndex <- sort(extractIndex)  make the columns tidy - in order.  
>X_extract <- X_all[,extractIndex]  


 Requirement 3.
 Use descriptive activity names to name the activities in the data set.
   make a factor variable based on the activity ids of subjectTest
   the levels are 1:6 as per the first column of the activities file
   the labels are the textual descriptions as per the activities file
   store the result in the data frame
>t1 <- as.factor(activities$V2)
>all_factors <- factor(activity$V1,levels=1:6,labels=t1,ordered=FALSE)


 Requirement 4.
 Appropriately label the data set with descriptive variable names
 
>extract_features_df <- features[extractIndex,]

 change the comma on the group ranges to the character 'a' 
 this is similar to the use in some European languages (without the accent character)
 the meaning is a number range.  E.g. 12 a 16 , means 12 to 16.
 This is a convenient encoding for variable names in R.

 transform number ranges
>tmp <- extract_features_df$V2

 remove parentheses.  
>tmp <- gsub("(","", tmp)  
>tmp <- gsub(")","", tmp)  

 Remove hyphens, and uppercase any following letter
 Please see run_analysis.R line 101.  
 I can't get the escape sequence working with markdown yet, so you need to see the original.
>tmp <- gsub("[-]([a-zA-Z])","U1", tmp, perl=TRUE)  

 Set the edited features as the column names.
 This fullfills step 4 of the requirements
>colnames(X_extract) <- tmp

 Set the subject column
>X_extract$subject <- subject$V1

 Set the activity column
>X_extract$activity <- all_factors

 Requirement 5.
 Create a second independent tidy data set with the average of each variable 
 for each activity and each subject.  N.b.  Scope here is the extracted data set.
 Additional columns are not included as there is no further use required.  
 5.1 make the tidy data set.
>aggExtract <- aggregate(.~activity+subject, FUN=mean, data=X_extract)

 5.2 write the tidy data set to a file.
>write.table(aggExtract,"./TidyData.txt")


Test read the tidy data set
---------------------------
To read the data set from the text file TidyData.txt, save the file from my repo to a local folder and execute the following command in R.  The working directory must be the same as the location of the file.

tidyData <- read.table("./TidyData.txt", header=TRUE)







