runAnalysis <- function() {
  
  #1. loads dplyr library.
  library(dplyr)
  
  #2. Sets workind directory to the correct path.
  setwd("/Users/humbertomangino/Documents/Coursera/Getting_and_Cleaning_Data/week4/Assignment")
  path <- file.path("../UCI_HAR_Dataset")
  
  #3. Reads the Activity files (y_test.txt, y_train.txt)
  dataActivityTest  <- read.table(file.path(path, "test" , "y_test.txt" ),header = FALSE)
  dataActivityTrain <- read.table(file.path(path, "train", "y_train.txt"),header = FALSE)
  
  #4. Reads the Subject files (subject_train.txt, subject_test.txt)
  dataSubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
  dataSubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
  
  #5. Reads the Features files (X_test.txt, X_train.txt)
  dataFeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
  dataFeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
  
  #6. Reads the Features Names file (features.txt)
  dataFeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
  
  #7. Binds by rows the data in three variables (dataSubject, dataActivity, dataFeatures), and sets their names to simpler ones: subject, activity 561 Features Names. 
  dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
  dataActivity <- rbind(dataActivityTrain, dataActivityTest)
  dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)
  
  names(dataSubject) <- c("subject")
  names(dataActivity) <- c("activity")
  names(dataFeatures) <- dataFeaturesNames$V2
  
  #8. Merges all data to a new dataframe binding it by columns.
  dataMerge <- cbind(dataSubject, dataActivity)
  Data <- cbind(dataFeatures, dataMerge)
  
  #9. Subsets and selects only data with "mean" and "std" strings in dataFeaturesNames$V2.
  subsetFeatureNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
  
  resultNames <- c(as.character(subsetFeatureNames), "subject", "activity")
  Data <- subset(Data, select = resultNames)
  
  #10. Factorize Activity Labels.
  activityLabels <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)
  Data$activity <- factor(Data$activity)
  Data$activity <- factor(Data$activity, labels = as.character(activityLabels$V2))
  
  #11.Substitute actual names for readable ones.
  names(Data) <- gsub("^t", "time", names(Data))
  names(Data) <- gsub("^f", "frequency", names(Data))
  names(Data) <- gsub("Acc", "Accelerometer", names(Data))
  names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
  names(Data) <- gsub("Mag", "Magnitude", names(Data))
  names(Data) <- gsub("BodyBody", "Body", names(Data))
  
  #12. Create a tidy data set with the average of each variable for each activity and each subject.
  tidyData <- aggregate(. ~subject + activity, Data, mean)
  tidyData <- tidyData[order(tidyData$subject, tidyData$activity),]
  write.table(tidyData, file = "tidyData.txt")
}
