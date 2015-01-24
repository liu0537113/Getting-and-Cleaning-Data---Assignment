This is to describe variables, data, and any transformations or work that have performed in the program.


Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in trainData, trainL and trainS variables respectively.
Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in testData, testL and testS variables respectively.
Concatenate testD to trainD to generate a 10299x561 data frame, mergeD; concatenate testLabel to trainLabel to generate a 10299x1 data frame, mergeL; concatenate testS to trainS to generate a 10299x1 data frame, joinS.
Read the features.txt file from the "/data" folder and store the data in a variable called features. We only extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of joinD with the 66 corresponding columns.
Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called activity.
Clean the activity names in the second column of activity. We first make all names to lower cases. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore.
Transform the values of joinLabel according to the activity data frame.
Combine the mergeS, mergeL and joinData by column to get a new cleaned 10299x68 data frame, cleanedD. Properly name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.
Write the cleanedD out to "merged_data.txt" file in current working directory.
Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, we get a 180x68 data frame.
Write the result out to "data_with_means.txt" file in current working directory.