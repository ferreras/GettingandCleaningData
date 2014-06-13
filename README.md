Getting and Cleaning Data
========================================================

# Introduction

The objective of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The results of this Course Project is to generate a file with the clen data (*"tidyData.csv"*), the R script which performs the analysis (*"run_analisys.R"*), a *"Codebook.md"* file with the data of all the variables and summaries calculated, along with units, and finally this *"README.md"* 


# Requisites

The file with all the data, *[getdata_projectfiles_UCI HAR Dataset.zip](
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)* has been dowloaded and unzipped in the working directory.

At the beginning of the script, the library *reshape2* is loaded, because it is needed for the functions *melt()* and *dcast*

# Procedure

## Read variable data
First, we read the vector of strings (**features**) with the name of the measured variables.

Then, we read variable data from the files *X_train.txt* and *X_test.txt* with the function **read.table()**, no header and set the column variable names with the vector of strings **features**, previously read.

we extract only the variables cointaining "mean" and "std" measures. Attending at the names of the variables, we use the function **grep()** to create a vector of strings with the selected variables.

Finally extract the selected variable data, and join them to create the variable **x**, with the function **rbind()**.

## Read activity data
Read the activity data frame, **act** with the numbers and names of the activity data from the file *"activity_labels.txt"*.

Read both the activities from the file *y_train.txt* and *y_test.txt*, factorice then according to **act**, and join both activities into the data.frame **y**, with the proper name of the column: "activity".

## Read subject data
Read both the activities from the file *subject_train.txt* and *subject_test*, and set the column name "subject"

Join both activities with the function **rbind()**, factorice then according to their value in to 30 levels (subject number) and add an additional factoriced column with the type, "TRAIN" and "TEST", of the subject.  **s** is the resulting data.frame (named "type").

## Merge all the data
With *cbind()* we join the three data.frames, **s**, **y** and **x**, into  a new data.frame called **total**

## Create a tidy data sets
First we select the variables with the "mean" and "std" data. So, we grep the vector of variable names, **cols**.

We use the *melt()* function, selecting as variables the proper mean- and std- columns, and store the 3 column data.frame in **totaMelt**

Finally, **dcast()** the *variable* column, calculating the **mean()** value of each of the subsets, into **totalTidy** data.frame.

## Save results
Save the data.frame **totalTidy** into the file *tidyData.csv*
