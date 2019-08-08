%% Face recognition on att_faces using eig
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
testingImages = zeros(dimension, numFolders*num2); % Testing Images to be stored in a matrix of size dimensions X numFolders*num2

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
cd(".."); % Change directory back to parent

originalMean = mean(originalImages,2); % Mean of original images
originalImages = originalImages-originalMean; % Mean deducted original images
L = originalImages'*originalImages; % Calculation of L matrix

[W,~] = eig(L);
eigenVectors = originalImages*W; % Eigenvectors

% Unit-Normalizing eigen vectors
for i=1:size(eigenVectors,2) % equivalent to numfolders*(num1)
    eigenVectors(:,i) = eigenVectors(:,i)./norm(eigenVectors(:,i));
end

k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170]; % Values of eigenvectors to consider

%Testing Phase
answer = zeros(size(k)); % Vector to store correct number of guesses for each value of k
testingImages = testingImages - originalMean; % Subtract originalMean from testing Images
for l=1:size(k,2)
    
    keigenvectors = eigenVectors(:,192-k(l)+1:192); % k eigen vectors corresponding to k maximum eigenvalues
    originalImgCoeffs = keigenvectors'*originalImages; % Linear Cofficients for original Images
    testingImgCoeffs = keigenvectors'*testingImages; % Linear Cofficients for all testing Images
    
    for i=1:size(testingImgCoeffs,2)
        squaredDiff = (originalImgCoeffs-testingImgCoeffs(:,i)).^2; % Squared difference between linear coefficients
        [value, index] = min(sum(squaredDiff)); % Minimum Squared Difference
        
        if (ceil(index/6) == ceil(i/4)) % Should be identified as Person ceil(i/4)
            answer(l) = answer(l) + 1;
        end
    end
end

recognitionRate = (answer./(numFolders*num2)).*100;

% Plotting the results
figure("Name", "Q1(i)(a) Recognition Rate vs K using eig on att_faces");
plot(k, recognitionRate, 'r', 'LineWidth', 2);
xlabel('K');
ylabel('Recognition Rate (%)');
title('Recognition Rate vs K');

cd("../code/");
toc;
