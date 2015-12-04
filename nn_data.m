% data = cat(1, tr_d, v_d);
% target = cat(1, tr_l, v_l);
% 
% target_d = zeros(size(target,1), 13);
% for i = 1:size(target,1)
%    target_d(i, target(i)) =  1;
% end

% NOTE: Did not improve the score

pred = zeros(1200,1);
res = net(ts_d');
for i = 1:1200
   col = res(:,i);
   pred(i) =  find(col == max(col));
end

disp 'some'