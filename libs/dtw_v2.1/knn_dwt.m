function [ testY, valtestY, trainX, trainY, valX, valY, testX ] = knn_dwt( trainData, trainAction, testData )
%KNN_DWT KNN with Dynamic Time wrapping distance as distance measurement
    
% Clean the noisy data by removing them
idx = zeroindices(trainData);
trainData(idx) = [];
trainAction(idx) = [];
idx = zeroindices(testData);
testData(idx) = [];


%Split validation and train
[trainX, trainY, valX, valY] = split_data(trainData, trainAction,2);
testX = testData;


testY = zeros(1, size(testX,2));
valtestY = zeros(1, size(valX,2));
    
%train with trainX, trainY
% Validation
tic();
for i = 1:size(valX,2)
    dtw_dist = zeros(1, size(trainX,2));
    x = valX{1,i};
    for j = 1:size(trainX,2)
        z = trainX{1,j};
        dtw_dist(j) = dtw(z, x, 50);
    end
    [M,I] = min(dtw_dist);
    valtestY(i) = trainY(I);
    i
end
t1 = toc();
fprintf('Validation Running time=%f\n',t1);

% evaluate(valY, valtestY)

% Actual testing
tic();
for i = 1:size(testX,2)
    dtw_dist = zeros(1, size(trainX,2));
    x = testX{1,i};
    for j = 1:size(trainX,2)
        z = trainX{1,j};
        dtw_dist(j) = dtw(z, x, 50);
    end
    [M,I] = min(dtw_dist);
    testY(i) = trainY(I);
end
t2 = toc();

fprintf('Testing Running time=%f\n',t2);

end

