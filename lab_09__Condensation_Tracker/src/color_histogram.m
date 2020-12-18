function hist = color_histogram(xMin,yMin,xMax,yMax,frame,hist_bin)
%COLOR_HISTOGRAM Summary of this function goes here
%   Return a matrix of size [hist_bin,3]: one column for each channel
bbox = frame(yMin:yMax, xMin:xMax, :);
R = imhist(bbox(:,:,1), hist_bin);
G = imhist(bbox(:,:,2), hist_bin);
B = imhist(bbox(:,:,3), hist_bin);
hist = [R, G, B];
hist = hist/sum(hist,'all');

% b = bar(hist);
% b(1).FaceColor = 'r';
% b(2).FaceColor = 'g';
% b(3).FaceColor = 'b';

hist = reshape(hist, 1, 3 * hist_bin);
end

