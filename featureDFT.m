function [ trainXDFT, testXDFT ] = featureDFT( trainX, testX, k )
%featureDFT Construct feature vector using first 'k' Discrete Fourier 
% Transform coefficients


trainXDFT = zeros(size(trainX,2), 3*k);
testXDFT = zeros(size(testX,2), 3*k);

for i = 1:size(trainX,2)
    a = trainX{1,i};
    disFT = fft(a);
    powDist = disFT.*conj(disFT);
    magnitude = sqrt(powDist);
%     maxPow = max(powDist);
%     powDist = bsxfun(@rdivide,powDist,maxPow); %Scale by dividing max power
    selectedCoeff = reshape(magnitude(1:k,:),1,3*k);
    trainXDFT(i,:) = [selectedCoeff];%, mean(a), std(a), corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
end

for j = 1:size(testX,2)
    b = testX{1,j};
    disFT = fft(b);
    powDist = disFT.*conj(disFT);
    magnitude = sqrt(powDist);
%     maxPow = max(powDist);
%     powDist = bsxfun(@rdivide,powDist,maxPow); %Scale by dividing max power
    selectedCoeff = reshape(magnitude(1:k,:),1,3*k);
    testXDFT(j,:) = [selectedCoeff];%, mean(b), std(b), corr(b(:,1),b(:,2)), corr(b(:,2),b(:,3)), corr(b(:,3),b(:,1))];
end

end