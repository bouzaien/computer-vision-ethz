function [wa_x,wa_y,E] = tps_model(Xunwarped,Y,lambda)
% Thin Plate Splines
%   Xunwarped: source points
%   Y: target points
%   lambda: regularizer
%   E: energy

N = size(Xunwarped, 1);
K = zeros(N);

for i=1:N
    for j=1:N
        K(i,j) = U(sqrt(dist2(Xunwarped(i,:),Xunwarped(j,:))));
    end
end
P = [ones(N,1) Xunwarped];

A = [K+lambda*eye(N) P; P' zeros(3)];
b_x = [Y(:,1); zeros(3,1)];
b_y = [Y(:,2); zeros(3,1)];

wa_x = A\b_x;
wa_y = A\b_y;

w_x = wa_x(1:N,:);
w_y = wa_y(1:N,:);

E = w_x' * K* w_x + w_y' * K* w_y;
end

