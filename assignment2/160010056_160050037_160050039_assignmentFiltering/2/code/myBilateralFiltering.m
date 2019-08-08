function [mykernel,noisyImage,outputImage] = myBilateralFiltering(inputImage, hs, hi)
    % constants
    WINDOW_SIZE = 15;
    pad = floor(WINDOW_SIZE/2);

    % create Spatial gaussian kernel
    mykernel = fspecial('gaussian', WINDOW_SIZE, hs);
    kernel = mykernel(:);

    % find intensity range in input
    inputSize = size(inputImage);
    minIntensity = min(inputImage(:));
    maxIntensity = max(inputImage(:));
    rangeIntensity = maxIntensity - minIntensity;
    
    % add gaussian noise to input
    noisyImage = inputImage + 0.05 * rangeIntensity * randn(inputSize);
    paddednoisyImage = padarray(noisyImage, [pad, pad], nan, 'both');
    
    % pre-allocate output matrix
    outputImage = zeros(inputSize);
    
    % run filtering over all pixels
    for y=1:inputSize(1)
        for x=1:inputSize(2)
            % get pixel intensity
            pixelIntensity = noisyImage(y, x);

            % Get window
            window = getWindow(paddednoisyImage, WINDOW_SIZE, x+pad , y+pad);
            % Calculations
            windowArray = window(:);
            windowArray = windowArray - pixelIntensity;
            windowArray = windowArray.^2;
            windowArray = windowArray./(hi^2);
            windowArray = exp(-windowArray);
            windowArray = windowArray.*kernel;
            denominator = nansum(windowArray);
            windowArray = window(:).*windowArray;
            numerator = nansum(windowArray);
            % Update output image
            outputImage(y,x) = numerator/denominator;
        end
    end
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