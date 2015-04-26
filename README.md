# GettingAndCLeaningData

The following are the steps taken inorder to generate a tidy data set.

Step 1: Readed all the required files ie. features.txt, activity_labels.txt, X_test.txt, y_test.txt , subject_test.txt, X_train.txt,
        y_train.txt, subject_train.txt, inorder to generate tidy data set.
        
Step 2: Filtered the features inorder to extract only the features having mean and std() in them.

Step 3: Subsetted the test and train data,using the filtered features set inorder to have columns containing mean and std in the
        test and train data.
        
Step 4: Renaming the columns of test and train data.

Step 5: Renaming the activity and features data set and binding the these columns to test and train data.

Step 6: Binding test and train data into a single data set.

Step 7: Custome logic inorder to create the average  of each variable for each activity and each subject.

While Running the program please take care of the correct directory path to the data availability.

The Function generateTidyData takes the following parameters.

function(WorkingDirectory, OutputFileName)
WorkingDirectory -> is the path upto the directory UCI HAR Dataset
OutputFileName -> is the file name of the Output File.

Sample invoke -> generateTidyData("D:\\lokesh_R_programming\\Getting and cleaning Data\\Assigment_Data","finatTestData")
