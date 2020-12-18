function diffs = diffsGC(img1, img2, dispRange)

% get data costs for graph cut
d = dispRange(end) - dispRange(1);
h_size = 7; % the average box size
h = fspecial('average', h_size);
diffs = zeros(size(img1,1), size(img1,2), d); % m x n x d

for i = 0:d
    shifted = shiftImage(img2, i-ceil(d/2));
    ssd = (img1 - shifted).^2;
    diffs(:,:,i+1) = conv2(ssd, h, 'same');
end
end