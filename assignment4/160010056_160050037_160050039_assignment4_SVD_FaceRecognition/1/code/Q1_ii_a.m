%% Face recognition on yale Database without adjusting for lighting
tic;
clear;
clc;

cd("../data/");

dimension = 32256; % Dimension of images 192*168

numFolders = 38; % Number of folders to get images from
mainDir = "CroppedYale/"; % Name of main directory
identifier = "yaleB"; % Identifier to identify folders which contain useful images

num1 = 40; % Number of images for training in each subdirectory

originalImages = zeros(dimension, numFolders*num1); % Original Images to be stored in a matrix of size dimensions X numFolders*num1
testingImages = zeros(dimension, 0); % Testing Images to be stored in testingImages

originalImgName = strings(1,0); % To be used to store the persons name. ith originalImages has name originalImgName(i)
testingImgName = strings(1,0); % To be used to store the persons name. ith testingImages has name testingImgName(i)

% Reading images

countTestingImages = 0; % Number of testing images inserted in testingImages so far
cd(mainDir); % Change to main Directory
folders = dir(identifier + "*"); % Subdirectories

for i=1:size(folders,1)
    cd(folders(i).name); % Change directory to a subdirectory
    files = dir("*.pgm");
    
    % Reading images for training
    for j=1:num1
        img = imread(files(j).name);
        originalImages(:,(i-1)*num1+j) = double(img(:));
        originalImgName((i-1)*num1+j) = folders(i).name;
    end
    
    % Reading images for testing
    for j=num1+1:size(files,1)
        img = imread(files(j).name);
        countTestingImages = countTestingImages + 1;
        testingImgName(countTestingImages) = folders(i).name;
        testingImages(:,countTestingImages) = double(img(:));
    end
    
    cd(".."); % Change directory back to main Directory;
end

cd(".."); % Change directory back to parent

originalMean = mean(originalImages,2); % Mean of original images
originalImages = originalImages-originalMean; % Mean deducted original images

% Using economical svd
[U,~,~] = svd(originalImages, 'econ');

eigenVectors = U; % Take all eigenvectors

k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000]; % Values of eigenvectors to consider

%Testing Phase
answer = zeros(size(k)); % Vector to store correct number of guesses for each value of k
testingImages = testingImages - originalMean; % Subtract originalMean from testing Images
for l=1:size(k,2)
    
    keigenvectors = eigenVectors(:,1:k(l)); % k eigen vectors corresponding to k maximum eigenvalues
    originalImgCoeffs = keigenvectors'*originalImages; % Linear Cofficients for original Images
    testingImgCoeffs = keigenvectors'*testingImages; % Linear Cofficients for all testing Images
    
    for i=1:size(testingImgCoeffs,2)
        squaredDiff = (originalImgCoeffs-testingImgCoeffs(:,i)).^2; % Squared difference between linear coefficients
        [value, index] = min(sum(squaredDiff)); % Minimum Squared Difference
        
        if (originalImgName(index) == testingImgName(i)) % Name should be same
            answer(l) = answer(l) + 1;
        end
        
    end
end

recognitionRate = (answer./countTestingImages).*100;

% Plotting the results
figure("Name", "Q1(ii)(a) Face recognition on yale Database without adjusting for lighting");
plot(k, recognitionRate, 'r', 'LineWidth', 2);
xlabel('K');
ylabel('Recognition Rate (%)');
title('Recognition Rate vs K');

cd("../code/");
toc;
