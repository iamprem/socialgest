function [testY] = knnpredict(trainData, trainAction, testData, dtw_dist, k)
% knnpredict will predict testY based on the distances computed using
% Dynamic time wrapping algorithm('featureDTW.m')
% 
% k - number of closest neighbours to consider.
% 
% IMPORTANT: trainData, trainAction and testData should be same as it was
% used for computing dtw_dist. In case 'dtw_dist' is not computed before,
% use 'featureDTW.m' script to compute them.


% Clean the noisy data by removing them
idx = zeroindices(trainData);
trainData(idx) = [];
trainAction(idx) = [];
idx = zeroindices(testData);
testData(idx) = [];

testY = zeros(1,size(testData,2));
[values, indices] = nsmall(dtw_dist, k);

for i = 1:size(indices,1)
   testYList = trainAction(indices(i,:));
   testY(i) = mode(testYList);
end
end