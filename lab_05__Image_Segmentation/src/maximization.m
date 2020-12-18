function [mu, var, alpha] = maximization(P, X)

K = size(P,2);
L = size(X,1);

alpha = mean(P);
mu = zeros(3,K);

for k=1:K
    mu(:,k) = sum(X .* P(:,k))';
end
s = sum(P);
mu = mu ./ s;

var = zeros(3,3,K);

for k=1:K
    temp_var = zeros(3,3);
    for l=1:L
        temp_var = temp_var + P(l,k) * (X(l,:)'-mu(:,k))*(X(l,:)'-mu(:,k))';
    end
    var(:,:,k) = temp_var ./ s(k);
end

end