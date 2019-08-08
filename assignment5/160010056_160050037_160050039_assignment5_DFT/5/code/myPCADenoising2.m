function [denoisedImage] = myPCADenoising2(noisyImage, sigma, PATCH_SIZE, WINDOW_SIZE, L)
    
    imageSize = size(noisyImage, 1); % Size of the image

    denoisedImage = zeros(imageSize,imageSize);
    count = zeros(imageSize,imageSize);

    for x=1:imageSize-PATCH_SIZE+1
        for y=1:imageSize-PATCH_SIZE+1
            referencePatch = noisyImage(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1);
            referencePatch = referencePatch(:);

            % Get all the patches in the window
            window = noisyImage(max(1,x-floor(WINDOW_SIZE/2)):min(imageSize, x+floor(WINDOW_SIZE/2)),max(1,y-floor(WINDOW_SIZE/2)):min(imageSize, y+floor(WINDOW_SIZE/2)));
            patches = im2col(window, [PATCH_SIZE PATCH_SIZE], 'sliding');

            % Get all the L nearest patches
            differencePatches = sum((patches - referencePatch).^2);
            [~, I] = mink(differencePatches, L);
            similarPatches = patches(:,I);

            % Calculate eigenCoefficients
            CovarianceMatrix = similarPatches*similarPatches';
            [eigenVectors, ~] = eig(CovarianceMatrix);
            eigenCoefficients = eigenVectors'*similarPatches;

            alphaSquare = max(0, sum(eigenCoefficients.^2, 2)/size(I,2) - sigma*sigma);

            % Generate denoisedPatch
            eigenCoefficients(:,1) = eigenCoefficients(:,1)./(1 + (sigma*sigma)./alphaSquare(:));
            denoisedPatch = eigenVectors*eigenCoefficients(:,1);

            % Add denoised patch to denoised Image by doing averaging
            denoisedPatch = reshape(denoisedPatch, [PATCH_SIZE PATCH_SIZE]);
            denoisedImage(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) = denoisedImage(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) + denoisedPatch;
            count(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) = count(x:x+PATCH_SIZE-1,y:y+PATCH_SIZE-1) + ones(PATCH_SIZE);
        end
    end

    denoisedImage = denoisedImage./count; % Averaging
end