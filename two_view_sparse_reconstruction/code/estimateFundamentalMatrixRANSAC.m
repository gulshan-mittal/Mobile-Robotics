function f = estimateFundamentalMatrixRANSAC(pts1,pts2)
    %% First Normalise the Coordinates %%
    [pts1,t1] = normalize2DPoints(pts1);
    [pts2,t2] = normalize2DPoints(pts2);
    %% Making of Fundamental Matrix %%
    A = zeros(size(pts1,2),9);
    for i=1:size(pts1,2)
        %%% Storing products in every row of a to calculate F 
        A(i,:) = kron(transpose(pts2(:,i)), transpose(pts1(:,i))); %% Kron(A,B) = [a11*B, a12*B ... a1n*B ;.........; an1*B .... anm*B]
    end
    %%% Taking SVD of A
    [~,~,V] = svd(A);
    %% Calculating Fundamental Matrix %%
    V = V(:,end);
    f = reshape(V,3,3);
    %% Making Rank of Fundamental Matrix = 2 %% 
    [U, S, V] = svd(f');
    new_S = diag([S(1, 1), S(2, 2), 0]);
%     S(size(S,1),size(S,2)) = 0;
    V = V';
    f = U * new_S * V;
    %% Denormalise Fundamental Matrix %%
    f = transpose(t2) * f * t1;
end
