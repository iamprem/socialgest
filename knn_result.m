k = 14;

% Clean the noisy data by removing them
idx = zeroindices(trainData);
trainData(idx) = [];
trainAction(idx) = [];
idx = zeroindices(testData);
testData(idx) = [];

testY = zeros(1,1200);
[values, indices] = nSmallWithIndex(dtw_dist, k);

for i = 1:size(indices,1)
   testYList = trainAction(indices(i,:));
   testY(i) = mode(testYList);
end
