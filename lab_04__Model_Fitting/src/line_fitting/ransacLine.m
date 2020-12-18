function [best_k, best_b] = ransacLine(data, iter, threshold)
% data: a 2xn dataset with n data points
% iter: the number of iterations
% threshold: the threshold of the distances between points and the fitting line

num_pts = size(data, 2); % Total number of points
best_num_inliers = 0;   % Best fitting line with largest number of inliers
best_k = 0; best_b = 0;     % parameters for best fitting line

for i=1:iter
    % Randomly select 2 points and fit line to these
    % Tip: Matlab command randperm / randsample is useful here
    p = randperm(num_pts,2);
    points = data(:,p);
    
    % Model is y = k*x + b. You can ignore vertical lines for the purpose
    % of simplicity.
    k = (points(2,1) - points(2,2)) / (points(1,1) - points(1,2));
    b = points(2,1) - k * points(1,1);
    
    % Compute the distances between all points with the fitting line
    distances = point_to_line_distance(data',points(:,1)',points(:,2)');
        
    % Compute the inliers with distances smaller than the threshold
    current_num_inliers = sum(distances<threshold);
        
    % Update the number of inliers and fitting model if the current model
    % is better.
    if current_num_inliers > best_num_inliers
        best_num_inliers = current_num_inliers;
        best_k = k;
        best_b = b;
    end
        
end

end
