function [map, peak] = meanshiftSeg(img,r)

X = reshape(img,[],3);
[L, ~] = size(X);
[x, y, ~] = size(img);

map = zeros([L, 1]);

peak = find_peak(X, X(1,:), r);
map(1) = 1;

for i=2:L
    peak_i = find_peak(X, X(i,:), r);
    curr_peak_mat = repmat(peak_i, size(peak,1), 1);
    distances = sqrt( sum( (peak - curr_peak_mat).^2, 2) );
    idx = find(distances < (r/2));
    if isempty(idx) % no close peaks found
        peak = [peak;peak_i];
        map(i) = size(peak,1);
    else % close peaks found
        map(i) = idx(1);
    end
end

map = reshape(map,[x,y]);

end