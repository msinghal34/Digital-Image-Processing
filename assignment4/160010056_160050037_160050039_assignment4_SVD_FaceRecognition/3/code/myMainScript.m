%% Q3

%% 
% What will happen if you test your system on images of people which were not part of the training set? (i.e. the last 8 people from the ORL database)?
%
% Ans: They will be identified as some person from 1 - 32 (according to whoever has the minimum squared difference.)
%
%
% What mechanism will you use to report the fact that there is no matching identity? Work this out carefully and explain briefly in your report.
%
% Ans: We will use a threshold over squaredDiff. If the minimum difference is bigger than threshold then we will treat it as if there is no matching
% identity. But it will create some falseNegatives as well. So, we should optimize the value of threshold to minimize both falseNegatives & falsePositives
%
%
% How many false positives/negatives did you get?
%
% Number of falseNegatives = 26
%
% Number of falsePositives = 7

tic;
clear;
clc;

cd("../data/");
dimension = 10304; % Dimension of images 112*92

numFolders = 32; % Number of folders to get images from
mainDir = "att_faces/"; % Name of main directory

num1 = 6; % Number of images for training in each directory
num2 = 4; % Number of images for testing in each directory

originalImages = zeros(dimension, numFolders*num1); % Original Images to be stored in a matrix of size dimensions X numFolders*num1
testingImages = zeros(dimension, 40*num2); % Testing Images to be stored in a matrix of size dimensions X numFolders*num2

% Reading images

cd(mainDir); % Change Directory
for i=1:numFolders
    files = dir(sprintf("s%d",i) + "/*.pgm");
    for j=1:num1
        img = imread(convertStringsToChars(sprintf("s%d/",i) + convertCharsToStrings(files(j).name)));
        originalImages(:,(i-1)*num1+j) = double(img(:));
    end
    for j=num1+1:num1+num2
        img = imread(convertStringsToChars(sprintf("s%d/",i) + convertCharsToStrings(files(j).name)));
        testingImages(:,(i-1)*num2+j-num1) = double(img(:));
    end
end
for i=33:40
    files = dir(sprintf("s%d",i) + "/*.pgm");
    for j=num1+1:num1+num2
        img = imread(convertStringsToChars(sprintf("s%d/",i) + convertCharsToStrings(files(j).name)));
        testingImages(:,(i-1)*num2+j-num1) = double(img(:));
    end
end

cd(".."); % Change directory back to parent

originalMean = mean(originalImages,2); % Mean of original images
originalImages = originalImages-originalMean; % Mean deducted original images

% Using economical svd
[U,~,~] = svd(originalImages, 'econ');

eigenVectors = U; % Eigenvectors

k = 170; % Values of eigenvectors to consider

falsePositives = 0;
falseNegatives = 0;
threshold = 2.2e+06;

%Testing Phase
testingImages = testingImages - originalMean; % Subtract originalMean from testing Images
keigenvectors = eigenVectors(:,1:k); % k eigen vectors corresponding to k maximum eigenvalues
originalImgCoeffs = keigenvectors'*originalImages; % Linear Cofficients for original Images
testingImgCoeffs = keigenvectors'*testingImages; % Linear Cofficients for all testing Images

for i=1:size(testingImgCoeffs,2)
    squaredDiff = (originalImgCoeffs-testingImgCoeffs(:,i)).^2; % Squared difference between linear coefficients
    [value, index] = min(sum(squaredDiff)); % Minimum Squared Difference
    if (value <= threshold)
        if (i > 32)
            falsePositives = falsePositives + 1;
        end
    elseif (value > threshold)
        if (i <= 32)
            falseNegatives = falseNegatives + 1;                
        end
    end
end
cd("../code/");
toc;