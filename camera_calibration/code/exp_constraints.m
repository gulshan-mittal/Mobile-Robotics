function y = exp_constraints(i,j,H)
    y = [H(1,i)*H(1,j); H(1,i)*H(2,j) + H(2,i)*H(1,j); H(3,i)*H(1,j) + H(1,i)*H(3,j); H(2,i)*H(2,j); H(3,i)*H(2,j) + H(2,i)*H(3,j); H(3,i)*H(3,j)]; 
end