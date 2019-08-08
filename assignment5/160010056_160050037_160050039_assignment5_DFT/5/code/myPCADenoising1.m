function [denoisedImage] = myPCADenoising1(noisyImage, sigma, PATCH_SIZE)
    imageSize = size(noisyImage, 1); % Size of the image

    denoisedImage = zeros(imageSize,imageSize);
    count = zeros(imageSize,imageSize);

    patches = im2col(noisyImage, [PATCH_SIZE PATCH_SIZE], 'sliding');
    N = size(patches, 2);
    covarianceMatrix = patches*patches';
    [eigenVectors, ~] = eig(covarianceMatrix);

    eigenCoefficients = eigenVectors'*patches;
    alphaSquare = max(0, sum(eigenCoefficients.^2, 2)/N - sigma*sigma);

    % denoising eigenCoefficients
    for i=1:N
        eigenCoefficients(:,i) = eigenCoefficients(:,i)./(1 + (sigma*sigma)./alphaSquare(:));
    end
    
    denoisedPatches = eigenVectors*eigenCoefficients;
    
    for x=1:imageSize-PATCH_SIZE+1
        for y=1:imageSize-PATCH_SIZE+1
            denoisedPatch = reshape(denoisedPatches(:,(x + (y-1)*250)), [PATCH_SIZE PATCH_SIZE]);
            denoisedImage(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) = denoisedImage(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) + denoisedPatch;
            count(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) = count(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) + ones(PATCH_SIZE);
        end
    end
    
    denoisedImage = denoisedImage./count; % Averaging
end