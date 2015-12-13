function [ trainXDWT, testXDWT ] = featureDWT( trainX, testX, k )
%featureDWT Construct feature vector using first 'k' Discrete Wavelet 
% Transform coefficients. 



trainXDWT = zeros(size(trainX,2), 21 + 3*k);
testXDWT = zeros(size(testX,2), 21 + 3*k);

for i = 1:size(trainX,2)
    a = trainX{1,i};
    ft = fft(a);
    powdist = ft.*conj(ft);
    coefmagnitude = sqrt(powdist)/size(a,1);
    energy = sum(powdist(2:end,:))/size(a,1); %Excluded the DC Component coz of Explicit mean feature
    pxx = periodogram(a);
    pxxn = bsxfun(@rdivide,pxx,sum(pxx));
    entropy = -sum(pxxn.*log(pxxn));
%     while true
%         if size(a,1) > 2*k
    [ac1, dc1] = dwt(a(:,1), 'haar');
    [ac2, dc2] = dwt(a(:,2), 'haar');
    [ac3 dc3] = dwt(a(:,3), 'haar');
    a = [ac1, ac2, ac3];
%         else
%             break
%         end
%     end
    scaledA = bsxfun(@rdivide,bsxfun(@minus, a, min(a)),(max(a) - min(a)));
    selectedCoeff = reshape(scaledA(1:k,:),1,3*k);
    trainXDWT(i,:) = [selectedCoeff, min(a), max(a), mean(a), std(a), energy, entropy, ...
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
%     while true
%         if size(a,1) > 2*k
    [ac1, dc1] = dwt(a(:,1), 'haar');
    [ac2, dc2] = dwt(a(:,2), 'haar');
    [ac3 dc3] = dwt(a(:,3), 'haar');
    a = [ac1, ac2, ac3];
%         else
%             break
%         end
%     end
    scaledA = bsxfun(@rdivide,bsxfun(@minus, a, min(a)),(max(a) - min(a)));
    selectedCoeff = reshape(scaledA(1:k,:),1,3*k);
    testXDWT(i,:) = [selectedCoeff, min(a), max(a), mean(a), std(a), energy, entropy, ...
         corr(a(:,1),a(:,2)), corr(a(:,2),a(:,3)), corr(a(:,3),a(:,1))];
end

end