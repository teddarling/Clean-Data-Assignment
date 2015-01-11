## This file should run as long as the Samsung data is in the working directory.
run_analysis <- function(){
	## Check that the test and train directories exist. 
	## If they don't, we need to stop as their is no data to analyse.
	if (!file.exists("train") && ! file.exists("test")) {
		stop("Unable to find training and test data")
	}
}