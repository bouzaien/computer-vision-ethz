function [map, cluster] = EM(img,K)
% L*a*b* image
% K: number of segments

% use function generate_mu to initialize mus
% use function generate_cov to initialize covariances
X = reshape(img,[],3);
[x, y, ~] = size(img);

mu = generate_mu(X,K);
var = generate_cov(X,K);
alpha = repmat(1/K,1,K);

% iterate between maximization and expectation
% use function maximization
% use function expectation
t = 0.5;
e = Inf;
while e > t
   P = expectation(mu,var,alpha,X);
   [new_mu, new_var, new_alpha] = maximization(P, X);
   e = max(vecnorm(new_mu-mu,2,1));
   mu = new_mu;
   var = new_var;
   alpha = new_alpha;
end

[~,inx] = max(P,[],2);
map = reshape(inx,[x, y]);
cluster = mu';
mu
var
alpha
end