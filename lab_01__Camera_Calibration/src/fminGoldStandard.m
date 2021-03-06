%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xy_normalized: 3xn
% XYZ_normalized: 4xn

function f = fminGoldStandard(pn, xy_normalized, XYZ_normalized)

%reassemble P
P = [pn(1:4);pn(5:8);pn(9:12)];

% TODO compute reprojection errors

% TODO compute cost function value
pp = P * XYZ_normalized;
N = size(pp,2);
for i=1:N
    pp(:,i) = pp(:,i) / pp(end,i);

e = pp - xy_normalized;
f = sum(vecnorm(e, 2, 1).^2);
end