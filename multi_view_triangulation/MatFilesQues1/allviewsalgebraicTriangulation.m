function [pts3D] = allviewsalgebraicTriangulation(pts2D, ProjMat_1, ProjMat_2, ProjMat_3,ProjMat_4,ProjMat_5,ProjMat_6,ProjMat_7,ProjMat_8)
    %% Calculating the 3D coordinates using Linear Triangulation %%
    A = [pts2D(1,1)*ProjMat_1(3,:) - ProjMat_1(1,:); pts2D(1,2)*ProjMat_1(3,:) - ProjMat_1(2,:);
         pts2D(2,1)*ProjMat_2(3,:) - ProjMat_2(1,:); pts2D(2,2)*ProjMat_2(3,:) - ProjMat_2(2,:);
         pts2D(3,1)*ProjMat_3(3,:) - ProjMat_3(1,:); pts2D(3,2)*ProjMat_3(3,:) - ProjMat_3(2,:);
         pts2D(4,1)*ProjMat_4(3,:) - ProjMat_4(1,:); pts2D(4,2)*ProjMat_4(3,:) - ProjMat_4(2,:);
         pts2D(5,1)*ProjMat_5(3,:) - ProjMat_5(1,:); pts2D(5,2)*ProjMat_5(3,:) - ProjMat_5(2,:);
         pts2D(6,1)*ProjMat_6(3,:) - ProjMat_6(1,:); pts2D(6,2)*ProjMat_6(3,:) - ProjMat_6(2,:);
         pts2D(7,1)*ProjMat_7(3,:) - ProjMat_7(1,:); pts2D(7,2)*ProjMat_7(3,:) - ProjMat_7(2,:);
         pts2D(8,1)*ProjMat_8(3,:) - ProjMat_8(1,:); pts2D(8,2)*ProjMat_8(3,:) - ProjMat_8(2,:);];
    [~, ~, V ] = svd(A);
    pts3D = V(:,end);
end