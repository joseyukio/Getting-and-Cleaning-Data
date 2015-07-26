Getting and Cleaning Data

This is a Readme file for the Course Project as part of Coursera course
"Getting and Cleaning Data"

As requested by the course this file explains how all of the scripts work 
and how they are connected.

There is only one R script called run_analysis.R
Follow this instructions:
 1- Download the data set from:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
 2- Unzip the file into your working directory.
 
 3- Inside R set the working directory where the unzipped folder is placed.
 
 4- Run the script.
 
 5- At the end a file called tidyData.txt will be created in your working directory.
 
 Notes: 
1- In step 2, I'm considering that only "pure" mean and std are required. 
For instance this kind of measurement "gravityMean" is not considered so
not extracted. By reading the forums of this course I think this is the 
correct interpretation. It's possible to consider the other cases as well.
I excluded them on purpose and the reason is aforementioned.

2- Inertial Signals directory and files from original data set was not used.
There was no requirement for those files.