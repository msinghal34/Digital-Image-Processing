function [denoisedImage] = myBilateralFiltering(noisyImage, spatialSigma, intensitySigma, WINDOW_SIZE)
    % constants
    pad = floor(WINDOW_SIZE/2);

    % create Spatial gaussian kernel
    mykernel = fspecial('gaussian', WINDOW_SIZE, spatialSigma);
    kernel = mykernel(:);

    % find intensity range in input
    inputSize = size(noisyImage);
    
    paddednoisyImage = padarray(noisyImage, [pad, pad], nan, 'both');
    
    % pre-allocate output matrix
    denoisedImage = zeros(inputSize);
    
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
            windowArray = windowArray./(intensitySigma^2);
            windowArray = exp(-windowArray);
            windowArray = windowArray.*kernel;
            denominator = nansum(windowArray);
            windowArray = window(:).*windowArray;
            numerator = nansum(windowArray);
            % Update output image
            denoisedImage(y,x) = numerator/denominator;
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