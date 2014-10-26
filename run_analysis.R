# Cleaning Data Course Project

# create  R script which does the following:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

run_analysis <- function()
{
    # make sure dependent libraries are loaded
    library(reshape2)
    
    # accomplish steps 1-4 above
    data <- MergeDataSets()
    
    # melt data
    idLabels = c("subject", "activity")
    measureLabels = names(data)[!(names(data) %in% idLabels)]  # keep only names not in idLabels    
    dataMelt <- melt(data, id=idLabels, measure.vars=measureLabels)
    
    # cast frame into tidy data set
    formulaA <- paste(idLabels, collapse="+")
    formulaA <- paste(formulaA, " ~ variable", sep="")
    #dataMelt$activity <- levels(dataMelt$activity)[dataMelt$activity]
    #dataMelt$variable <- levels(dataMelt$variable)[dataMelt$variable]
    tidyData <- dcast(dataMelt, formulaA, mean)
}


# 1) Merge training and the test sets to create one data set.
# 2) extract only the mean and std deviation for measurements
# 3) Using the activity descriptions from activity_labels.txt file
# 4) Labels data set with features.txt labels and adds subject and activity labels
MergeDataSets <- function()
{
    # get test data collection
    subject <- ImportDataFile("subject", "test")
    colnames(subject) <- "subject"
 
    features2Keep <- c("*mean*", "*std*")
    X <- GetXFrame("test", features2Keep)
    activities <- GetActivitySet("test")
    
    testData = cbind(subject, activities, X)  # combine columns
    
    # get training data collection
    subject <- ImportDataFile("subject", "train")
    colnames(subject) <- "subject"
    
    X <- GetXFrame("train", features2Keep)
    activities <- GetActivitySet("train")
    
    trialData = cbind(subject, activities, X) # combine columns
    
    # bind test and train data into one set of rows
    data <- rbind(testData, trialData)
    
}


# -- featurePatterns: list of full or partial feature strings to extract (e.g. c("*mean*","*std*"))
GetXFrame <- function(volunteerSet, featurePatterns)
{
    f <- ImportDataFile("features")
    pattern <- glob2rx(paste(featurePatterns,collapse="|"))
    features2Keep <- subset(f, grepl(pattern, f[,2]))

    x <- ImportDataFile("X", volunteerSet)
    x <- x[,features2Keep[,1]]      # just keep the selected columns
    
    # get colnames and massage by removing () chars from names to keep R happy in other places
    cnames <- levels(features2Keep[,2])[features2Keep[,2]]  # get factor original values
    cnames <- gsub("\\(|\\)", "", cnames)
    
    colnames(x) <- cnames # now assign massaged names to columns
    x
}


GetActivitySet <- function(volunteerSet)
{
    activityLabels <- ImportDataFile("activity_labels")
    y <- ImportDataFile("y", volunteerSet)
    y <- factor(y[,1], levels=activityLabels[,1], labels=activityLabels[,2])
    y <- data.frame(activity=y)
}


# import file contents as a data.frame (no headers in file)
ImportDataFile <- function(fileName, volunteerSet="", subDir="")
{
    # old stuff I wish to keep to remind me
    # con <- file(GetFilePath(fileName, volunteerSet, subDir), "rt")
    # data <- readLines(con)
    # close(con)

    data <- read.table(GetFilePath(fileName, volunteerSet, subDir), header=FALSE, sep="" )
}

# Build the filepath for given
# -- the volunteer set name "test" or "train" or blank
# -- the base file name: X,Y,subject,...
# -- subDir: blank or "Inertial Signals"
GetFilePath <- function(fileName, volunteerSet, subDir)
{
    if (volunteerSet != "") namesep <- "_"
    else                    namesep = ""
    
    file <- paste(fileName, namesep, volunteerSet, ".txt", sep="")
    filePath <- paste(".", "UCI HAR Dataset", volunteerSet, subDir, file, sep="\\")
}
