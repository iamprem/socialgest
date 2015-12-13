function[idx] = zeroindices(data)
% Find datapoints that are empty and returns its corresponding indices

idx = [];
for i = 1:size(data,2)
    datapoint = data{1,i};
    if(size(datapoint,1) == 0)
        idx = [idx, i];
    end
end
end