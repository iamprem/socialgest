function [tr_data, tr_label, vl_data, vl_label, ts_data] = data_prep(dataformat)
% Prepares the required format from the raw data and saves in workspace
% 
% dataformat - takes any one of the following integer values.
% dataformat:
%   1. Zero Padded Matrix of original data converted matrix2vector
%   2. M3SC - Min, Max, Mean, Standard Dev, Correlation
%  *3. DFT Coefficients and Descriptive statistics of dataformat(2) - (Best of all)
%   4. MEHC - Mean Energy Freq Entropy Correlation of axes. 
%   5. M3SEHC - Min, Max, Mean, SD, Energy, Entropy, Correlation

load('data/project1.mat')
% Clean the noisy data by removing them
idx = zeroindices(trainData);
trainData(idx) = [];
trainAction(idx) = [];
idx = zeroindices(testData);
testData(idx) = [];


switch dataformat
    
    case 1     
        % 1. Data Prep with Zero padding
        % Take the highest dimension between train and test and Zero pad both to 
        % math that dimension
        trainmaxdim = minmax(trainData);
        testmaxdim = minmax(testData);
        maxdim = max(trainmaxdim, testmaxdim);

        % Zero pad the datapoints with smaller dimension
        % and store it in a 3D matrix
        trainDataPad = zeros(maxdim, 3, size(trainData,2));
        for i = 1:size(trainData,2)
            datapoint = trainData{1,i};
            datadim = size(datapoint,1);
            datapoint = [datapoint; zeros(maxdim - datadim,3)];
            trainDataPad(:,:,i) = datapoint;
        end
        
        testDataPad = zeros(maxdim, 3, size(testData,2));
        for j = 1:size(testData,2)
            datapoint = testData{1,j};
            datadim = size(datapoint,1);
            datapoint = [datapoint; zeros(maxdim - datadim,3)];
            testDataPad(:,:,j) = datapoint;
        end
        
        % Serialize data
        data = reshape(trainDataPad,maxdim*3,[])';
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels, 1);
        ts_data = reshape(testDataPad, maxdim*3,[])';
        
    case 2
        [data, ts_data] = featureM3SC(trainData, testData);
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels, 1);
        
    case 3
        [data, ts_data] = featureDFT(trainData, testData, 5); %Last parameter is # of DFT Coeff
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels, 1);
    
    case 4
        [data, ts_data] = featureMEHC(trainData, testData);
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels, 1);
    
    case 5
        [data, ts_data] = featureM3SEHC(trainData, testData);
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels, 1);
end
end