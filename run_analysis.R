# Step1. Merges the training and the test sets to create one data set.
# setwd("~/Desktop/Online Coursera/Coursera-Getting-and-Cleaning-Data/peer_assessment/")
trainD <- read.table("./data/train/X_train.txt")
dim(trainD) 
head(trainD)
trainL <- read.table("./data/train/y_train.txt")
table(trainL)
trainS <- read.table("./data/train/subject_train.txt")
testD <- read.table("./data/test/X_test.txt")
dim(testD) 
testL <- read.table("./data/test/y_test.txt") 
table(testL) 
testSubject <- read.table("./data/test/subject_test.txt")
mergeD <- rbind(trainD, testD)
dim(mergeD) 
mergeL <- rbind(trainL, testL)
dim(mergeL) 
mergeS <- rbind(trainS, testSubject)
dim(mergeS) 

# Step2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt")
dim(features)  
meanS <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanS) 
mergeD <- mergeD[, meanS]
dim(mergeD) 
names(mergeD) <- gsub("\\(\\)", "", features[meanS, 2]) 
names(mergeD) <- gsub("mean", "Mean", names(mergeD)) 
names(mergeD) <- gsub("std", "Std", names(mergeD)) 
names(mergeD) <- gsub("-", "", names(mergeD)) 

# Step3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[mergeL[, 1], 2]
mergeL[, 1] <- activityLabel
names(mergeL) <- "activity"

# Appropriately labels the data set with descriptive activity names. 
names(mergeS) <- "subject"
cleanD <- cbind(mergeS, mergeL, mergeD)
dim(cleanD) 
write.table(cleanD, "merged_data.txt") # output data #1

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(mergeS)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanD)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanD)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(mergeS)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanD$subject
    bool2 <- activity[j, 2] == cleanD$activity
    result[row, 3:columnLen] <- colMeans(cleanD[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_with_means.txt") # output data #2