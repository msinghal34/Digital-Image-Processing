%% UNSHARP MASKING OF IMAGES
% * Performing Unsharp Masking on the given two images.
% * Convolve the blurred image with a gaussian mask.
% * Then, add the negative of this image with the original image.
% Scale this "unsharp mask" and add it back to the original image.

%% PARAMETERS FOR THE FUNCTION
% * Standard deviation of the gaussian = std 
% * Size of the gaussian filter = fs 
% * Scaling factor = s 
%% Image - lionCrop.mat
% * Standard deviation of the gaussian = std = 7
% * Size of the gaussian filter = fs = 5 (5 X 5 matrix)
% * Scaling factor = s = 2
s1 = 2;
std1 = 7;
fs1 = 5;

x = load('../data/lionCrop.mat');
x1 = x.imageOrig;
myUnsharpMasking(s1,std1,x1,fs1);

%% Image - superMoonCrop.mat
% * Standard deviation of the gaussian = std = 8
% * Size of the gaussian filter = fs = 8 (8 X 8 matrix)
% * Scaling factor = s = 2
s2 = 2;
std2 = 8;
fs2 = 8;

y = load('../data/superMoonCrop.mat');
y1 = y.imageOrig;
myUnsharpMasking(s2,std2,y1,fs2);