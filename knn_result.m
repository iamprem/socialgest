function [testY] = knn_result(trainData, trainAction, testData, dtw_dist, k)
% Compute dtw_dist using knn_dtw function and pass that with the
% corresponding trainData/trainAction and the testData

% Clean the noisy data by removing them
idx = zeroindices(trainData);
trainData(idx) = [];
trainAction(idx) = [];
idx = zeroindices(testData);
testData(idx) = [];

testY = zeros(1,size(testData,2));
[values, indices] = nSmallWithIndex(dtw_dist, k);

for i = 1:size(indices,1)
   testYList = trainAction(indices(i,:));
   testY(i) = mode(testYList);
end
end