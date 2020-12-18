% Normalization of 2d-pts
% Inputs: 
%           xs = 2d points
% Outputs:
%           nxs = normalized points
%           T = 3x3 normalization matrix
%               (s.t. nx=T*x when x is in homogenous coords)
function [nxs, T] = normalizePoints2d(xs)
    N = size(xs,2);

    % compute centroids
    c_xs = mean(xs, 2);

    % compute scale
    s_xs = std(xs,0,2);
    
    % create T
    T_inv = diag([s_xs(1) s_xs(2) 1]);
    T_inv(1:end,3) = [c_xs];
    T = inv(T_inv);
    % normalize the points according to the transformations
    nxs = T * xs;
end
