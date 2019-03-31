clear;

load cube_imgs.mat
load projMatrices.mat

%%% Extracting 2D points of all view
pts2D_view1 = squeeze(image_pts(1,:,:));
pts2D_view2 = squeeze(image_pts(2,:,:));
pts2D_view3 = squeeze(image_pts(3,:,:));
pts2D_view4 = squeeze(image_pts(4,:,:));
pts2D_view5 = squeeze(image_pts(5,:,:));
pts2D_view6 = squeeze(image_pts(6,:,:));
pts2D_view7 = squeeze(image_pts(7,:,:));
pts2D_view8 = squeeze(image_pts(8,:,:));

%%% Extracting projection matrix of all view
projMat_view1 = projMatrices{1};
projMat_view2 = projMatrices{2};
projMat_view3 = projMatrices{3};
projMat_view4 = projMatrices{4};
projMat_view5 = projMatrices{5};
projMat_view6 = projMatrices{6};
projMat_view7 = projMatrices{7};
projMat_view8 = projMatrices{8};

pts_3d = [];
for i= 1:size(image_pts,3)
    homo_coord_3d = allviewsalgebraicTriangulation(image_pts(:,:,i), projMat_view1,projMat_view2,projMat_view3,projMat_view4,projMat_view5,projMat_view6,projMat_view7,projMat_view8);
    world_coord = [homo_coord_3d(1)/homo_coord_3d(4);homo_coord_3d(2)/homo_coord_3d(4);homo_coord_3d(3)/homo_coord_3d(4)];
    pts_3d = [pts_3d,world_coord];
end

scatter3(pts_3d(1,:), pts_3d(2,:), pts_3d(3,:), 'filled');
title('Reconstructed cube after using all the views for triangulation');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
legend('Cube Points');