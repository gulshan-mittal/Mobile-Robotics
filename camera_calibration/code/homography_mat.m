function y = homography_mat(M)
    [~,~,V] = svd(M);
    h = V(:,9)';
    homography = [h(1:3)', h(4:6)', h(7:9)'];
    y  = homography;
end