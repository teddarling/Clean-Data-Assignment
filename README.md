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
* tidyr
  * install.packages("tidyr")

## About the Code

This section will take you through how the code works.

1. First I check that the folders and files that should be in the working directory are there. The files that should be in the working directory can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

2. Once I ensure that the files exist, I then begin to combine the files that are needed. These files are found in the folders /train and /test.
  A. the file features.txt is read into a variable (features) so that it can be used for column names when the data from x_foldername.txt is read in. The number of rows in features.txt matches the number of columns in x_foldername.txt
  B. inside each folder, the files foldername/x_foldername.txt, foldername/y_foldername.txt and foldername/subject_foldername.txt are combined (where foldername is either train or test).
  C. After the data is read from each folder, the rows of each dataset are combined into a single dataset.




## Original Dataset
The original dataset can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Source
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.