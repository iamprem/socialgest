Name		: Prem Kumar Murugesan
Student ID	: 800888499
email		: pmuruges@uncc.edu
Project		: Social Gesture Classification
---------------------------------------------

The below procedure explains how to run KNN with DTW as distance metric.

Getting Best Result:(Accuracy: 0.96042)
---------------------------------------

1. Make 'socialgest/' as working directory.
2. To add libraries to path and import necessary data into workspace.
	
	>> run setup.m

3. To run K-Nearest Neighbour algorithm with Dynamic Time wrapping as distance measure,
	
	>> testY = knnpredict(trainData, trainAction, testData, dtw_dist, 1);

4. To save the predictions to 'result/filename.csv'

	>> write_result(testY', 'filename.csv');


The above steps are simplest way to get the best result that kaggle shows. Also I
precomputed 'dtw_dist' and stored for this dataset to speed up the process. Otherwise follow the
below procedure to compute 'dtw_dist' matrix.


For New Test Data:
------------------

1. For new test data, we first need to compute DTW distances with training data to get the 'dtw_dist' matrix.
2. To compute 'dtw_dist', run the following command.

	>> dtw_dist = featureDTW(trainData, trainAction, testData);
	Note: This computation takes very long time(for the given dataset it took more than 6 
		hours to get the dtw_dist matrix)

3. After computing 'dtw_dist', run the following command,

	>> testY = knnpredict(trainData, trainAction, testData, dtw_dist, 1);

4. Final predictions will be stored in 'testY' variable in workspace.
5. Run the following command to store the result in 'result/file_name.csv'
	
	>> write_result(testY', 'file_name.csv');


In case of error
----------------
1. Make sure that you added 'libs/' directroy and its sub-directories to MATLAB path.
2. Load 'project1.mat' and 'dtw_dist_full.mat' from 'data/' directory into workspace.


External libraries used in this project
---------------------------------------

1. LibSVM by Chih-Chung Chang and Chih-Jen Lin
2. csvwrite_with_headers by Keith Brady
3. dtw(Dynamic Time Wrapping algorithm) by Quan Wang