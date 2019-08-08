%% Assignment-II Report for CS663 - Fundamentals of Digital Image Processing
% This script performs patch-based filtering on some input images 
% and automatically publishes the results in a formatted HTML document. 
%
% If images are not displayed side by side, zoom out until they are.

I1 = load('../data/barbara.mat');
I2 = im2double(imread('../data/grass.png'));
I3 = im2double(imread('../data/honeyCombReal.png'));
h1 = 5.94;
h2 = 0.0538;
h3 = 0.0621;

%% Barbara
[k1,noisy1,im1] = myPatchBasedFiltering(I1.imageOrig,h1,1.43);
r11 = myRMSD(I1.imageOrig,im1);
%%
imagesc(I1.imageOrig);
title('Original');
colormap gray;
colorbar;
%%
imagesc(noisy1);
title('Corrupted');
colormap gray;
colorbar;
%%
imagesc(im1);
title('Filtered');
colormap gray;
colorbar;
%%
imagesc(k1);
title('Gaussian kernel used on patches');
colormap jet;
colorbar;
%%
fprintf('%s%f%s%f\n','Optimal value of h for this image is ',h1,' and corresponding value of RMSD is ',r11);
[~,~,im1] = myPatchBasedFiltering(I1.imageOrig,0.9*h1,1.43);
r12 = myRMSD(I1.imageOrig,im1);
[~,~,im1] = myPatchBasedFiltering(I1.imageOrig,1.1*h1,1.43);
r13 = myRMSD(I1.imageOrig,im1);
fprintf('%s%f\n','For 90% of optimal value of h, the value of RMSD is ',r12);
fprintf('%s%f\n','For 110% of optimal value of h, the value of RMSD is ',r13);

%% Grass
[k2,noisy2,im2] = myPatchBasedFiltering(I2,h2,0.91);
r21 = myRMSD(I2,im2);
%%
imagesc(I2);
title('Original');
colormap gray;
colorbar;
%%
imagesc(noisy2);
title('Corrupted');
colormap gray;
colorbar;
%%
imagesc(im2);
title('Filtered');
colormap gray;
colorbar;
%%
imagesc(k2);
title('Gaussian kernel used on patches');
colormap jet;
colorbar;
%%
fprintf('%s%f%s%f\n','Optimal value of h for this image is ',h2,' and corresponding value of RMSD is ',r21);
[~,~,im2] = myPatchBasedFiltering(I2,0.9*h2,0.78);
r22 = myRMSD(I2,im2);
[~,~,im2] = myPatchBasedFiltering(I2,1.1*h2,0.78);
r23 = myRMSD(I2,im2);
fprintf('%s%f\n','For 90% of optimal value of h, the value of RMSD is ',r22);
fprintf('%s%f\n','For 110% of optimal value of h, the value of RMSD is ',r23);

%% Honey Comb
[k3,noisy3,im3] = myPatchBasedFiltering(I3,h3,0.95);
r31 = myRMSD(I3,im3);
%%
imagesc(I3);
title('Original');
colormap gray;
colorbar;
%%
imagesc(noisy3);
title('Corrupted');
colormap gray;
colorbar;
%%
imagesc(im3);
title('Filtered');
colormap gray;
colorbar;
%%
imagesc(k3);
title('Gaussian kernel used on patches');
colormap jet;
colorbar;
%%
fprintf('%s%f%s%f\n','Optimal value of h for this image is ',h3,' and corresponding value of RMSD is ',r31);
[~,~,im3] = myPatchBasedFiltering(I3,0.9*h3,0.95);
r32 = myRMSD(I3,im3);
[~,~,im3] = myPatchBasedFiltering(I3,1.1*h3,0.95);
r33 = myRMSD(I3,im3);
fprintf('%s%f\n','For 90% of optimal value of h, the value of RMSD is ',r32);
fprintf('%s%f\n','For 110% of optimal value of h, the value of RMSD is ',r33);