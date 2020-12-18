%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xy: size 2xn
% XYZ: size 3xn 

function [P, K, R, t, error] = runGoldStandard(xy, XYZ)
N = size(xy, 2);

%normalize data points
[xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ);

%compute DLT with normalized coordinates
[P_normalized] = dlt(xy_normalized, XYZ_normalized);

%minimize geometric error to refine P_normalized
% TODO fill the gaps in fminGoldstandard.m
pn = [P_normalized(1,:) P_normalized(2,:) P_normalized(3,:)];
for i=1:20
    [pn] = fminsearch(@fminGoldStandard, pn, [], xy_normalized, XYZ_normalized);
end

% TODO: denormalize projection matrix
p_n = [pn(1:4);pn(5:8);pn(9:12)];
P = inv(T) * p_n * U;

%factorize prokection matrix into K, R and t
[K, R, t] = decompose(P);

% TODO compute average reprojection error
pp = p_n * XYZ_normalized;
N = size(pp,2);
for i=1:N
    pp(:,i) = pp(:,i) / pp(end,i);

e = pp - xy_normalized;
e = e(1:end-1,:);
error = mean(vecnorm(e, 2, 1).^2);
end