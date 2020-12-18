% Compute the fundamental matrix using the eight point algorithm and RANSAC
% Input
%   x1, x2 	  Point correspondences 3xN
%   threshold     RANSAC threshold
%
% Output
%   best_inliers  Boolean inlier mask for the best model
%   best_F        Best fundamental matrix
%
function [best_inliers, best_F] = ransac8pF(x1, x2, threshold)
n = size(x1,2)

iter = 1000;

num_pts = size(x1, 2); % Total number of correspondences
best_num_inliers = 0; best_inliers = [];
best_F = 0;

M = 0;
pr = 0;

while pr<0.99
    M = M + 1;
    % Randomly select 8 points and estimate the fundamental matrix using these.
    p = randperm(num_pts,8);
    x1s = x1(:,p);
    x2s = x2(:,p);
    [Fh, ~] = fundamentalMatrix(x1s, x2s);
    % Compute the error.
    error = ( distPointsLines(x2, Fh * x1) + distPointsLines(x1, Fh' * x2) ) / 2;
    % Compute the inliers with errors smaller than the threshold.
    current_inliers = error<threshold;
    current_num_inliers = sum(current_inliers);
    
    % Update the number of inliers and fitting model if the current model
    % is better.
    if current_num_inliers > best_num_inliers
        best_num_inliers = current_num_inliers;
        best_F = Fh;
        best_inliers = current_inliers;
        pr = 1 - (1-(current_num_inliers/n)^8)^M;
    end
end
M

% for i=1:iter
%     % Randomly select 8 points and estimate the fundamental matrix using these.
%     p = randperm(num_pts,8);
%     x1s = x1(:,p);
%     x2s = x2(:,p);
%     [Fh, ~] = fundamentalMatrix(x1s, x2s);
%     % Compute the error.
%     error = ( distPointsLines(x2, Fh * x1) + distPointsLines(x1, Fh' * x2) ) / 2;
%     % Compute the inliers with errors smaller than the threshold.
%     current_inliers = error<threshold;
%     current_num_inliers = sum(current_inliers);
%     
%     % Update the number of inliers and fitting model if the current model
%     % is better.
%     if current_num_inliers > best_num_inliers
%         best_num_inliers = current_num_inliers;
%         best_F = Fh;
%         best_inliers = current_inliers;
%     end
% end

end


