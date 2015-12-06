function write_result( prediction, filename )
%WRITE_RESULT Write results to a file in csv format
%   prediction - Final prediction for testData
%   filename   - File name including file extension .csv

result = [reshape(1:size(prediction),[],1), prediction];
filename = strcat('result','/',filename);
csvwrite_with_headers(filename, result, {'Id','Prediction'});

end

 