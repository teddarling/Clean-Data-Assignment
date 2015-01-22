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

Then run
```
run_analysis()
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
  1. the file features.txt is read into a variable (features) so that it can be used for column names when the data from x_foldername.txt is read in. The number of rows in features.txt matches the number of columns in x_foldername.txt
  2. inside each folder, the files foldername/x_foldername.txt, foldername/y_foldername.txt and foldername/subject_foldername.txt are combined (where foldername is either train or test).
  3. After the data is read from each folder, the rows of each dataset are combined into a single dataset.
  4. I add a row column which will be used when re-arranging data later. Without, functions like separate and spread throw errors.

3. After merging all the data into a single dataset, I then remove columns that don't include subject (from foldername/subject_foldername.txt), activity (from foldername/y_foldername.txt) and .mean... or .std... (we want the mean and standard deviation only and no other fields. Since Magnitude with Mean or Standard Deviation is calculated and not from the sensors, I've removed those values as well only keeping .mean... and .std... from the columns that were created from foldername/x_foldername.txt file.

4. With the rows removed, I now convert the values in the activity column to a string value using the data found in activity_labels.txt from the working directory.

5. Next, I clean the data and name all my new columns with names that show what they are about. The steps for cleaning the data are as follows:
  1. do some text replacing. I replace fbody, tGravity and tBody with values that are easier to seperate in future steps.
  2. I take all of the measurements (every column except row, subject and activity) and gather them into a single column called domain_signals (names came from reading the documents with the dataset).
  3. Now I seperate the axis (X, Y, or Z) from the column into it's own column as it is helps determine a separate measurement variable.
  4. Then I separate out the calculation that this row measures (mean or standard deviation) into it's own column. The reason is that it will be turned into a variable for the measurement.
  5. Now I spread the calculation column I just created so that I can see mean and standard deviation for a domain and sensor together.
  6. Next, I split the domain_signals column into domain (time or frequency) and signal_sensor.
  7. I then split signal_sensor into the signal (body or gravity) and the sensor (Acc, Gyro, AccJerk, etc...)

6. Now I summarize the mean and standard deviation by grouping on subject, activity, domain, signal, sensor and axis to get the average mean and standard deviation. This is the final data set.


## Original Dataset
The original dataset can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Source
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.