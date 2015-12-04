% This file contains 4 svm models and their evaluation
%   1. Linear Kernel
%   2. Polynomial Kernel with degree 2
%   3. Polynomial Kernel with degree 4
%   4. Radial Basis Function
% =====================================================

% Load data from imdb.mat
load('data/imdb.mat');
data = reshape(images.data(:,:,:,:),784,[])';
data = data/255; %Scaling the data
label = images.labels(1,:);

%Split data into training and validation
train_data = double(data(1:10000,:));
test_data = double(data(10001:20000,:));
train_label = label(1,1:10000)';
test_label = label(1,10001:20000)';



bestcv = 0; bestc = 0; bestg = 0; bestcoef = 0;
% for c = 0.01:0.01:0.1
%     cmd = ['-q -t 0 -v 2 -c ', num2str(c)];
%     cv = svmtrain(train_label, train_data, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = c;
%     end
%     fprintf('%g %g (best c=%g, rate=%g)\n', c, cv, bestc, bestcv);
% end
% Observation of Linear Kernel After Grid Search
bestc = 0.04;

% Linear Kernel
lin_svm = svmtrain(train_label, train_data, ['-q -t 0 -c ', num2str(bestc)]);
[prediction,accuracy, prob_estm] = svmpredict(test_label, test_data, lin_svm);
lin_svm_result = struct('prediction', prediction,'accuracy',accuracy, 'probability', prob_estm);



% bestcv = 0;
% for log2c = 10
%   for log2g = 3:5
%     for coef = 1:3
%         cmd = ['-q -t 1 -d 2 -v 2 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g), ' -r ', num2str(coef)];
%         cv = svmtrain(train_label, train_data, cmd);
%         if (cv >= bestcv),
%           bestcv = cv; bestc = 2^log2c; bestg = 2^log2g; bestcoef = coef;
%         end
%         fprintf('c=%g g=%g coef=%g Acc=%g (best c=%g, g=%g, coef=%g rate=%g)\n', 2^log2c, 2^log2g, coef, cv, bestc, bestg, bestcoef, bestcv);
%     end
%   end
% end
% Observation after few experiments:
bestc = 1024; bestg=8; bestcoef=2;

% Polynomial Kernel with Degree 2
poly2_svm = svmtrain(train_label, train_data, ['-q -t 1 -d 2 -c ',num2str(bestc), ' -g ', num2str(bestg), ' -r ', num2str(bestcoef)]);
[prediction,accuracy, prob_estm] = svmpredict(test_label, test_data, poly2_svm);
poly2_svm_result =  struct('prediction', prediction,'accuracy',accuracy, 'probability', prob_estm);
% ===============2


% bestcv = 0;
% for c = 1:1:5
%   for g = 0.1:0.1:0.3
%     for coef = 10:100:120
%         cmd = ['-q -t 1 -d 2 -v 5 -c ', num2str(c), ' -g ', num2str(g), ' -r ', num2str(coef)];
%         cv = svmtrain(train_label, train_data, cmd);
%         if (cv >= bestcv),
%           bestcv = cv; bestc = c; bestg = g; bestcoef = coef;
%         end
%         fprintf('c=%g g=%g coef=%g Acc=%g (best c=%g, g=%g, coef=%g rate=%g)\n', c, g, coef, cv, bestc, bestg, bestcoef, bestcv);
%     end
%   end
% end
% Observation after few experiments:
bestc = 0.05; bestg=0.1; bestcoef=10;

% Polynomial Kernel with Degree 4
poly4_svm = svmtrain(train_label, train_data, ['-q -t 1 -d 4 -c ',num2str(bestc), ' -g ', num2str(bestg), ' -r ', num2str(bestcoef)]);
[prediction,accuracy, prob_estm] = svmpredict(test_label, test_data, poly4_svm);
poly4_svm_result =  struct('prediction', prediction,'accuracy',accuracy, 'probability', prob_estm);


%Find the optimal values for free parameters
% bestcv = 0; bestc = 0; bestg = 0;
% for log2c = 1:9:10,
%   for log2g = -6:-4,
%     cmd = ['-q -t 2 -v 3 -c ', num2str(log2c), ' -g ', num2str(2^log2g)];
%     cv = svmtrain(train_label, train_data, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = log2c; bestg = 2^log2g;
%     end
%     fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
%   end
% end
bestc = 2; bestg = 0.03;

% Radial Basis Function Kernel
rbf_svm = svmtrain(train_label, train_data, ['-q -t 2 -c ',num2str(bestc), ' -g ',num2str(bestg)]);
[prediction,accuracy, prob_estm] = svmpredict(test_label, test_data, rbf_svm);
rbf_svm_result = struct('prediction', prediction,'accuracy',accuracy, 'probability', prob_estm);



% Print the result
