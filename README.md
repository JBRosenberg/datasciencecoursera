##README
###Getting and Cleaning Data: Course Project 2 Analysis Breakdown

The project consists of a single script with a single function call run_analysis(), and utilizes datasets
recorded from UCI's "Human Activity Using Smartphones" Experiment. The dataset can be found and downloaded 
here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

To lower processing time, the script assumes the data has properly downloaded, unzipped, and that the function
is being called in the corresponding Workspace.

run_analysis() runs as follows:

1. Extracts and reads the subject_test, x_test, and y_test datasets from the /test folder
2. Extracts and reads the subject_train, x_train, and y_train datasets from the /train folder
3. Combines all of the test files into one datasets, and all of the train files into one datasets vertically using cbind()
4. Combines the test and train datasets horizontally into one data set using rbind()
5. Names the subject and activity columns for reference
6. Adds a column with activity names corresponding to the activity column
7. Extracts the mean and stdev measurements across the 561 variables using a specified sequence
8. Names the columns accordingly. More details may be found in the codebook.
9. Orders the dataset based on subject number first, and then activity code 
10. Subsets the data for each subject and each of the subject's six activities using nested for loops
11. Takes the averages of the value of the variables for each of these subsets 
     and adds it to a resultant dataframe using rbind
12. Returns the resultant dataset

 