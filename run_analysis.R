library(dplyr)

# Reading the train Data
Xtrain <- read.table("./UCI HAR Dataset/train/x_train.txt")
Ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
SubTrain  <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# reading test data
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
SubTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
	
# reading the description of the data
varNames <- read.table("./UCI HAR Dataset/features.txt")

# reading the activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# creating one data set by merging training and data set.
XTotal <- rbind(Xtrain, Xtest)
YTtotal <- rbind(Ytrain, Ytest)
SubTtotal <- rbind(SubTrain , SubTest)

# 2. Extracting only the measurements on the found mean and standard deviation for each #measurement.
selectedVar <- varNames[grep("mean\\(\\)|std\\(\\)",varNames[,2]),]
XTotal <- XTotal[,selectedVar[,1]]

colnames(YTotal) <- "activity"
YTotal$activitylabel <- factor(YTotal$activity, labels = as.character(activitylabels[,2]))
activitylabel <- YTotal[,-1]

colnames(XTotal) <- varNames[selectedVar[,1],2]
colnames(SubTtotal) <- "subject"
total <- cbind(XTotal, activitylabel, SubTtotal)
meanTotal <- total %>% group_by(activitylabel, subject) %>% final(funs(mean))
write.table(meanTotal, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)
