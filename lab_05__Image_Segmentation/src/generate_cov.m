% Generate initial values for the K
% covariance matrices

function cov = generate_cov(X, K)
min_X = min(X);
max_X = max(X);

cov = repmat(diag(max_X - min_X),1,1,K); %3x3xK
end