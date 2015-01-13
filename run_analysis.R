## This file should run as long as the Samsung data is 
## in the working directory.

## Require certain packages for working with data.
require(data.table)
require(dplyr)

## The data is found in the test and train folders when downloaded.
run_analysis <- function(){
	## Check that the folders with data exists.
	check_files()
}

check_files <- function(){
	## Check that the test and train directories exist. 
	## If they don't, we need to stop as their is no data to analyse.
	if (!file.exists("train") && !file.exists("test")) {
		stop("Unable to find training and test data")
	}

}

## Load the data from a given folder into a table.
## Param: folder to load all text data from. This should be relative
## to the current working directory. We only look at the directory
## passed in and don't look recursively.
load_data <- function(folder){
    ## Get the activity labels
    activity_labels <- read.table("activity_labels.txt", 
                                  col.names = c("id", "activity"))
    
    ## Get the features. The data in this file matches the columns
    ## of data in the folder/X_folder.txt file
    features <- read.table("features.txt",
                           col.names = c("id", "feature"))
    
    test_data <- load_folder_data("test", features[,2])
    train_data <- load_folder_data("train", features[,2])
    rbind(train_data, test_data)
}



load_folder_data <- function (folder, features) {
    ## Get the subject data. This will match 
    # folder/subject_folder.txt file
    subjects <- data.table(
        read.table(
            paste(folder,"/subject_",folder,".txt", sep = ""),
            col.names = c("subject")))
    
    ## Get the activity ids that relate to each subject
    activities <- data.table(
        read.table(
            paste(folder,"/y_",folder,".txt", sep = ""),
            col.names = c("activity.id")))
    
    ## Get the data for each subject.
    data <- data.table(
        read.table(
            paste(folder,"/x_",folder,".txt", sep = ""),
            col.names = features))
    
    ## Bind the subject, activity and data into one data frame, 
    ## then return as a data table
    cbind(subjects,activities,data)
}