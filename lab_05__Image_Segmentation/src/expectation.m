function P = expectation(mu,var,alpha,X)
% calculate the probability that xl is in segment k
% and store it in P(l,k)
% mu: 3xK
% var: 3x3
% alpha: 1x3
% X: Lx3

K = length(alpha);
L = size(X,1);

P = zeros(L,K);

for k=1:K
    alpha_k = alpha(k);
    var_k = var(:,:,k);
    inv_var_k = pinv(var_k);
    c = alpha_k / (sqrt(((2*pi)^3)*det(var_k)));
    for l=1:L
        P(l,k) = c * exp(-0.5 * (X(l,:)'-mu(:,k))' * inv_var_k * (X(l,:)'-mu(:,k)) );
    end
end

Z = sum(P,2);
P = P ./ Z;

end