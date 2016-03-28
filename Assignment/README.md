## Getting and Cleaning Data Course Project CodeBook

1. loads dplyr library.
2. Sets workind directory to the correct path.
3. Reads the Activity files (y_test.txt, y_train.txt)
4. Reads the Subject files (subject_train.txt, subject_test.txt)
5. Reads the Features files (X_test.txt, X_train.txt)
6. Reads the Features Names file (features.txt)
7. Binds by rows the data in three variables (dataSubject, dataActivity, dataFeatures), and sets their names to simpler ones: subject, activity 561 Features Names. 
8. Merges all data to a new dataframe binding it by columns.
9. Subsets and selects only data with "mean" and "std" strings in dataFeaturesNames$V2.
10. Factorize Activity Labels.
11.Substitute actual names for readable ones.
12. Create a tidy data set with the average of each variable for each activity and each subject.