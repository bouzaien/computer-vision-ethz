%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xy: size 2xn
% XYZ: size 3xn
% xy_normalized: 3xn
% XYZ_normalized: 4xn
% T: 3x3
% U: 4x4

function [xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ)
%data normalization
N = size(xy,2);

% TODO 1. compute centroids
c_xy = mean(xy, 2);
c_XYZ = mean(XYZ, 2);

% TODO 2. shift the points to have the centroid at the origin
shifted_xy = xy - c_xy;
shifted_XYZ = XYZ - c_XYZ;

% TODO 3. compute scale
s_xy = mean(vecnorm(shifted_xy,2));
s_XYZ = mean(vecnorm(shifted_XYZ,2));

% TODO 4. create T and U transformation matrices (similarity transformation)
T_inv = diag([s_xy s_xy 1]);
T_inv(1:end,3) = [c_xy;1];
T = inv(T_inv);

U_inv = diag([s_XYZ s_XYZ s_XYZ 1]);
U_inv(1:end,4) = [c_XYZ;1];
U = inv(U_inv);

% TODO 5. normalize the points according to the transformations
xy_normalized = T * [xy; ones(1,N)];
XYZ_normalized = U * [XYZ; ones(1,N)];
end