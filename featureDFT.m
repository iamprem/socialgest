function [ trainXDFT, testXDFT ] = featureDFT( trainX, testX, k )
%featureDFT Construct feature vector using first 'k' Discrete Fourier 
% Transform coefficients. 
% Note: The first coefficient is excluded because it is captured by the
% Mean


trainXDFT = zeros(size(trainX,2), 21 + 3*k);
testXDFT = zeros(size(testX,2), 21 + 3*k);

for i = 1:size(trainX,2)
    a = trainX{1,i};
    ft = fft(a);
    powdist = ft.*conj(ft);
    coefmagnitude = sqrt(powdist)/size(a,1);
    energy = sum(powdist(2:end,:))/size(a,1); %Excluded the DC Component coz of Explicit mean feature
    pxx = periodogram(a);
    pxxn = bsxfun(@rdivide,pxx,sum(pxx));
    entropy = -sum(pxxn.*log(pxxn));
%     maxPow = max(powDist);
%     powDist = bsxfun(@rdivide,powDist,maxPow); %Scale by dividing max power
    selectedCoeff = reshape(coefmagnitude(2:k+1,:),1,3*k);
    trainXDFT(i,:) = [selectedCoeff, min(a), max(a), mean(a), std(a), energy, entropy, ...
         corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
end

for i = 1:size(testX,2)
    a = testX{1,i};
    ft = fft(a);
    powdist = ft.*conj(ft);
    coefmagnitude = sqrt(powdist)/size(a,1);
    energy = sum(powdist(2:end,:))/size(a,1); %Excluded the DC Component coz of Explicit mean feature
    pxx = periodogram(a);
    pxxn = bsxfun(@rdivide,pxx,sum(pxx));
    entropy = -sum(pxxn.*log(pxxn));
%     maxPow = max(powDist);
%     powDist = bsxfun(@rdivide,powDist,maxPow); %Scale by dividing max power
    selectedCoeff = reshape(coefmagnitude(2:k+1,:),1,3*k);
    testXDFT(i,:) = [selectedCoeff, min(a), max(a), mean(a), std(a), energy, entropy, ...
         corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
end

end