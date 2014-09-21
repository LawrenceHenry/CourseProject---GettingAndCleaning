CourseProject---GettingAndCleaning
==================================

Holds the Course Project for The Getting and Cleaning Data Coursera Course

This repository holds the script (run\_analysis.R) that builds the tidydata file that corresponds to the CookBook.Rmd which describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

You will need the raw data files located at the location specified by the URL below in order for the script to function.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Once loaded and unzipped, you can execute the run\_analysis.R script located in the repository from within R Studio by loading and invoking the `run_analysis()` function.  

Please make sure your working directory is set to the level above the UCI HAR Dataset directory which will be created when you unzip the dataset.  **The script assumes the working directory is the parent directory of UCI HAR Dataset directory.** (hint: *use the `getwd()` and `setwd()` commands in the R Studio console.*)

The output file *MeansBySubjectAndActivity.txt* will be produced in the working directory after the script successfully completes.
