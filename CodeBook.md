
CourseProject "run_analysis" CodeBook
=====================================

The project data comes from Human Activity Recognition data set, Which is provided in a download from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

Upon unzipping the data folder zip file, the contained README.txt file describes the data provided.
Here is a high level description: 


> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

# Tidy Data Sets

The purpose of "run_analysis" is to convert some of the raw data found in the data set directories to a "tidy" data set.  The raw data consists of multiple files of related data.  But, the general characteristics of a tidy data set will conform to the following characteristics: 

* each variable measured in one column
* each different observation of variable in different row
* one table for each “kind” of variable
* If have multiple tables, should include a column that allows them to be linked
* Row at top of each file with variable names
* Variable names human readable (not abbrev in general)
* General data should be saved in one file per table

In the case of the "Human Activity Recognition" tidy data, the run_analysis script produces one file with each column a separate metric or control variable.

# Raw data description

The extraction to the working directory will create a relative directory structure like this: 

* UCI HAR Dataset
     + test
          * Inertial Signals
     + train
          * Inertial Signals

The Inertial Signals directories will be ignored.  They appear to contain the original raw data on which further processing was performed to derive the other file data.  See the unzipped "README.txt" and "features_info.txt" for further information about that processing.

The rest of the unzipped files relate to one another in the following fashion: 

(note: X_*.txt below short-hand refers both to test/X_test.txt and train/X_train.txt)

* the "test" and "train" directories and files have the same structure, and contain the two different partions of the data.  One of the goals of our analysis is to combined these back together within the one "tidy" data set.
* The observations are provided by each line of data found in the partitioned ("test" or "train") subject, X_* and y_* text files.  These files have the same number of lines.  
* The "features.txt" file provides a mapping of "feature columns" to "feature names".  The "feature column" values relatively coorespond to the data columns found in the X_*.txt files.  Thus, there are as many rows in the "features.txt" file, as columns found in X_*.txt files. The "feature names" are the metric variables which have been previously derived from the original raw data. 
* The partitioned (test or train) "X_*.txt" file contains the observation values and each column is in relative order to the "feature columns" value from the "features.txt" data.
* The "activity_labels.txt" file relates an "activity id number" (1-6) to an "activity description". The "activity" ids for each observation are found in the "y_*.txt" files.
* The paritioned data "subject_*.txt" rows provide a "subject" number that is the source of each observation.  A subject is not further defined, and just serves to relate the data from the same source individual.

# Data Units

The feature data units reported in the Tidy data set are "mean" values and "standard deviation" values. Both "mean" and "std" have the same units.  Thus, for the sensors provided on Android phones, the accelerometer units are: 

* mean: m/s^2^ (meters per second squared)
* stddev: ms/s^2^ 


# Summary Choices

* The X_*.txt data columns are labeled with the defined column labels from features.txt.  In those labels, the "(" and ")" characters have been removed as unecessary, and because they seemed to cause some processing problems while generating the analysis script.
* prior to combining with other data, the feature name columns are filtered into just those features contain "mean" or "std" in their strings.  Patterns are used to match the feature names, and list of patterns to match are flexibly changable in the script. 
* The activity_labels.txt descriptions are indexed into the y_*.txt data rows to provide a human readable description of the observed activities.  The resulting column is labeled "activity".
* The subject_*.txt column is labeled "subject"
* The observations rows from the three subject_*.txt, X_*.txt and y_*.txt data are column bound into a single row of observations.  
* futher, the observations from the "test" and "train" data sets are then row bound into a single set of observations.
* To produce the final tidy table, the data is "melted" into a "subject" and "activity" distinquished features and value pairs.  The average value for the subject, activity, and feature triads is determined.  The the resuls are cast into a table of subject, activity, and columns for each feature with the average value for that feature.

