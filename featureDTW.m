function [ dtw_dist ] = featureDTW( trainData, trainAction, testData )
% This funtion computes Dynamic Time Wrapping distance between all testX
% and trainX combination and store for later computations(Because DTW 
% distance is intensive computation.)
% 
% IMPORTANT: The order of test and train data used here should be preserved
% while testing using KNN('knnpredict.m')
    
% Add libraries to the matlab path
addpath(genpath('libs'));

% Clean the noisy data by removing them
idx = zeroindices(trainData);
trainData(idx) = [];
trainAction(idx) = [];
idx = zeroindices(testData);
testData(idx) = [];


trainX = trainData;
testX = testData;
dtw_dist = zeros(size(testX,2), size(trainX,2)); %Rows represent each testX, Column correspond to each trainX

warning('DTW Distance Computation will take more than 6 hours on dual core machine..\n');
warning('Please use the precomputed DTW values placed in "data/dtw_dist_full.mat" file');

% Computing DTW Distances
tic();
for i = 1:size(testX,2)
    
    x = testX{1,i};
    parfor j = 1:size(trainX,2)
        z = trainX{1,j};
        dtw_dist(i,j) = dtw(z, x, 50);
    end
    disp(i)
end
t1 = toc();

fprintf('Total Computation Time=%f\n',t1);
save('testX_dtwdist.mat','dtw_dist');

end
