## 
#
# Notes: 
# 1. Inertial signal files are ignored here.  These have already been heavily processed
#   to produce the X_test and X_train data sets.  Further processing of these is outside the 
#   scope of this project.

# Preliminary step: retrieve the data from the Coursera site & extract with R script.
# It is not explicit wether or not this step is required to be automated. I assume automated download
# is not required. So, I use manually downloaded data.

##
## Get the test dataset
##

# read the subject test data set
# this contains the subject id for each row of data (observation)
subjectTest <- read.table("./data/test/subject_test.txt")

# read the X_test data
# this contains the interesting data
X_test <- read.table("./data/test/X_test.txt")

# read the numeric labels for the dataset
# These are the activity ids.
activityTest <- read.table("./data/test/y_test.txt")

# read the activities id => label mapping
activities <- read.table("./data/activity_labels.txt")

# read the subject training data set
# this contains the subject id for each row of data (observation)
subjectTrain <- read.table("./data/train/subject_train.txt")

# read the X_train data
# this contains the interesting data
X_train <- read.table("./data/train/X_train.txt")

# read the numeric lables for the dataset
# These are the activity ids.
activityTrain <- read.table("./data/train/y_train.txt")

##
## Merge the data frames into one 
##
# Requirement 1.
# Merge the training and test sets to produce one data set.

# combine the X_test and X_train into one data frame
X_all <- rbind(X_test, X_train)

# combine the subject ids from the test and train data sets.
subject <- rbind(subjectTest, subjectTrain)

# combine the activity ids from the test and train data sets.
activity <- rbind(activityTest, activityTrain)

##
## At this point we have all of the data required to make one large data frame.
## But, first we want to extract only the variables/features that have a mean 
## or standard deviation in the name.
##

# Requirement 2.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# read the features.  These are the descriptive variable names.  
# They need to be processed further.  This set includes meanFreq.
features <- read.table("./data/features.txt")
extractIndex <- c(grep("-mean", features$V2),grep("-std", features$V2))
extractIndex <- sort(extractIndex) # make the columns tidy - in order.
X_extract <- X_all[,extractIndex]

# Requirement 3.
# Use descriptive activity names to name the activities in the data set.
#   make a factor variable based on the activity ids of subjectTest
#   the levels are 1:6 as per the first column of the activities file
#   the labels are the textual descriptions as per the activities file
#   store the result in the data frame
t1 <- as.factor(activities$V2)
all_factors <- factor(activity$V1,levels=1:6,labels=t1,ordered=FALSE)


# Requirement 4.
# Appropriately label the data set with descriptive variable names
# 
extract_features_df <- features[extractIndex,]

# change the comma on the group ranges to the character 'a' 
# this is similar to the use in some European languages (without the accent character)
# the meaning is a number range.  E.g. 12 a 16 , means 12 to 16.
# This is a convenient encoding for variable names in R.

# transform number ranges
tmp <- extract_features_df$V2

# remove parentheses
tmp <- gsub("\\(","", tmp)
tmp <- gsub("\\)","", tmp)

# Remove hyphens, and uppercase any following letter
tmp <- gsub("[-]([a-zA-Z])","\\U\\1", tmp, perl=TRUE)

# Set the edited features as the column names.
# This fullfills step 4 of the requirements
colnames(X_extract) <- tmp

# Set the subject column
X_extract$subject <- subject$V1

# Set the activity column
X_extract$activity <- all_factors

# Requirement 5.
# Create a second independent tidy data set with the average of each variable 
# for each activity and each subject.  N.b.  Scope here is the extracted data set.
# Additional columns are not included as there is no further use required.
# 5.1 make the tidy data set.
colnames(X_extract)
aggExtract <- aggregate(.~activity+subject, FUN=mean, data=X_extract)

# 5.2 write the tidy data set to a file.
write.table(aggExtract,"./TidyData.txt")

