# Coursera Getting and Cleaning Data course project

This dataset uses data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The purpose of this project was to demonstrate my ability to collect, work with, and clean a data set. The goal was to prepare tidy data that can be used for later analysis.

## The dataset

The dataset aggregates measurements for the different patients and activities and calculates the man of every variable.
Each row in the dataset contains one line for each combination of patient/activity and the means for all variables.

## The script

The file `run_anlysis.R` is able to replicate all the steps I took.
The script assumes there is a file called `getdata-projectfiles-UCI HAR Dataset.zip` in the current directory.
It then loads the files that describe the features and the activity labels.

Then, for the test set it loads the measurements and properly labels the variables.
It then augments it with the activity and subject information

This process is repeated for the train set which is subsequently merged into the test set.

Finnaly, it uses `ddply` ( from the plyr library ) to calculate the column means over the data frame factored by Subject and Activity.

The resulting data.frame is saved to `tidy.csv`.
