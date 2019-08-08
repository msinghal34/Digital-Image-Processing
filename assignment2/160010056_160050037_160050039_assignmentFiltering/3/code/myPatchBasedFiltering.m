function [mykernel,noisyImage,outputImage] = myPatchBasedFiltering(inputImage,h,a)
    % constants
    PATCH_SIZE = 9;
    WINDOW_SIZE = 29;
    
    % create gaussian kernel
    mykernel = fspecial('gaussian',9,a);
    kernel = mykernel(:);

    % find intensity range in input
    inputSize = size(inputImage);
    minIntensity = min(inputImage(:));
    maxIntensity = max(inputImage(:));
    rangeIntensity = maxIntensity - minIntensity;
    
    % add gaussian noise to input
    noisyImage = inputImage + 0.05 * rangeIntensity * randn(inputSize);
    
    % pre-allocate output matrix
    outputImage = zeros(inputSize);
    
    % run filtering over all pixels
    for y=1:inputSize(1)
        for x=1:inputSize(2)
            % get center patch
            centerPatch = getPatch(noisyImage,PATCH_SIZE,x,y);
            % get window
            window = getWindow(noisyImage,WINDOW_SIZE,x,y);
            % get all patches from window
            patches = im2col(window,[PATCH_SIZE PATCH_SIZE],'sliding');
            % get center pixels from all patches
            centers = patches(ceil(PATCH_SIZE*PATCH_SIZE/2),:);
            % find square differences between patches
            patches = patches - centerPatch;
            patches = patches.^2;
            % apply gaussian kernel
            patches = patches .* kernel;
            % sum for gaussian weighted euclidean distance
            distances = nansum(patches);
            % calculate weights
            weights = exp(-distances/h^2);
            % calculate output pixel intensity
            outputImage(y,x) = sum(weights .* centers) / sum(weights);
        end
    end
end

function patch = getPatch(I,psize,x,y)
    isize = size(I);
    patch = nan(9);
    % calculate pad values
    leftPad = max(0,5-x);
    rightPad = max(0,x-isize(2)+4);
    topPad = max(0,5-y);
    bottomPad = max(0,y-isize(1)+4);
    % calculate patch boundaries
    left = max(1,x-floor(psize/2));
    right = min(isize(2),x+floor(psize/2));
    top = max(1,y-floor(psize/2));
    bottom = min(isize(1),y+floor(psize/2));
    % create patch
    patch(topPad+1:9-bottomPad,leftPad+1:9-rightPad) = I(top:bottom,left:right);
    patch = patch(:);
end

function window = getWindow(I,wsize,x,y)
    isize = size(I);
    % calculate window boundaries
    left = max(1,x-floor(wsize/2));
    right = min(isize(2),x+floor(wsize/2));
    top = max(1,y-floor(wsize/2));
    bottom = min(isize(1),y+floor(wsize/2));
    % create window
    window = I(top:bottom,left:right);
end