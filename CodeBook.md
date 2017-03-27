
Codebook explaining the different variables used and any transformations applied in scripts for data cleaning project.

## run_analysis.R

### File names

#### Training Dataset
* train_data (./train/X_train.txt) : training dataset
* train_label (./train/y_train.txt) : training labels 
* train_data_subject (./train/subject_train.txt) : subjects who performed the activities

#### Test Dataset
* test_data (./test/X_test.txt) : test dataset
* test_label (./test/y_test.txt) : test labels  
* test_data_subject (./test/subject_test.txt) : subjects who performed the activities

#### Others
* feature_name ("./features.txt") : list of all features collected
* activity_labels ("./activity_labels.txt") : list of activities


### Variables

* joined_data : combines training and test datasets, then subset to only keep mean and 
                standard deviation data
* joined_labels : combines labels
* joined_subjects : combines subject data 
* mean_cols : indices that contain mean observations
* std_cols : indices that contain standard deviation observations
* measure_cols : combines all indices
* activities : associate the activity ids to the appropriate label 
* obs : combine subjects, labels and observations in a single dataset
* averages : tidy dataset with the average of each variable for each activity and each subject


### Transformations

Main transformations applied in the R scripts are:
* Merge datasets and give appropriate names
* Extract only the measurements on the mean and standard deviation for each measurement
* Combine subjects, labels and observations
* Write to a file

