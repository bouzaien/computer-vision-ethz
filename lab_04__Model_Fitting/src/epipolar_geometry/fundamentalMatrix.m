% Compute the fundamental matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences 3xN
%
% Output
% 	Fh 		Fundamental matrix with the det F = 0 constraint
% 	F 		Initial fundamental matrix obtained from the eight point algorithm
%
function [Fh, F] = fundamentalMatrix(x1s, x2s)
    % normalize points
    [nx1s, T1] = normalizePoints2d(x1s);
    [nx2s, T2] = normalizePoints2d(x2s);

    n = size(nx1s,2);
    
    % extract x's and y's
    xs1 = nx1s(1,:);
    ys1 = nx1s(2,:);
    
    xs2 = nx2s(1,:);
    ys2 = nx2s(2,:);
    
    % create the equation matrix as described by equations (2) and (3)
    A = [   
            xs1 .* xs2; 
            xs1 .* ys2; 
            xs1;
            ys1 .* xs2;
            ys1 .* ys2;
            ys1;
            xs2;
            ys2;
            ones(1, n)
        ]'; % transpose
    
    [~,~,V] = svd(A);
    f = V(:,end);
    
    %reshaping and rescaling the fundamental matrix
    F = T2' * reshape(f,[3 3]) * T1;
    
    % enforcing the singularity constraint (last sv = 0)
    [U,S,V] = svd(F);
    S(3,3) = 0;
    Fh = U*S*V';
end