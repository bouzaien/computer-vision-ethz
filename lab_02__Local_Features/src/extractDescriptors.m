% Extract descriptors.
%
% Input:
%   img           - the gray scale image
%   keypoints     - detected keypoints in a 2 x q matrix
%   
% Output:
%   keypoints     - 2 x q' matrix
%   descriptors   - w x q' matrix, stores for each keypoint a
%                   descriptor. w is the size of the image patch,
%                   represented as vector
function [keypoints, descriptors] = extractDescriptors(img, keypoints)
    Ky = keypoints(1,:) > 50 & keypoints(1,:) < 470;
    Kx = keypoints(2,:) > 50 & keypoints(2,:) < 600;
    K = [Ky;Kx];
    
    keypoints = keypoints(:,find(sum(K~=0)==2));
    descriptors = extractPatches(img, keypoints, 9);
    
end