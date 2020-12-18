% Extract Harris corners.
%
% Input:
%   img           - n x m gray scale image
%   sigma         - smoothing Gaussian sigma
%                   suggested values: .5, 1, 2
%   k             - Harris response function constant
%                   suggested interval: [4e-2, 6e-2]
%   thresh        - scalar value to threshold corner strength
%                   suggested interval: [1e-6, 1e-4]
%   
% Output:
%   corners       - 2 x q matrix storing the keypoint positions
%   C             - n x m gray scale image storing the corner strength
function [corners, C] = extractHarris(img, sigma, k, thresh)
    % 1.1 Image gradients
    ix = 0.5 * [-1 0 1];
    iy = ix';
    Ix = conv2(img, ix, 'same');
    Iy = conv2(img, iy, 'same');
    
    %1.2 Local auto-correlation matrix
      
    n_mask = [1 1 1; 1 0 1; 1 1 1];
    Ix2 = conv2(imgaussfilt(Ix,sigma).^2, n_mask, 'same');
    Iy2 = conv2(imgaussfilt(Iy,sigma).^2, n_mask, 'same');
    IxIy = conv2(imgaussfilt(Ix .* Iy,sigma), n_mask, 'same');
    
    %Ix2 = conv2(Ix.^2, n_mask, 'same');
    %Iy2 = conv2(Iy.^2, n_mask, 'same');
    %IxIy = conv2(Ix .* Iy, n_mask, 'same');
    
    %1.3 Harris response function
    [xx, yy] = size(IxIy);
    C = zeros(xx,yy);
    for i=1:xx
        for j=1:yy
            Mp = [Ix2(i,j) IxIy(i,j); IxIy(i,j) Iy2(i,j)];
            C(i,j) = det(Mp) - k * trace(Mp)^2;
        end
    end
    BW = imregionalmax(C,8);
    sp = BW & C >= thresh;
    [corners(1,:), corners(2,:)] = find(sp);
end