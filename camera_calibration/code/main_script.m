%reading images
img1 = imread('../images/img1.png');
img2 = imread('../images/img2.png');
img3 = imread('../images/img3.png');
img4 = imread('../images/img4.png');
img5 = imread('../images/img5.png');

%Extracting Checkerboard Corners
[imagePoints1,boardSize1] = detectCheckerboardPoints(img1);
[imagePoints2,boardSize2] = detectCheckerboardPoints(img2);
[imagePoints3,boardSize3] = detectCheckerboardPoints(img3);
[imagePoints4,boardSize4] = detectCheckerboardPoints(img4);
[imagePoints5,boardSize5] = detectCheckerboardPoints(img5);


squareSize = 2.400000e+00;  % in units of 'cm'
XW = generateCheckerboardPoints(boardSize1, squareSize);

% For First Image only
M = linear_system_solv(imagePoints1,XW);
homo1 = homography_mat(M);
homo1 = homo1/homo1(3,3);
homo1 = homo1';


% For image 2
M = linear_system_solv(imagePoints2,XW);
homo2 = homography_mat(M);
homo2 = homo2/homo2(3,3);
homo2 = homo2';

% For image 3
M = linear_system_solv(imagePoints3,XW);
homo3 = homography_mat(M);
homo3 = homo3/homo3(3,3);
homo3 = homo3';

% For image 4
M = linear_system_solv(imagePoints4,XW);
homo4 = homography_mat(M);
homo4 = homo4/homo4(3,3);
homo4 = homo4';

% For image 5
M = linear_system_solv(imagePoints5,XW);
homo5 = homography_mat(M);
homo5 = homo5/homo5(3,3);
homo5 = homo5';

intrinsic_params = cholesky_dec(homo1,homo2,homo3,homo4,homo5);
disp("Camera Matrix taking four Images (img1, img3, img4, img5)");
disp(intrinsic_params);

%% Bonus%%
%Rotatoin Matrix of Img1
R1 = find_R_t(intrinsic_params,homo1);
T1 =  pinv(intrinsic_params) * homo1(:, 3);
disp("Rotation and Translaton Matrix for Img1");
disp(R1);
disp(T1);

%Rotatoin Matrix of Img1
R2 = find_R_t(intrinsic_params,homo2);
T2 =  pinv(intrinsic_params) * homo2(:, 3);
disp("Rotation and Translaton Matrix for Img2");
disp(R2);
disp(T2);

%Rotatoin Matrix of Img3
R3 = find_R_t(intrinsic_params,homo3);
T3 =  pinv(intrinsic_params) * homo3(:, 3);
disp("Rotation and Translaton Matrix for Img3");
disp(R3);
disp(T3);

%Rotatoin Matrix of Img4
R4 = find_R_t(intrinsic_params,homo4);
T4 =  pinv(intrinsic_params) * homo4(:, 3);
disp("Rotation and Translaton Matrix for Img4");
disp(R4);
disp(T4);

%Rotatoin Matrix of Img5
R5 = find_R_t(intrinsic_params,homo5);
T5 =  pinv(intrinsic_params) * homo5(:, 3);
disp("Rotation and Translaton Matrix for Img5");
disp(R5);
disp(T5);
