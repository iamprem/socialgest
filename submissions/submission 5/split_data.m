function [tr_data, tr_label, vl_data, vl_label] = split_data(data, labels, dimtosplit)
% Split 75% Train and 25% Validation data
% Percentage argument can be added to get the split percentage
 
seq = randperm(size(data,1));
splitpoint = round(size(data,1) * 0.75);
tr_data = data(seq(1:splitpoint),:);
tr_label = labels(seq(1:splitpoint),:);
vl_data = data(seq(splitpoint+1:end),:);
vl_label = labels(seq(splitpoint+1:end),:);

end