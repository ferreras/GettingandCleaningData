# Getting and Cleaning Data - Course Project
# June 2014

# REQUISITE
library(reshape2) 

# READ VARIABLE DATA
# Read 561 Variable Data Names
features <- scan(".//UCI HAR Dataset//features.txt", what=character(),
                 sep="\n", quiet = TRUE) # Nombres de columnas

# Read variable data and name the variables
x_test <- read.table(".//UCI HAR Dataset//test//X_test.txt", header=FALSE, 
                      colClasses="numeric", col.names = features)
x_train <- read.table(".//UCI HAR Dataset//train//X_train.txt", header=FALSE,
                       colClasses="numeric", col.names = features)

# Extract only variables "mean" and "std"
cols = names(x_test)[grep("mean|std",names(x_test))]

# Join both data sets, only the selected columns
x <- rbind(x_train[,cols],x_test[,cols])

# READ ACTIVITY DATA
# Read Activity data, use descriptive names and merge into one column
act <- read.table(".//UCI HAR Dataset//activity_labels.txt", header=FALSE)
y_train <- read.table(".//UCI HAR Dataset//train//y_train.txt", header=FALSE, 
                       colClasses="integer", col.names="activity")
y_test <- read.table(".//UCI HAR Dataset//test//y_test.txt",
                      header=FALSE, colClasses="integer", col.names="activity")
y <- transform(rbind(y_train, y_test), 
               activity=factor(activity, levels=c(1:6), labels=act[,2]))

# READ SUBJECT DATA
# Read subject indentifier and merge them
s_train <- read.table(".//UCI HAR Dataset//train//subject_train.txt",
                      header=FALSE, colClasses="integer", col.names="subject")
s_test <- read.table(".//UCI HAR Dataset//test//subject_test.txt",
                     header=FALSE, colClasses="integer", col.names="subject")    
s <- transform(rbind(s_train, s_test), 
               subject=factor(subject),
               type = factor(c(rep("TRAIN",length(s_train$subject)),
                               rep("TEST",length(s_test$subject))),
                             levels=c("TRAIN","TEST"),
                             labels=c("TRAIN","TEST")))

# MERGE ALL THE DATA
# Subject, activity and vars
total <- cbind(s, y, x)

## CREATE A TIDY DATA SET
# Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 

totalMelt <- melt(data=total,id=c("subject","activity", "type"), measure.vars=cols)

totaltidy <- dcast(totalMelt, subject + activity + type ~ variable, mean)

# SAVE RESULTS
write.csv(totaltidy,file=".//tidyData.csv")

