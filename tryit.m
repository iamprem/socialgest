bestcv = 0;
for log2c = 17:20,
  for log2g = -24:-20,
    cmd = ['-q -v 5 -t 2 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    cv = svmtrain(tr_l, tr_d, cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
  end
end

% RBF c=524288, g=9.53674e-07 88.716
% Linear kernel found c = 13, g = doesn't matter, 0.001

% bestcv = 0;
% for c = 13,
%   for log2g = -15
%     cmd = ['-q -v 5 -t 0 -c ', num2str(c), ' -g ', num2str(2^log2g)];
%     cv = svmtrain(tr_l, tr_d, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = c; bestg = 2^log2g;
%     end
%     fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', c, log2g, cv, bestc, bestg, bestcv);
%   end
% end