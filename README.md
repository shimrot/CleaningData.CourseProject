CleaningData.CourseProject
==========================

This repository contains the course project assigned for the "Getting and Cleaning Data" part of the Data Scientist class on "coursera".  

As stated in the assignment directions (https://class.coursera.org/getdata-008/human_grading/view/courses/972586/assessments/3/submissions): 

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 

> 1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

> You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

> Here are the data for the project: 

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

> You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

As such, the main files included with this project are: 

* run_analysis.R : the script to perform analysis on the data set found in the zip file.
* README.md : this file
* CodeBook.md : describes variables with information about the environment and choices used to generate the tidyData
* tidyData.txt : the output from running the run_analysis.R script and capturing the output to a .txt file 


To run

```
# 1st run, 1st extract the contents of the downloaded zip file to the working directory.  
> source(run_analysis.R)
> tidyData -> run_analysis()

# to capture the results to a text file
> write.table(tidyData, file="tidyData.txt", row.names=FALSE)
```


