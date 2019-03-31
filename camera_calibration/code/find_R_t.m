function y = find_R_t(K,H)
    r1_1 = pinv(K) * H(:, 1);
    r2_1 = pinv(K) * H(:, 2);
    r3_1 = cross(r1_1, r2_1);
    r3_1 = r3_1 / norm(r3_1);
    y = [r1_1 r2_1 r3_1];
end