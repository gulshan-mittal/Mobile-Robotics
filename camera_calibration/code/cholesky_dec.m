function y = cholesky_dec(homo1,homo2,homo3,homo4,homo5)
    matrix_V1 = matrix_V(homo1,homo2,homo3,homo4,homo5);
    %Matrix B
    [~,~,V] = svd(matrix_V1);
    % b = V(6,:);

    b = V(:,6);
    B = [b(1), b(2), b(3) ; b(2),b(4), b(5); b(3),b(5), b(6)];
    B = (B + B')/2;

    %Cholesky
    cholesky_dec = chol(B, 'lower');
    K = pinv((cholesky_dec'));
    K = K(:,:)./K(3,3);
    y = K;
end