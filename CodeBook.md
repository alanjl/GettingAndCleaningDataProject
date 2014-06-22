CodeBook
========


Variables
---------

1. Activity  
This is a factor with the following levels: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING.

2. Subject
This is the integer id of the subject performing the activities.  
There are 30 subject ids.  The values range from 1 to 30.

3. Variables 3 to 81  
These are based on the variables supplied in the project dataset.  The names and values of theses variables is detailed below.

Names: These are based on the features given in the original data set [2].  
The original feature labels from features.txt have been processed to remove R-language special characters.  The approach taken is to make the variable names 'camelCase' text. E.g. tBodyAccMeanX.  Note that the source data is already a mean or a standard deviation, and we take the mean of those values.  This is not indicated in the variable names for simplicity, and to avoid cluttering the column names in the data set.  The original naming convention is thus kept intact.

Values: numerical, in the range [-1,1]  
The values in the variables are the average of each (source) variable for each activity and each subject.  The values are thus the average of the mean, and the averge of the standard deviation of the individual source variables.  N.b. only mean and std variables were extracted from the original data set.

This is the complete list of variables contained in the data set.  

[1] "activity"                     "subject"                      "tBodyAccMeanX"               
 [4] "tBodyAccMeanY"                "tBodyAccMeanZ"                "tBodyAccStdX"                
 [7] "tBodyAccStdY"                 "tBodyAccStdZ"                 "tGravityAccMeanX"            
[10] "tGravityAccMeanY"             "tGravityAccMeanZ"             "tGravityAccStdX"             
[13] "tGravityAccStdY"              "tGravityAccStdZ"              "tBodyAccJerkMeanX"           
[16] "tBodyAccJerkMeanY"            "tBodyAccJerkMeanZ"            "tBodyAccJerkStdX"            
[19] "tBodyAccJerkStdY"             "tBodyAccJerkStdZ"             "tBodyGyroMeanX"              
[22] "tBodyGyroMeanY"               "tBodyGyroMeanZ"               "tBodyGyroStdX"               
[25] "tBodyGyroStdY"                "tBodyGyroStdZ"                "tBodyGyroJerkMeanX"          
[28] "tBodyGyroJerkMeanY"           "tBodyGyroJerkMeanZ"           "tBodyGyroJerkStdX"           
[31] "tBodyGyroJerkStdY"            "tBodyGyroJerkStdZ"            "tBodyAccMagMean"             
[34] "tBodyAccMagStd"               "tGravityAccMagMean"           "tGravityAccMagStd"           
[37] "tBodyAccJerkMagMean"          "tBodyAccJerkMagStd"           "tBodyGyroMagMean"            
[40] "tBodyGyroMagStd"              "tBodyGyroJerkMagMean"         "tBodyGyroJerkMagStd"         
[43] "fBodyAccMeanX"                "fBodyAccMeanY"                "fBodyAccMeanZ"               
[46] "fBodyAccStdX"                 "fBodyAccStdY"                 "fBodyAccStdZ"                
[49] "fBodyAccMeanFreqX"            "fBodyAccMeanFreqY"            "fBodyAccMeanFreqZ"           
[52] "fBodyAccJerkMeanX"            "fBodyAccJerkMeanY"            "fBodyAccJerkMeanZ"           
[55] "fBodyAccJerkStdX"             "fBodyAccJerkStdY"             "fBodyAccJerkStdZ"            
[58] "fBodyAccJerkMeanFreqX"        "fBodyAccJerkMeanFreqY"        "fBodyAccJerkMeanFreqZ"       
[61] "fBodyGyroMeanX"               "fBodyGyroMeanY"               "fBodyGyroMeanZ"              
[64] "fBodyGyroStdX"                "fBodyGyroStdY"                "fBodyGyroStdZ"               
[67] "fBodyGyroMeanFreqX"           "fBodyGyroMeanFreqY"           "fBodyGyroMeanFreqZ"          
[70] "fBodyAccMagMean"              "fBodyAccMagStd"               "fBodyAccMagMeanFreq"         
[73] "fBodyBodyAccJerkMagMean"      "fBodyBodyAccJerkMagStd"       "fBodyBodyAccJerkMagMeanFreq" 
[76] "fBodyBodyGyroMagMean"         "fBodyBodyGyroMagStd"          "fBodyBodyGyroMagMeanFreq"    
[79] "fBodyBodyGyroJerkMagMean"     "fBodyBodyGyroJerkMagStd"      "fBodyBodyGyroJerkMagMeanFreq"

Data
----
The data given in each variable instance is a mean of a variable that is already a mean or a standard deviation.  These are thus average of averages, and average of standard deviations of the underlying variable.  The average mean X, or average standard deviation X, where X is the underlying variable.

For example, the variable labelled 'tBodyAccMeanX' is the mean of the mean body acceleration in X dimension.  The labelling could have been mean(tBodyAccMeanX), however that would have cluttered the column names without providing more information.

Units: 


Transformations
---------------

1. Activities.
The original integer ids used for the activities have been transformed into factors using the mapping table given in activity_labels.txt

2. Aggregation.
The original data set has been summarised by activity and subject.  The mean is provided for each variable according to the activity,subject grouping.

Why the data is Tidy
--------------------

The following is taken from Hadley Wickham's paper [1] 'Tidy Data'.  This defines what tidy data is.

>2.3. Tidy data  
>Tidy data is a standard way of mapping the meaning of a dataset to its structure. A dataset is  
>messy or tidy depending on how rows, columns and tables are matched up with observations,  
>variables and types. In tidy data:  
>1. Each variable forms a column.  
>2. Each observation forms a row.  
>3. Each type of observational unit forms a table.  

The data provided in the TidyData.txt file is tidy as per the definition given above.
Each column in the dataset represents one variable.  
Each row in the dataset forms an observation of the mean of the mean and the mean of the standard deviation of the original variable taken from the source dataset.  
There is only type of observational unit in the data set provided, representing a set of means on the source data.



References
----------
[1] Hadly Wickam, Journal of Statistical Software. 'Tidy Data'  
[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012