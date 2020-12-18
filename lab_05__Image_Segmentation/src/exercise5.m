function exercise5()

% load image
img = imread('cow.jpg');
% for faster debugging you might want to decrease the size of your image
% (use imresize)
% (especially for the mean-shift part!)

figure, imshow(img), title('original image')

% smooth image (6.1a)
% (replace the following line with your code for the smoothing of the image)
imgSmoothed = imgaussfilt(img,5,'FilterSize',5);
figure, imshow(imgSmoothed), title('smoothed image')

% convert to L*a*b* image (6.1b)
% (replace the folliwing line with your code to convert the image to lab
% space
imglab = rgb2lab(imgSmoothed);
figure, imshow(imglab(:,:,3),[]), title('l*a*b* channel 3')

% (6.2)
r = 3;
[mapMS, peak] = meanshiftSeg(imglab,r);
visualizeSegmentationResults(mapMS,peak);

% (6.3)
K = 2;
[mapEM, cluster] = EM(imglab,K);
visualizeSegmentationResults(mapEM,cluster);

end