function peak = find_peak(X, xl, r)

L = size(X,1);
shift = Inf;
peak = xl;
t = 1;

while shift > t
    distances = sqrt( sum( (X - repmat(peak, [L, 1])).^2, 2 ) );
    nearest_pixels = X(distances<r,:);
    new_peak = mean(nearest_pixels,1);
    shift = norm(new_peak-peak);
    peak = new_peak;
end

end

