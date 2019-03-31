function [normPts2D, T] = normalize2DPoints(pts2D)
    
    %% Normalize the 2D points of each image to avoid ill conditioning of system F estimation%%
    transformedPoints = pts2D(1:2,:); %Store pts temporary as we wil use it to get normalize coordinates
    centrePoints = mean(transformedPoints,2); % Give centrepoints
    centre = [centrePoints(1,1), centrePoints(2,1)]; %% Centre in x and y direction respectively
    transformedPoints = transformedPoints - centrePoints; %subtracting mean from points
    %% Calculating Mean of sum of squares of transformed points (points after subtracting mean)
    summmation = sum(transformedPoints.^2);
    sqrt_summation = sqrt(summmation);
    dis = mean(sqrt_summation);
    %% Average distance to the points is equalto sqrt(2) %%
    scale = sqrt(2)/dis;
    %% T is the transform which does the normalization & used later for denormalize the F matrix %%
    T = [scale, 0, -scale*centre(1); 0, scale, -scale*centre(2); 0, 0, 1];
    %% Normalized 2D points %%
    normPts2D= T * pts2D;
end