function costMatrixC = chi2_cost(SD1,SD2)
% Calculate the xhi^2 cost
%   SD1 and SD2 are the shapes descriptors.

N1 = numel(SD1);
N2 = numel(SD2);

C = zeros(N1, N2);

for i=1:N1
    for j=1:N2
        C(i,j) =  0.5 * sum(((SD1{i} - SD2{j}).^2) ./ (SD1{i} + SD2{j} + eps), 'all');
    end
end

costMatrixC = C;
end

