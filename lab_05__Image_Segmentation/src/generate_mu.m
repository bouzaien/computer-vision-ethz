% Generate initial values for mu
% K is the number of segments

function mu = generate_mu(X, K)

min_X = min(X);
max_X = max(X);

mu = (max_X - min_X) .* rand(K,3) + min_X;
mu = mu'; %3xK
end