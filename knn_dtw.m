function [ testY, valtestY, trainX, trainY, valX, valY, testX, dtw_dist ] = knn_dtw( trainData, trainAction, testData )
% This funtion computes DTW between all testX and trainX combination and
% store for later computations(Because DTW distance is intensive
% computation.)
% Also by default it finds 1-Nearest Neighbour and gives predicted testY
% 
% To predict with other K values use 'knn_result.m' script with the
% dtw_dist obtained from this method. 
% **Careful: Use the testData for which the dtw_dist are calculated without
% changing the order.
% 
% Please ignore the valX, valY, valtestY, those serves validation purpose.
    
% Clean the noisy data by removing them
idx = zeroindices(trainData);
trainData(idx) = [];
trainAction(idx) = [];
idx = zeroindices(testData);
testData(idx) = [];


%Split validation and train
% [trainX, trainY, valX, valY] = split_data(trainData, trainAction,2);
valX = [];
valY = [];
trainX = trainData;
trainY = trainAction;
testX = testData;


testY = zeros(1, size(testX,2));
dtw_dist = zeros(size(testX,2), size(trainX,2)); %Rows represent each testX, Column correspond to each trainX
valtestY = zeros(1, size(valX,2));
dtw_dist_val = zeros(size(valX,2), size(trainX,2));
    
% Train with splitted trainX, trainY
% Validation
% tic();
% for i = 1:size(valX,2)
% 
%     x = valX{1,i};
%     parfor j = 1:size(trainX,2)
%         z = trainX{1,j};
%         dtw_dist_val(i,j) = dtw(z, x, 50);
%     end
%     [M,I] = min(dtw_dist_val(i,:));
%     valtestY(i) = trainY(I);
%     i
% end
% t1 = toc();
% fprintf('Validation Running time=%f\n',t1);
% save('valX_dtwdist.mat','dtw_dist_val');

% Actual Testing
% Computing DTW Distances
tic();
for i = size(testX,2)
    
    x = testX{1,i};
    parfor j = 1:size(trainX,2)
        z = trainX{1,j};
        dtw_dist(i,j) = dtw(z, x, 50);
    end
    [M,I] = min(dtw_dist(i,:));
    testY(i) = trainY(I);
    i
end
t2 = toc();

fprintf('Testing Running time=%f\n',t2);
save('testX_dtwdist.mat','dtw_dist');

end
