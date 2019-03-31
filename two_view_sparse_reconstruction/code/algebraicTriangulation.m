function [pts3D] = algebraicTriangulation(pts2D_1, pts2D_2, ProjMat_1, ProjMat_2)
    cols = size(pts2D_1,2);
    pts3D = eye(4,cols);
    %% Calculating the 3D coordinates using Linear Triangulation %%
    for i=1:cols
        A = [pts2D_1(1,i)*ProjMat_1(3,:) - ProjMat_1(1,:); pts2D_1(2,i)*ProjMat_1(3,:) - ProjMat_1(2,:);
             pts2D_2(1,i)*ProjMat_2(3,:) - ProjMat_2(1,:); pts2D_2(2,i)*ProjMat_2(3,:) - ProjMat_2(2,:);];
        [~, ~, V ] = svd(A);
        pts3D(:,i) = V(:,end);
    end
end