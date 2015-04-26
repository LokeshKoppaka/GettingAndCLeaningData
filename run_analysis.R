generateTidyData <- function(WorkingDirectory, OutputFileName)
{
    # sets the working directory
    setwd(WorkingDirectory);
    
    # Reading the files required for generating tidy data.
    print("Reading.... files ")
    
    # Reading features.txt file containing the features
    features <- read.table("./Assigment_Data/UCI HAR Dataset/features.txt")
    
    # Reading activity_label file
    activity_labels <- read.table("./Assigment_Data/UCI HAR Dataset/activity_labels.txt")
    
    # Reading test Data Files
    test_data <- read.table("./Assigment_Data/UCI HAR Dataset/test/X_test.txt")
    test_data_act <- read.table("./Assigment_Data/UCI HAR Dataset/test/y_test.txt")
    test_data_subject <- read.table("./Assigment_Data/UCI HAR Dataset/test/subject_test.txt")
    
    # Reading Train Data Files 
    train_data <- read.table("./Assigment_Data/UCI HAR Dataset/train/X_train.txt")
    train_data_act <- read.table("./Assigment_Data/UCI HAR Dataset/train/y_train.txt")
    train_data_subject <- read.table("./Assigment_Data/UCI HAR Dataset/train/subject_train.txt")
    
    print("Completed....")
    # filtering the features inorder to extract only mean and std containing features. 
    features_with_mean_std <- rbind(features [grep("mean()",features$V2),],features[grep("std()",features$V2),]);
    print("Completed.... Rbind")
    
    # Refining test_data_set and train_data_set, inorder to contain columns having mean and std
    test_data_refine <- test_data[, features_with_mean_std$V1]
    train_data_refine <-train_data[, features_with_mean_std$V1]
    print("Completed.. data_fine")
    
    # Renaming the colNames with Appropriately labels the data set with descriptive variable names.
    colnames(test_data_refine) <- features_with_mean_std$V2
    colnames(train_data_refine) <-features_with_mean_std$V2
    print("Completed column naming")
    
    # Renaming the activity names to Walking..etc  
    test_data_act$V1 <- activity_labels[test_data_act$V1,]$V2
    train_data_act$V1 <- activity_labels[train_data_act$V1,]$V2
    print("Completed activity naming")
    
    # Renaming colNames V1 of test_data_act and train_data_act to Activity_Labels, Appropriately labels the data set with descriptive variable names.
    colnames(test_data_act) <- "Activity_Labels"
    colnames(train_data_act) <- "Activity_Labels"
    print("completed column naming")
    
    #Renaming colNames of test_data_subject and train_data_subject to Subject, Appropriately labels the data set with descriptive variable names.
    colnames(test_data_subject) <- "Subject"
    colnames(train_data_subject) <- "Subject"
    
    # binding to add the above columns to test_data_refine 
    test_data_refine <- cbind(test_data_refine, test_data_act, test_data_subject)
    train_data_refine <- cbind(train_data_refine, train_data_act, train_data_subject)
    
    # binding test_data and train data into a single data set
    tidy_data_set <- rbind(test_data_refine,train_data_refine)
    write.table(tidy_data_set,file = OutputFileName, col.names = TRUE)
    
    # code to generate  tidy data set with the average of each variable for each activity and each subject.
    i = 0
    average_tidy_data_set <- data.frame();
    #tempdataframe <- data.frame();
    for(labels in colnames(tidy_data_set))
    {
      if(labels != 'Activity_Labels' && labels != 'Subject')
      {
       if(i != 0)
        {
       lateruse <- labels
       cbind(average_tidy_data_set,labels)
       }
       label <- tapply(tidy_data_set[, labels],tidy_data_set$Activity_Labels,mean)
       labelTwo <- tapply(tidy_data_set[, labels],tidy_data_set$Subject,mean) 
       if(i == 0)
       {
         replacelabel <- labels
         average_tidy_data_set <- as.data.frame(label)
         label <- labelTwo
         tempdataframe <- as.data.frame(label)
         average_tidy_data_set <- rbind(average_tidy_data_set,tempdataframe)
         i = i+1
       }
       else
       {
         average_tidy_data_set[, lateruse] <- c(label, labelTwo)
       }
      }   
    }
    colnames(average_tidy_data_set)[1] <- replacelabel
    write.table(average_tidy_data_set,file = "average_tidy_data_set", col.names = TRUE)
}
