% bestcv = 0; bestc = 0; bestg = 0;
% for log2c = 2:5,
%   for log2g = 1.81:0.003:1.84,
%     cmd = ['-q -t 2 -v 10 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
%     cv = svmtrain(tr_l, tr_d, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
%     end
%     fprintf('c=%g g=%g logc=%g logg=%g %g (best c=%g, g=%g, rate=%g)\n', 2^log2c, 2^log2g, log2c, log2g, cv, bestc, bestg, bestcv);
%   end
% end
% c = 10; g = 1.5; CV = 88.16%
% c = 16; g = 2; CV = 88.16%
% c = 32; g = 0.5; CV = 88.11%
% Best c = 4; g = 3.55784 CV = 89%

% Submission 3 without skewed column
%  rbf_svm = svmtrain(tr_l, tr_d, ['-q -t 2 -c 4 -g 3.55784']);


% With only correleation 3 variables

bestcv = 0; bestc = 0; bestg = 0;
for log2c = 2:5,
  for log2g = 1.81:0.003:1.84,
    cmd = ['-q -t 2 -v 10 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    cv = svmtrain(tr_l, tr_d, cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('c=%g g=%g logc=%g logg=%g %g (best c=%g, g=%g, rate=%g)\n', 2^log2c, 2^log2g, log2c, log2g, cv, bestc, bestg, bestcv);
  end
end