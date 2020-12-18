%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xy: size 2xn
% XYZ: size 3xn 

function [P, K, R, t, error] = runDLT(xy, XYZ)
N = size(xy, 2);
% normalize 
[xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ);

%compute DLT with normalized coordinates
[Pn] = dlt(xy_normalized, XYZ_normalized);

% TODO denormalize projection matrix
P = inv(T) * Pn * U;

%factorize projection matrix into K, R and t
[K, R, t] = decompose(P);   

% TODO compute average reprojection error
pp = Pn * XYZ_normalized;
N = size(pp,2);
for i=1:N
    pp(:,i) = pp(:,i) / pp(end,i)

e = pp - xy_normalized;
e = e(1:end-1,:);
error = sum(vecnorm(e, 2, 1).^2);
end