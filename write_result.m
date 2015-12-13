function write_result( prediction, filename )
% Write results to a file in csv format that kaggle.com
% accepts for submission.
%   prediction - Final prediction for testData
%   filename   - File name including file extension .csv

result = [reshape(1:size(prediction),[],1), prediction];
filename = strcat('result','/',filename);
csvwrite_with_headers(filename, result, {'Id','Prediction'});

end
