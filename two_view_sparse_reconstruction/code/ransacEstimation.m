function [f, inl] = ransacEstimation(pts1,pts2)
    %% Setting Parameters like number of iteration, threshold, probabilities etc. in RANSAC %%
    [~,n,~] = size(pts1);
    number_of_samples = n ;
    prob_outlier = 0.66;
    probability = 0.991;
    sample_size = 8;
    max_iter = log(1-probability)/log(1-(1-prob_outlier).^sample_size);
    max_inliers = 0;  % max_inliers
    indices = [];  %indices of inliers
    threshold = 0.005;  % absolute difference of calculated F and actual F => F(calculated) - F(actual) 
    
    %% RANSAC Algorithm %%
    for i=1:max_iter
        
        %%%% Random selecting of 8 points from points dataset
        ind = randperm(number_of_samples,8);
        tempf = estimateFundamentalMatrixRANSAC(pts1(:,ind),pts2(:,ind)); %temporary F
        tp_match_idx = []; % Array that will store the index of inlier
        tp_num_CorrectMatch = 0; %Initialize with zero in every iteration
        
        %%% Calculating Number of inliers
        for j=1:number_of_samples
            tempVal = pts2(:,j)'*tempf*pts1(:,j); %%% Calculating p' * F * p
            if(threshold > abs(tempVal)) %%% Checking the condition p'* F * p == delta (threshold)
                tp_num_CorrectMatch = tp_num_CorrectMatch + 1; %Increase no of correctly matcyh or inlier by 1
                tp_match_idx = [tp_match_idx; j]; % Apending the index of correctly matched
                
            end
        end
        
        %%% Checking if the number of inliers equals to the given sample
        if (tp_num_CorrectMatch == number_of_samples), indices = tp_match_idx; max_inliers = number_of_samples; break; end
        
        %%% Updating maximum no of inliers in every iteration
        if (tp_num_CorrectMatch > max_inliers), indices = tp_match_idx; max_inliers = tp_num_CorrectMatch; end
    
    end
    %% Estimate fundamnetal matrix
    inl = indices;
    f = estimateFundamentalMatrixRANSAC(pts1(:,indices),pts2(:,indices));
end
