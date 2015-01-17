## This file should run as long as the Samsung data is 
## in the working directory.

## Require certain packages for working with data.
require(data.table)
require(dplyr)

## The data is found in the test and train folders when downloaded.
run_analysis <- function(){
	## Check that the folders with data exists.
	check_files()
	
	## Step 1: Merges the training and the test sets to create one data set.
	merged_data <- merge_data()
    
    ## Step 2: Extracts only the measurements on the mean and 
    ## standard deviation for each measurement. 
    ## NOTE: keep subject and activity ID as well.
    expected_measurements <- select(merged_data, 
                                    subject, 
                                    activity.id, 
                                    contains(".mean."), 
                                    contains(".std."))
    
	expected_measurements
}

check_files <- function(){
	## Check that the test and train directories exist. 
	## If they don't, we need to stop as their is no data to analyse.
	if (!file.exists("train") 
	    && !file.exists("test")
	    && !file.exists("activity_labels.txt")
	    && !file.exists("features.txt")) {
        
		stop("Unable to find training and test data")
	}
}

#' Merge the training and test data into one data set
#'
#' @return The merged data from the test and train folders
merge_data <- function(){
    ## Get the activity labels
    activity_labels <- read.table("activity_labels.txt", 
                                  col.names = c("id", "activity"))
    
    ## Get the features. The data in this file matches the columns
    ## of data in the folder/X_folder.txt file
    features <- read.table("features.txt",
                           col.names = c("id", "feature"))
    
    test_data <- merge_folder("test", features[,2])
    train_data <- merge_folder("train", features[,2])
    
    ## Combine the training and test data.
    rbind(train_data, test_data)
}


#' Merge the data from a folder.
#' 
#' @param folder a folder to merge data from. Expected values "test" or "train"
#' @param features A vector of features for the dataset.
#' @return A data.table of combined data from the folder
#' @examples
#' merge_folder("test", c("angle.Z.gravityMean.","angle.Y.gravityMean."))
#' merge_folder("train", c("angle.Z.gravityMean.","angle.Y.gravityMean."))
merge_folder <- function (folder, features) {
    ## Get the subject data and convert to data.table.
    subjects <- as.data.table(
        read.table(
            paste(folder,"/subject_",folder,".txt", sep = ""),
            col.names = c("subject")))
    
    ## Get the activity ids that relate to each subject and convert to data.table.
    activities <- as.data.table(
        read.table(
            paste(folder,"/y_",folder,".txt", sep = ""),
            col.names = c("activity.id")))
    
    ## Get the data for each subject and convert to data.table.
    data <- as.data.table(
        read.table(
            paste(folder,"/x_",folder,".txt", sep = ""),
            col.names = features))
    
    ## Bind the subject, activity and data into one data frame, 
    ## then return as a data table
    cbind(subjects,activities,data)
}