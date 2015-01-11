## This file should run as long as the Samsung data is in the working directory.

## Require certain packages for working with data.
require(dplyr)

## The data is found in the test and train folders when downloaded.
run_analysis <- function(){
	## Check that the folders with data exists.
	check_files()
}

check_files <- function(){
	## Check that the test and train directories exist. 
	## If they don't, we need to stop as their is no data to analyse.
	if (!file.exists("train") && ! file.exists("test")) {
		stop("Unable to find training and test data")
	}

}

