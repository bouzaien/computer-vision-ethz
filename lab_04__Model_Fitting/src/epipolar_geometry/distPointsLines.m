% Compute the distance for pairs of points and lines
% Input
%   points    Homogeneous 2D points 3xN
%   lines     2D homogeneous line equation 3xN
% 
% Output
%   d         Distances from each point to the corresponding line N
function d = distPointsLines(points, lines)
% normalize line vecors
    % z = ( lines(1,:) .^2 + lines(2,:) .^2 ) .^ 0.5;
    % l = lines ./ z;
    a = abs(lines .* points);
    d = sum(a, 1);
end

