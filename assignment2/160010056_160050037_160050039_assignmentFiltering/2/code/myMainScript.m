tic;
%% Assignment 2: Question 2:
% This script performs bilateral filtering on some input images 
% and automatically publishes the results in a formatted HTML document.

%% a) Barbara
I = load('../data/barbara.mat');
I = I.imageOrig;
hs = 1.58;
hi = 13.76;
[k,noisy,im] = myBilateralFiltering(I, hs, hi);
rmsd0 = myRMSD(I,im);
%%
imagesc(I);
title('Original Image');
colormap gray;
colorbar;
%%
imagesc(noisy);
title('Corrupted Image');
colormap gray;
colorbar;
%%
imagesc(im);
title('Filtered Image');
colormap gray;
colorbar;
%%
imagesc(k);
title('Mask for spatial Gaussian');
colormap jet;
colorbar;
%%
% Optimal Values: 
fprintf('%s%f\n%s%f\n%s%f\n','Spatial gaussian standard deviation: ',hs,'Intensity gaussian standard deviation: ', hi, 'Corresponding value of RMSD is ',rmsd0);
[~,~,im] = myBilateralFiltering(I, 0.9*hs, hi);
rmsd1 = myRMSD(I, im);
[~,~,im] = myBilateralFiltering(I, 1.1*hs, hi);
rmsd2 = myRMSD(I,im);
[~,~,im] = myBilateralFiltering(I, hs, 0.9*hi);
rmsd3 = myRMSD(I,im);
[~,~,im] = myBilateralFiltering(I, hs, 1.1*hi);
rmsd4 = myRMSD(I,im);
%%
% Other Readings: 
fprintf('%s\t%s%f\n', 'For Case (i)  :', 'the value of RMSD is ', rmsd1);
fprintf('%s\t%s%f\n', 'For Case (ii) :', 'the value of RMSD is ', rmsd2);
fprintf('%s\t%s%f\n', 'For Case (iii):', 'the value of RMSD is ', rmsd3);
fprintf('%s\t%s%f\n', 'For Case (iv) :', 'the value of RMSD is ', rmsd4);

%% b) grass
I = im2double(imread('../data/grass.png'));
hs = 0.62;
hi = 0.71;
[k,noisy,im] = myBilateralFiltering(I, hs, hi);
rmsd0 = myRMSD(I,im);
%%
imagesc(I);
title('Original Image');
colormap gray;
colorbar;
%%
imagesc(noisy);
title('Corrupted Image');
colormap gray;
colorbar;
%%
imagesc(im);
title('Filtered Image');
colormap gray;
colorbar;
%%
imagesc(k);
title('Mask for spatial Gaussian');
colormap jet;
colorbar;
%%
% Optimal Values: 
fprintf('%s%f\n%s%f\n%s%f\n','Spatial gaussian standard deviation: ',hs,'Intensity gaussian standard deviation: ', hi, 'Corresponding value of RMSD is ',rmsd0);
[~,~,im] = myBilateralFiltering(I, 0.9*hs, hi);
rmsd1 = myRMSD(I, im);
[~,~,im] = myBilateralFiltering(I, 1.1*hs, hi);
rmsd2 = myRMSD(I,im);
[~,~,im] = myBilateralFiltering(I, hs, 0.9*hi);
rmsd3 = myRMSD(I,im);
[~,~,im] = myBilateralFiltering(I, hs, 1.1*hi);
rmsd4 = myRMSD(I,im);
%%
% Other Readings: 
fprintf('%s\t%s%f\n', 'For Case (i)  :', 'the value of RMSD is ', rmsd1);
fprintf('%s\t%s%f\n', 'For Case (ii) :', 'the value of RMSD is ', rmsd2);
fprintf('%s\t%s%f\n', 'For Case (iii):', 'the value of RMSD is ', rmsd3);
fprintf('%s\t%s%f\n', 'For Case (iv) :', 'the value of RMSD is ', rmsd4);

%% c) honeyComb
I = im2double(imread('../data/honeyCombReal.png'));
hs = 0.787;
hi = 0.263;
[k,noisy,im] = myBilateralFiltering(I, hs, hi);
rmsd0 = myRMSD(I,im);
%%
imagesc(I);
title('Original Image');
colormap gray;
colorbar;
%%
imagesc(noisy);
title('Corrupted Image');
colormap gray;
colorbar;
%%
imagesc(im);
title('Filtered Image');
colormap gray;
colorbar;
%%
imagesc(k);
title('Mask for spatial Gaussian');
colormap jet;
colorbar;
%%
% Optimal Values: 
fprintf('%s%f\n%s%f\n%s%f\n','Spatial gaussian standard deviation: ',hs,'Intensity gaussian standard deviation: ', hi, 'Corresponding value of RMSD is ',rmsd0);
[~,~,im] = myBilateralFiltering(I, 0.9*hs, hi);
rmsd1 = myRMSD(I, im);
[~,~,im] = myBilateralFiltering(I, 1.1*hs, hi);
rmsd2 = myRMSD(I,im);
[~,~,im] = myBilateralFiltering(I, hs, 0.9*hi);
rmsd3 = myRMSD(I,im);
[~,~,im] = myBilateralFiltering(I, hs, 1.1*hi);
rmsd4 = myRMSD(I,im);
%%
% Other Readings: 
fprintf('%s\t%s%f\n', 'For Case (i)  :', 'the value of RMSD is ', rmsd1);
fprintf('%s\t%s%f\n', 'For Case (ii) :', 'the value of RMSD is ', rmsd2);
fprintf('%s\t%s%f\n', 'For Case (iii):', 'the value of RMSD is ', rmsd3);
fprintf('%s\t%s%f\n', 'For Case (iv) :', 'the value of RMSD is ', rmsd4);

%%
toc;