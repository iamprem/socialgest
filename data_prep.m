function [tr_data, tr_label, vl_data, vl_label, ts_data] = data_prep(dataformat)
% Prepares the required format from the raw data and saves in workspace
% 
% Formats:
%   1. Zero Padded Matrix of original data with Serialization SVM
%   2. MSEC of original data SVM
%   3. Zero Padded Matrix of original data without Serialization CNN
%   4. Trim or pad the data to match the required length(Didn't work well)
%   5. DFT Coefficients used to get power distribution
%   6. MEEC - Mean Energy Freq Entropy Correlation of axes. (Best of all)

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
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels);
        ts_data = reshape(testDataPad, maxdim*3,[])';
        
    case 2
        [data, ts_data] = featureMSEC(trainData, testData);
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels);
        
    case 3
        % 1. Data Prep with Zero padding
        % Take the highest dimension between train and test and Zero pad both to 
        % math that dimension
        trainmaxdim = minmax(trainData);
        testmaxdim = minmax(testData);
        maxdim = max(trainmaxdim, testmaxdim);

        % Zero pad the datapoints with smaller dimension
        % and store it in a 3D matrix
        trainDataPad = zeros(maxdim, 3, 1, size(trainData,2));
        for i = 1:size(trainData,2)
            datapoint = trainData{1,i};
            datadim = size(datapoint,1);
            datapoint = [datapoint; zeros(maxdim - datadim,3)];
            trainDataPad(:,:,1,i) = datapoint;
        end
        
        testDataPad = zeros(maxdim, 3, 1, size(testData,2));
        for j = 1:size(testData,2)
            datapoint = testData{1,j};
            datadim = size(datapoint,1);
            datapoint = [datapoint; zeros(maxdim - datadim,3)];
            testDataPad(:,:,1,j) = datapoint;
        end
        % TODO Put this in the split data method
        data = trainDataPad;
        labels = trainAction';
        seq = randperm(size(data,4));
        splitpoint = round(size(data,4) * 0.75);
        tr_data = data(:,:,:,seq(1:splitpoint));
        tr_label = labels(seq(1:splitpoint),:);
        vl_data = data(:,:,:,seq(splitpoint+1:end));
        vl_label = labels(seq(splitpoint+1:end),:);
        ts_data = testDataPad;
        
    case 4
        % 4. Data Prep with trimming
%         [~,trainmindim] = minmax(trainData);
%         [~,testmindim] = minmax(testData);
%         mindim = min(trainmindim, testmindim);
        mindim = 130;
        
        trainmaxdim = minmax(trainData);
        testmaxdim = minmax(testData);
        maxdim = max(trainmaxdim, testmaxdim);
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
        
        trainDataTrim = zeros(mindim, 3, size(trainData,2));
        for i = 1:size(trainDataPad,3)
            datapoint = trainDataPad(:,:,i);
            datapoint = datapoint(1:mindim, :, :);
            trainDataTrim(:,:,i) = datapoint;
        end
        
        testDataTrim = zeros(mindim, 3, size(testData,2));
        for j = 1:size(testDataPad,3)
            datapoint = testDataPad(:,:,j);
            datapoint = datapoint(1:mindim, :, :);
            testDataTrim(:,:,j) = datapoint;
        end
        
        % Serialize data
        data = reshape(trainDataTrim,mindim*3,[])';
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels);
        ts_data = reshape(testDataTrim, mindim*3,[])';
        
    case 5
        [data, ts_data] = featureDFT(trainData, testData, 21);
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels);
    
    case 6
        [data, ts_data] = featureMEEC(trainData, testData);
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels);
    
    case 7
        [data, ts_data] = featureM3SEHC(trainData, testData);
        labels = trainAction';
        [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels);
end
end