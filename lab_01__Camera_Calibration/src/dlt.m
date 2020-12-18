%% !!! DO NOT CHANGE THE FUNCTION INTERFACE, OTHERWISE, YOU MAY GET 0 POINT !!! %%
% xyn: 3xn
% XYZn: 4xn

function [P_normalized] = dlt(xyn, XYZn)
%computes DLT, xy and XYZ should be normalized before calling this function
N = size(xyn, 2);
% TODO 1. For each correspondence xi <-> Xi, computes matrix Ai
A = zeros(2*N,12);
for i = 1:N
    Ai = [transpose(XYZn(1:end,i)) zeros(1,4) -xyn(1,i)*transpose(XYZn(1:end,i));
        zeros(1,4) -transpose(XYZn(1:end,i)) xyn(2,i)*transpose(XYZn(1:end,i))];
    A(2*i-1:2*i,1:end) = Ai;

% TODO 2. Compute the Singular Value Decomposition of Usvd*S*V' = A
[~,~,V] = svd(A);

% TODO 3. Compute P_normalized (=last column of V if D = matrix with positive
% diagonal entries arranged in descending order)
P_vec = V(1:end,end);
P_normalized = reshape(P_vec, [3 4]);
end
