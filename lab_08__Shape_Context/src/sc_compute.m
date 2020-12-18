function d = sc_compute(X ,nbBins_theta, nbBins_r, smallest_r,biggest_r)
%sc_compute Summary of this function goes here
%   X is 2 by N matrix of point coordinates


N = size(X, 2); % total number of points
d = cell(N,1); % discriptors structure
scale = mean2(sqrt(dist2(X,X)));

smallest_r_log = log(smallest_r);
biggest_r_log = log(biggest_r);

% create grids
r_g = linspace(smallest_r_log, biggest_r_log - ((biggest_r_log - smallest_r_log) / nbBins_r), nbBins_r);
theta_g = linspace(-pi, pi * (1 - 2/nbBins_theta), nbBins_theta);

for i=1:N
    distances = repmat(X(:,i), 1, N) - X; % distances: 2 by N
    distances(:,i) = []; % distances: 2 by N-1
    [theta,r] = cart2pol(distances(1,:),distances(2,:));
    scaled_r = r / scale;
    d{i} = hist3([theta' log(scaled_r)'],'Edges',{theta_g, r_g})';
end


end

