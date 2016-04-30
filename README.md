# Getting and Cleaning Data Course Project - tidydataproject

This repository is for the Getting and Cleaning Data Course Project for Coursera which aims to practice collecting, manipulating and cleaning data.

You will find the ff. files in the repository:

1. run_analysis.R - a script that run an analysis on data collected from the accelerometers from the Samsung Galaxy S smartphone. Information on how to run this script can be found in detail in the section below
2. tidydata.csv - sample output of run_analysis.R
3. Codebook.md - a reference for all the variables found in the output data as well as details on how it was transformed from its sources

### How to run the analysis using run_analysis.R

1. Download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Ensure that the file is in your working directory for R. There is no need to unzip the file.
3. Call run_analysis(x = "<your zipfile name>") from your R console. If you run the function without providing any arguments, it sets the zipfile name to "getdata-projectfiles-UCI HAR Dataset.zip"
3. Check the results of the function in the tidydata.csv file produced in your working directory.