function [ trainXMEEC, testXMEEC ] = featureMEEC( trainX, testX )
%featureMEEC Construct feature vector using descriptive stats
%   MEEC in the function name means
%   M - Mean, 
%   E - Energy of the signal obtained by DFT, 
%   E - Freq domain Entropy
%   C - Correlation between the 3 axes


trainXMEEC = zeros(size(trainX,2), 12);
testXMEEC = zeros(size(testX,2), 12);

for i = 1:size(trainX,2)
    a = trainX{1,i};
    ft = fft(a);
    powdist = ft.*conj(ft);
    energy = sum(powdist(2:end,:))/size(a,1); %Excluded the DC Component coz of Explicit mean feature
    pxx = periodogram(a);
    pxxn = bsxfun(@rdivide,pxx,sum(pxx));
    entropy = -sum(pxxn.*log(pxxn));
    temp = [mean(a), energy, entropy, corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
    trainXMEEC(i,:) = temp;
end

for i = 1:size(testX,2)
    a = testX{1,i};
    ft = fft(a);
    powdist = ft.*conj(ft);
    energy = sum(powdist(2:end,:))/size(a,1); %Excluded the DC Component coz of Explicit mean feature
    pxx = periodogram(a);
    pxxn = bsxfun(@rdivide,pxx,sum(pxx));
    entropy = -sum(pxxn.*log(pxxn));
    temp = [mean(a), energy, entropy, corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
    testXMEEC(i,:) = temp;
end

end


