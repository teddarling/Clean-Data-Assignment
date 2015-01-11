# Getting and Cleaning Data

This repo is for a course project that works on getting and cleaning data, getting it ready for analysis.

To get started, either clone this repo, or using the _Download Zip_ button to the right, download this repository and unzip to where ever you wish.

## Getting the Data for Analysis

The data that this R script will analyse, can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

To get started, download the data and unzip it to a folder of your choosing.

## Running the Analysis

To work with the dataset that you have downloaded, start your R environment and set your working directory to the directory created when you unzipped your data. Ensure that you have installed the packages listed under _Required Packages_.

Once you have confirmed that you have the required packages, you can use run_analysis.R script to analyse the data. To start, run:
```
source("path_to_unzipped_dir/run_analysis.R")
```

### Required Packages

Before your run this analysis, please ensure that you have installed the below required packages.

* dplyr 
  * install.packages("dplyr")

## About the Code

This section will take you through how the code works.

1. The first step is to ensure that the folders "test" and "train" exist. If they don't then their is no data to process and we stop with a message indicating such.


## Original Dataset
The original dataset can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Source
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.