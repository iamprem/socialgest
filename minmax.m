function[maxdim, mindim] = minmax(data)
% Gives the smallest and largest data points dimension

% Removes empty cell
data = data(~cellfun(@isempty, data));

maxdim = 0; mindim = Inf; 
maxindex = 0; minindex = 0;
zero_index = []; sizes = [];
for i = 1:size(data,2)
    datapoint = data{1,i};
    if(size(datapoint,1) > maxdim)
        maxdim = size(datapoint,1);
        maxindex = i;
    end

    if(size(datapoint,1) < mindim)
        mindim = size(datapoint,1);
        minindex = i;
    end

    if(size(datapoint,1) == 0)
        zero_index = [zero_index, i];
    end
    sizes = [sizes, size(datapoint,1)];
end

end

