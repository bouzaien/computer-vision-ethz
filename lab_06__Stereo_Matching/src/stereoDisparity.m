function disp = stereoDisparity(img1, img2, dispRange)

% dispRange: range of possible disparity values
% --> not all values need to be checked
best = ones(size(img1)) * realmax; % max value possible
h_size = 5;
h = fspecial('average', h_size);

for d = dispRange
    % shif image by d
    shiftedImage = shiftImage(img2, d);
    
    % calculate the squared difference between images 
    ssd = (img1 - shiftedImage).^2;
    
    % apply box filter
    current = conv2(ssd, h, 'same');
    
    % get mask
    mask = current < best;
    
    % update best values
    current = d.*mask + current.*(~mask); 
    best = current.*mask + best.*(~mask);
end
disp = uint8(current);
end