% =========================================================================
% Exercise 8
% =========================================================================

% Initialize VLFeat (http://www.vlfeat.org/)

%K Matrix for house images (approx.)
K = [  670.0000     0     393.000
         0       670.0000 275.000
         0          0        1];

%Load images
imgName1 = '../data/house.000.pgm';
imgName2 = '../data/house.004.pgm';

img1 = single(imread(imgName1));
img2 = single(imread(imgName2));

%extract SIFT features and match
[fa, da] = vl_sift(img1);
[fb, db] = vl_sift(img2);

%don't take features at the top of the image - only background
filter = fa(2,:) > 100;
fa = fa(:,find(filter));
da = da(:,find(filter));

[matches, scores] = vl_ubcmatch(da, db);

showFeatureMatches(img1, fa(1:2, matches(1,:)), img2, fb(1:2, matches(2,:)), 20);

%% Compute essential matrix and projection matrices and triangulate matched points

%use 8-point ransac or 5-point ransac - compute (you can also optimize it to get best possible results)
%and decompose the essential matrix and create the projection matrices
%da_inliers = da(:,matches(1,inliers));
% get homogenious points and fit fundamental matrix
h_fa = makehomogeneous(fa(1:2, matches(1,:)));
h_fb = makehomogeneous(fb(1:2, matches(2,:)));

[F, inliers] = ransacfitfundmatrix(h_fa, h_fb, 0.0001);

h_fa_inliers = h_fa(:,inliers);
h_fb_inliers = h_fb(:,inliers);

%get inhomogenious points
inh_fa_inliers = makeinhomogeneous(h_fa_inliers);
inh_fb_inliers = makeinhomogeneous(h_fb_inliers);


showFeatureMatches(img1, inh_fa_inliers, img2, inh_fb_inliers, 40);

% essential matrix
E = K'*F*K;

% draw epipolar using the function from lab6
figure(1);
imshow(img1, []);
hold on, plot(h_fa_inliers(1,:), h_fa_inliers(2,:), '*r');
for k = 1:size(h_fa_inliers,2)
    drawEpipolarLines(F'*h_fb_inliers(:,k), img1);
    hold on;
end

figure(2);
imshow(img2, []);
hold on, plot(h_fb_inliers(1,:), h_fb_inliers(2,:), '*r');
for k = 1:size(h_fb_inliers,2)
    drawEpipolarLines(F*h_fa_inliers(:,k), img2);
    hold on;
end

% projetion matrices
x1_calibrated = K \ h_fa_inliers;
x2_calibrated = K \ h_fb_inliers;
Ps{1} = eye(4);
Ps{2} = decomposeE(E, x1_calibrated, x2_calibrated);

%triangulate the inlier matches with the computed projection matrix
[X_ab, err_ab] = linearTriangulation(Ps{1}, x1_calibrated, Ps{2}, x2_calibrated);
%% Add an addtional view of the scene 

imgName3 = '../data/house.002.pgm';
img3 = single(imread(imgName3));
[fc, dc] = vl_sift(img3);

%match against the features from image 1 that where triangulated
[matches_ac, scores_ac] = vl_ubcmatch(da(:, matches(1,inliers)), dc);
h_fa_2 = h_fa_inliers(:,matches_ac(1,:));
h_fc = makehomogeneous(fc(1:2, matches_ac(2,:)));

[F_ac, inliers_ac] = ransacfitfundmatrix(h_fa_2, h_fc, 0.0001);

h_fa_inliers_ac = h_fa_2(:,inliers_ac);
h_fc_inliers = h_fc(:,inliers_ac);

%get inhomogenious points
inh_fa_inliers_ac = makeinhomogeneous(h_fa_inliers_ac);
inh_fc_inliers = makeinhomogeneous(h_fc_inliers);


showFeatureMatches(img1, inh_fa_inliers_ac, img3, inh_fc_inliers, 40);


%run 6-point ransac
x3_calibrated = K \ h_fc_inliers;
[Ps{3}, inliers_ac_p] = ransacfitprojmatrix(x3_calibrated, X_ab(:,matches_ac(1,inliers_ac)), 0.001);

%triangulate the inlier matches with the computed projection matrix
[X_ac, err_c] = linearTriangulation(Ps{1}, x1_calibrated(:,inliers_ac), Ps{3}, x3_calibrated);
%% Add more views...

%% Plot stuff

fig = 10;
figure(fig);
%use plot3 to plot the triangulated 3D points
plot3(X_ab(1,inliers_ac),X_ab(2,inliers_ac),X_ab(3,inliers_ac),'r.'); hold on;
plot3(X_ac(1,:),X_ac(2,:),X_ac(3,:),'g.'); hold on;

%draw cameras
drawCameras(Ps, fig);
zlim([-5 5])
