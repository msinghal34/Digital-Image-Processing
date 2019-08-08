tic;
%% MEAN SHIFT SEGMENTATION
% * First, as required by the question, the image is convolved with a
% gaussian filter of standard deviation = 1
% * Then the image is resized to half the original size
% * Then Mean Shift Segmentation is performed on the image
% * Then the image is Linear Contrast Stretched to the range [0,255]
% * The given function returns the number of segments

%% PARAMETERS FOR THE FUNCTION
% * Number of iterations used in the algorithm = iterations
% * The bandwidth of the spatial kernel = hr
% * The bandwidth of the color kernel = hs
% * image = I

%% FIXED PARAMTERS IN THE ALGORITHM
% * The size of the gaussain mask for filtering is 7
% * The number of Nearest Neighbours chosen is 100 

%% baboonColor.png
% * hr = 16
% * hs = 64
% * iterations = 25

image = imread('../data/baboonColor.png');
[segments, FI] = myMeanShiftSegmentation(image,25,32,64);
%%
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized')
subplot(1,2,1);
imshow(image), colorbar;
title('Original')
subplot(1,2,2);
imshow(FI), colorbar;
title('After Mean Shift Segmentation');

fprintf('Number of Different Pixel Intensities = %d \n',segments);
toc;