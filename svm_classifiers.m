

% lin_svm = svmtrain(tr_label, tr_data, ['-q -t 0 -c 2']); 0.60

% Find the optimal values for free parameters
% bestcv = 0; bestc = 0; bestg = 0;
% for log2c = 1:1:6,
%   for log2g = -8:-1,
%     cmd = ['-q -t 2 -v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
%     cv = svmtrain(tr_label, tr_data, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
%     end
%     fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', 2^log2c, 2^log2g, cv, bestc, bestg, bestcv);
%   end
% end
% c = 16; g = 0.0078125;

% rbf_svm = svmtrain(tr_label, tr_data, ['-q -t 2 -c 20 -g 0.007']); 85.66%
% rbf_svm = svmtrain(tr_label, tr_data, ['-q -t 2 -c 16 -g 0.0078125']); 83.83%
% [prediction, accuracy, prob_estm] = svmpredict(vl_label, vl_data, rbf_svm);
% 
% [prediction, accuracy, prob_estm] = svmpredict(zeros(size(ts_data,1),1), ts_data, rbf_svm);


% % Polynomial 2 degree
% bestcv = 0;
% for log2c = -3:1:3
%   for log2g = -4:4
%     for coef = -10:3:3
%         cmd = ['-q -t 1 -d 2 -v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g), ' -r ', num2str(coef)];
%         cv = svmtrain(tr_label, tr_data, cmd);
%         if (cv >= bestcv),
%           bestcv = cv; bestc = 2^log2c; bestg = 2^log2g; bestcoef = coef;
%         end
%         fprintf('c=%g g=%g coef=%g Acc=%g (best c=%g, g=%g, coef=%g rate=%g)\n', 2^log2c, 2^log2g, coef, cv, bestc, bestg, bestcoef, bestcv);
%     end
%   end
% end
% 
% poly2_svm = svmtrain(tr_label, tr_data, ['-q -t 1 -d 2 -c ',num2str(bestc), ' -g ', num2str(bestg), ' -r ', num2str(bestcoef)]);
% [prediction,accuracy, prob_estm] = svmpredict(vl_label, vl_data, poly2_svm);
% 
% poly2_svm = svmtrain(tr_label, tr_data, ['-q -t 1 -d 2 -c 10 -g 3 -r 10']); 
% Validation 82.16%
 


% Polynomial degree 4
% bestcv = 0;
% for c = [1 5 10]
%   for g = 0.1:0.1:1
%     for coef = [1 5 10]
%         cmd = ['-q -t 1 -d 2 -v 5 -c ', num2str(c), ' -g ', num2str(g), ' -r ', num2str(coef)];
%         cv = svmtrain(tr_label, tr_data, cmd);
%         if (cv >= bestcv),
%           bestcv = cv; bestc = c; bestg = g; bestcoef = coef;
%         end
%         fprintf('c=%g g=%g coef=%g Acc=%g (best c=%g, g=%g, coef=%g rate=%g)\n', c, g, coef, cv, bestc, bestg, bestcoef, bestcv);
%     end
%   end
% end
% Observation after few experiments:
% bestc = 0.05; bestg=0.1; bestcoef=10;

% % Polynomial Kernel with Degree 4
% poly4_svm = svmtrain(tr_label, tr_data, ['-q -t 1 -d 4 -c ',num2str(bestc), ' -g ', num2str(bestg), ' -r ', num2str(bestcoef)]);
% [prediction,accuracy, prob_estm] = svmpredict(vl_label, vl_data, poly4_svm);
% 
% poly4_svm = svmtrain(tr_label, tr_data, ['-q -t 1 -d 4 -c 10 -g 1.9533 -r 260']);
% Validation set 80.66%

% result = [reshape(1:size(prediction),[],1), prediction];
% csvwrite('result/02_1125_0235_01.csv',result);