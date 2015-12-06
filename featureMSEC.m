function [ trainXMSEC, testXMSEC ] = featureMSEC( trainX, testX )
%featureMSEC Construct feature vector using descriptive stats
%   MSEC in the function name means
%   M - Mean, S - Standard Deviation, E - Energy, C - Correlation between
%       predictor variables

% trainXMSEC and testXMSEC format:
% Each row in the output matrix will be in the following format
% [x_mean, y_mean, z_mean, x_sd, y_sd, z_sd, x_e, y_e, z_e, xy_c, yz_c, zx_c]

% NOTE: NOW ENERGY IS NOT CONSIDERED so the dimension will be [nx9]

trainXMSEC = zeros(size(trainX,2), 15);
testXMSEC = zeros(size(testX,2), 15);

for i = 1:size(trainX,2)
    a = trainX{1,i};
    if(size(a,1) >= 1)
        temp = [min(a), max(a), mean(a), std(a), corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
        trainXMSEC(i,:) = temp;
    end
end

for j = 1:size(testX,2)
    a = testX{1,j};
    if(size(a,1) >= 1)
        temp = [min(a), max(a), mean(a), std(a), corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
        testXMSEC(j,:) = temp;
    end
end

end


