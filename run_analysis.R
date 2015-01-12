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
load_data <- function(){
    ## Get the activity names
    activity_labels <- read.table("activity_labels.txt", 
                                  col.names = c("id", "activity"))
    
    ## Get the features
    features <- read.table("features.txt",
                           col.names = c("id", "feature"))
    
    features
    
}