function [trainedClassifier, validationAccuracy] = trainClassifier(datasetTable)
% Convert input to table
datasetTable = table(datasetTable);
datasetTable.Properties.VariableNames = {'column'};
% Split matrices in the input table into vectors
datasetTable.column_1 = datasetTable.column(:,1);
datasetTable.column_2 = datasetTable.column(:,2);
datasetTable.column_3 = datasetTable.column(:,3);
datasetTable.column_4 = datasetTable.column(:,4);
datasetTable.column_5 = datasetTable.column(:,5);
datasetTable.column_6 = datasetTable.column(:,6);
datasetTable.column_7 = datasetTable.column(:,7);
datasetTable.column_8 = datasetTable.column(:,8);
datasetTable.column_9 = datasetTable.column(:,9);
datasetTable.column_10 = datasetTable.column(:,10);
datasetTable.column_11 = datasetTable.column(:,11);
datasetTable.column_12 = datasetTable.column(:,12);
datasetTable.column_13 = datasetTable.column(:,13);
datasetTable.column = [];
% Extract predictors and response
predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12'};
predictors = datasetTable(:,predictorNames);
predictors = table2array(varfun(@double, predictors));
response = datasetTable.column_13;
% Train a classifier
template = templateSVM('KernelFunction', 'polynomial', 'PolynomialOrder', 3, 'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', 1);
trainedClassifier = fitcecoc(predictors, response, 'Learners', template, 'Coding', 'onevsone', 'PredictorNames', {'column_1' 'column_2' 'column_3' 'column_4' 'column_5' 'column_6' 'column_7' 'column_8' 'column_9' 'column_10' 'column_11' 'column_12'}, 'ResponseName', 'column_13', 'ClassNames', [1 2 3 4 5 6 7 8 9 10 11 12 13]);

% Perform cross-validation
partitionedModel = crossval(trainedClassifier, 'KFold', 10);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

%% Uncomment this section to compute validation predictions and scores:
% % Compute validation predictions and scores
% [validationPredictions, validationScores] = kfoldPredict(partitionedModel);