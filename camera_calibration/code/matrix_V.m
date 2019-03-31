function y = matrix_V(homo1, homo2, homo3, homo4, homo5)
    % V12
    v12_img1 = exp_constraints(1,2,homo1);
    v12_img2 = exp_constraints(1,2,homo2);
    v12_img3 = exp_constraints(1,2,homo3);
    v12_img4 = exp_constraints(1,2,homo4);
    v12_img5 = exp_constraints(1,2,homo5);

    %V11
    v11_img1 = exp_constraints(1,1,homo1);
    v11_img2 = exp_constraints(1,1,homo2);
    v11_img3 = exp_constraints(1,1,homo3);
    v11_img4 = exp_constraints(1,1,homo4);
    v11_img5 = exp_constraints(1,1,homo5);

    %V22
    v22_img1 = exp_constraints(2,2,homo1);
    v22_img2 = exp_constraints(2,2,homo2);
    v22_img3 = exp_constraints(2,2,homo3);
    v22_img4 = exp_constraints(2,2,homo4);
    v22_img5 = exp_constraints(2,2,homo5);

    matrix_V1 = [v12_img1'; v11_img1' - v22_img1'];
    matrix_V2 = [v12_img2'; v11_img2' - v22_img2'];
    matrix_V3 = [v12_img3'; v11_img3' - v22_img3'];
    matrix_V4 = [v12_img4'; v11_img4' - v22_img4'];
    matrix_V5 = [v12_img5'; v11_img5' - v22_img5'];
    res  = [matrix_V1;matrix_V3;matrix_V4;matrix_V5];
    y = res;
end