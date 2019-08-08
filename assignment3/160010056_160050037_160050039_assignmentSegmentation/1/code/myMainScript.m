tic;
%% Assignment 3:    Question 1:
% This script performs harris corner detection

I = load('../data/boat.mat');

k = 0.04;
smoothingSigma = 1.33;
weightsSigma = 1.33;
[I, Ix, Iy, eig1, eig2, corner] = myHarrisCornerDetector(I, smoothingSigma, weightsSigma, k);

%%
imagesc(I);
title('Original Image');
colormap gray;

colorbar;

%%
imagesc(Ix);
title('Derivative of image along x axis');
colormap gray;

colorbar;

%%

imagesc(Iy);
title('Derivative of image along y axis');
colormap gray;

colorbar;

%%
imagesc(eig1);
title('Max Eigen values');
colormap gray;

colorbar;

%%
imagesc(eig2);
title('Min Eigen Values')
colormap gray;

colorbar;

%%
imagesc(corner);
title('Harris Cornerness Measure');
colormap gray;

colorbar;

%% Optimal Values: 
fprintf('%s%f\n%s%f\n%s%f\n','Weights gaussian standard deviation: ',weightsSigma, 'Gaussian for smoothing standard deviation: ', smoothingSigma, 'Tuned value of k is ',k);
toc;