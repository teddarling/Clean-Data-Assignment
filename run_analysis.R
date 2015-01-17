## This file should run as long as the Samsung data is 
## in the working directory.

## Require certain packages for working with data.
require(data.table)
require(dplyr)

## The data is found in the test and train folders when downloaded.
run_analysis <- function(){
	## Check that the folders with data exists.
	check_files()
    
	## Get the activity labels.
	activity_labels <- read.table("activity_labels.txt", 
	                              col.names = c("id", "activity"))
    
	
	## Step 1: Merges the training and the test sets to create one data set.
	data <- merge_data()
    
    message("Converting data")
    
    data %>% 
	    ## Step 2: Extracts only the measurements on the mean and 
	    ## standard deviation for each measurement. 
	    ## NOTE: keep subject and activity ID as well.
        select(subject, 
               activity, 
               contains(".mean."), 
               contains(".std.")) %>%
        
        ## Step 3: Uses descriptive activity names to name the activities in the data set
	    rowwise() %>%
        mutate(activity = get_activity(activity_labels, activity))
    
	
    
    ## Step 3: Uses descriptive activity names to name the activities in the data set
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
    message("Merging data.")
    
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
    subjects <- read.table(
            paste(folder,"/subject_",folder,".txt", sep = ""),
            col.names = c("subject"))
    
    ## Get the activity ids that relate to each subject and convert to data.table.
    activities <- read.table(
            paste(folder,"/y_",folder,".txt", sep = ""),
            col.names = c("activity"))
    
    ## Get the data for each subject and convert to data.table.
    data <- read.table(
            paste(folder,"/x_",folder,".txt", sep = ""),
            col.names = features)
    
    ## Bind the subject, activity and data into one data frame, 
    ## then return as a data table
    cbind(subjects,activities,data)
}

#' Get a descriptive name based on activity id
#' 
#' @param labels, The labels to search through
#' @param activity_id, the id to search in the labels.
#' @return string, the value of the activity, based on the id.
get_activity <- function(labels, activity_id){
    as.character(select(filter(activity_labels, id == activity_id), activity)[1,])
}