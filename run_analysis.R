## This file should run as long as the Samsung data is 
## in the working directory.

## Require certain packages for working with data.
require(dplyr)
require(tidyr)

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
	    ## 3 dots excludes Magnitude. Since magnitude isn't an actual measurement,
        ## I am eliminating it for mean and standard deviation.
        select(row,
               subject, 
               activity, 
               contains(".mean..."), 
               contains(".std...")) %>%
        
        ## Step 3: Uses descriptive activity names to name the activities in the data set
	    rowwise() %>%
	    mutate(activity = get_activity(activity_labels, activity)) %>%
        
        ## Step 4: Appropriately labels the data set with descriptive variable names.
	    clean_data() %>%
        
        ## Save the tidy dataset
        save_tidy_data() 
        
        ## Step 5: From the data set in step 4, creates a second, independent tidy data 
        ## set with the average of each variable for each activity and each subject.
        
        
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
    data <- rbind(train_data, test_data)
    
    ## Add distinct row number to rows. This will help to uniquely identify observation.
    data$row <- 1:nrow(data)
    
    data
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

clean_data <- function(data){
    columns <- names(data)
    
    column_names <- gsub("fBody", "frequency-body-", 
         gsub("tGravity", "time-gravity-",
              gsub("tBody", "time-body-", columns)))
    
    colnames(data) <- column_names
    
    data %>% 
        ## Every column, except row, subject and activity, is a measurement.
        gather(domain_signals, measurement, -c(subject, activity, row), na.rm = TRUE) %>%
        
        ## Next, separate the axis from the domain signal.
        separate(domain_signals, into = c("domain_signals", "axis"), sep = "\\.{3}", extra = "merge") %>%
        
        ## Separate the calculation from the domain signal
        separate(domain_signals, into = c("domain_signals", "calculation"), sep = "\\.", extra = "merge") %>%
        
        ## Next, spread the mean and standard deviation into their own columns
        spread(calculation, measurement) %>% 
        
        ## Separate the domain from the signal.
        separate(domain_signals, into = c("domain", "signal_sensor"), sep = "-", extra = "merge") %>%
        
        ## Separate the sensor from the signal.
        separate(signal_sensor, into = c("signal", "sensor"), sep = "-", extra = "merge") %>%
        
        select(-row)
}

#' Using the existin column names, make them more desctiptive and clean
#' 
#' @param data, The data to alter the column names of
#' @return the data with updated column names


#' Create tidy dataset for the assignment.
#' 
#' @param data, the data frame to create the files from
#' @return the data that was passed in.
save_tidy_data <- function(data){
    message("Saving tidy data")
    
    folder <- "output"
    
    fileName <- paste(folder,"/smart_phone_data.txt", sep = "")
    
    ## See if the output directory exists, if it doesn't, create it.
    if (!file.exists(folder)){
        dir.create(folder)
    }
    
    ## Write the tidy dataset
    write.table(data, file = fileName, row.names = FALSE)
    
    data
}