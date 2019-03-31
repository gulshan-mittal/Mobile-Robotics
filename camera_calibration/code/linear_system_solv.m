function y = linear_system_solv(imagePoints, obj_X)
    M = ones(2 * 48, 9);
    for i=1:48
        xi = imagePoints(i, 1);
        yi = imagePoints(i, 2);
        Xi = obj_X(i, 1);
        Yi = obj_X(i, 2);
        M(2*i-1,:) = [-Xi, -Yi, -1, 0, 0, 0, xi*Xi, xi*Yi, xi];
        M(2*i,:) = [0, 0, 0, -Xi, -Yi, -1, yi*Xi, yi*Yi, yi];
    end
    y = M;
end