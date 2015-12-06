function[idx] = zeroindices(data)
    idx = [];
    for i = 1:size(data,2)
        datapoint = data{1,i};
        if(size(datapoint,1) == 0)
            idx = [idx, i];
        end
    end

end