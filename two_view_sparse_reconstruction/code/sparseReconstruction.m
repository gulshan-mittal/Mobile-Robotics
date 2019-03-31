%% Reading of images %%
img1 = imread('../images/img1.png');
img2 = imread('../images/img2.png');
img1 = rgb2gray(im2double(img1));
img2 = rgb2gray(im2double(img2));

%% SURF & Feature Extraction %%
points1 = detectSURFFeatures(img1, 'MetricThreshold', 10);
points2 = detectSURFFeatures(img2, 'MetricThreshold', 10);
[f1,vpts1] = extractFeatures(img1,points1);
[f2,vpts2] = extractFeatures(img2,points2);
indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

%% Plotting Matched features %%
figure; 
ax = axes;
showMatchedFeatures(img1,img2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
legend(ax, 'Matched points 1','Matched points 2');
title(ax, 'Showing matched features & images');

%% Calculating Fundamental Matrix in Ransac framework %%
pts1 = [transpose(matchedPoints1.Location);ones(1,size(transpose(matchedPoints1.Location),2))];
pts2 = [transpose(matchedPoints2.Location);ones(1,size(transpose(matchedPoints2.Location),2))];
[fransac, indices] = ransacEstimation(pts1, pts2);
disp('---------------------------------------------------------------------');
disp('Fundamental Matrix Matrix:');
disp(fransac/fransac(end));
disp('---------------------------------------------------------------------');

%% Estimation of Essential Matrix %%
load K
E = K' * fransac * K;
[U, S, V] = svd(E);
new_S = diag([(S(1,1) + S(2,2))/2, (S(1,1) + S(2,2))/2, 0]); % New S matrix so that rank is equal to 2
E = U * new_S * V';
disp('Essential Matrix:');
disp(E);
disp('---------------------------------------------------------------------');

%% Decompose Essential Matrix into R and T && Reconstruct hte scene
load K
pts1 = pts1(:,indices);
pts2 = pts2(:,indices);
[R,t] = decomposeEssentialMatrix(E, pts1, pts2, K);
disp('Rotational Matrix:');
disp(R);
disp('---------------------------------------------------------------------');
disp('Translation Matrix:');
disp(t);

%% Reconstruct the scene:
ProjMat_1 = K*[eye(3,3) [0 0 0]'];
ProjMat_2 = K*[R,t];
points_3D = algebraicTriangulation(pts1, pts2, ProjMat_1, ProjMat_2);
points_3D_homogenised = points_3D./repmat(points_3D(4,:), 4, 1);
Pose = [eye(3,3), [0 0 0]'; 0 0 0 1];
% Display 3D coordinates.
figure;
scatter3(points_3D_homogenised(1,:),points_3D_homogenised(2,:),points_3D_homogenised(3,:),'filled');
xlabel('x axis');
ylabel('y axis');
zlabel('z axis');
title('Display 3D cube');
hold on;
plotCameraFrustum(Pose, 'red', 0.3);
hold on;
Pose1 = [R, t; 0 0 0 1];
plotCameraFrustum(Pose1, 'blue', 0.3);
hold off;
