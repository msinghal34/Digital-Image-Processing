%% REPORT - QUESTION 1


%% Question 1a: Shrinking by a factor d
input_img1 = '../data/circles_concentric.png';
[I1,map1] = imread(input_img1);
myShrinkImageByFactorD(I1,map1,2);
myShrinkImageByFactorD(I1,map1,3);

%% Question 1b: Bilinear Interpolation
input_img2 = '../data/barbaraSmall.png';
[I2,map2] = imread(input_img2);
[m,n] = size(I2);
myBilinearInterpolation(I2,map2,3*m-2,2*n-1);


%% Question 1c: Nearest Neighbour Interpolation
input_img2 = '../data/barbaraSmall.png';
[I3,map3] = imread(input_img2);
[m,n] = size(I3);
myNearestNeighbourInterpolation(I2,map2,3*m-2,2*n-1);