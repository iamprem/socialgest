function [ trainXM3SEHC, testXM3SEHC ] = featureM3SEHC( trainX, testX )
%featureMSEC Construct feature vector using descriptive stats
%   M3SEHC in the function name means
%   M - Mean
%   M - Min
%   M - Max
%   S - Standard Deviation
%   E - Energy
%   H - Frequency Domain Entropy of the signal
%   C - Correlation between three axes



trainXM3SEHC = zeros(size(trainX,2), 21);
testXM3SEHC = zeros(size(testX,2), 21);

for i = 1:size(trainX,2)
    a = trainX{1,i};
    ft = fft(a);
    powdist = ft.*conj(ft);
    energy = sum(powdist(2:end,:))/size(a,1); %Excluded the DC Component coz of Explicit mean feature
    pxx = periodogram(a);
    pxxn = bsxfun(@rdivide,pxx,sum(pxx));
    entropy = -sum(pxxn.*log(pxxn));
    temp = [min(a), max(a), mean(a), std(a), energy, entropy, ...
         corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
    trainXM3SEHC(i,:) = temp;
end

for j = 1:size(testX,2)
    a = testX{1,j};
    ft = fft(a);
    powdist = ft.*conj(ft);
    energy = sum(powdist(2:end,:))/size(a,1); %Excluded the DC Component coz of Explicit mean feature
    pxx = periodogram(a);
    pxxn = bsxfun(@rdivide,pxx,sum(pxx));
    entropy = -sum(pxxn.*log(pxxn));
    temp = [min(a), max(a), mean(a), std(a), energy, entropy, ...
        corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
    testXM3SEHC(j,:) = temp;
end

end


