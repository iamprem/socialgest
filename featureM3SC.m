function [ trainXM3SC, testXM3SC ] = featureM3SC( trainX, testX )
% featureM3SC Construct feature vector using descriptive stats
% M3SC in the function name means
%   M3 - Min, Max, Mean, 
%   S - Standard Deviation, 
%   C - Correlation between axes


trainXM3SC = zeros(size(trainX,2), 15);
testXM3SC = zeros(size(testX,2), 15);

for i = 1:size(trainX,2)
    a = trainX{1,i};
    if(size(a,1) >= 1)
        temp = [min(a), max(a), mean(a), std(a), corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
        trainXM3SC(i,:) = temp;
    end
end

for j = 1:size(testX,2)
    a = testX{1,j};
    if(size(a,1) >= 1)
        temp = [min(a), max(a), mean(a), std(a), corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
        testXM3SC(j,:) = temp;
    end
end

end


