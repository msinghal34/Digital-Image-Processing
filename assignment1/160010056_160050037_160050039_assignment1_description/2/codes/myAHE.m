% main fuction
function outputImage = myAHE(inputImage,winsize)
    % make function handle
    fun = @(x) pixelAHE(x,winsize);
    padsize = floor(winsize/2);
    if isequal(size(size(inputImage)),[1,3])    % means it is an RGB image
        % construct empty output image
        outputImage = zeros(size(inputImage));
        for i = 1:3     %iterate over the channels
            inputChannel = inputImage(:,:,i);
            % pad the image with nan, which produces same effect as cropping the window
            inputChannel = padarray(inputChannel,[padsize padsize],nan);
            % apply AHE on a per-pixel basis to the input channel
            outputChannel = nlfilter(inputChannel,[winsize winsize],fun);
            % remove the padding 
            outputChannel = outputChannel(padsize+1:end-padsize,padsize+1:end-padsize);
            % include channel in output image
            outputImage(:,:,i) = outputChannel;
        end
    else    % same stuff as above but for grayscale image
        inputImage= padarray(inputImage,[padsize padsize],nan);
        outputImage = nlfilter(inputImage,[winsize winsize],fun);
        outputImage = outputImage(padsize+1:end-padsize,padsize+1:end-padsize);
    end
%       write output image to file
%     outputFilename = strcat('../images/','AHE_',imageName);
%     imwrite(outputImage,outputFilename);
end

% helper function to perform AHE on a per-pixel basis
function outputPixel = pixelAHE(win,winsize)
	ind = sub2ind([winsize winsize],floor((winsize+1)/2),floor((winsize+1)/2));
    % get value of center pixel
    pix = win(ind);
    if isnan(pix)
        outputPixel = nan;
    else
        % compute histogram of window
        [counts,edges] = histcounts(win(:),256);
        % compute cdf and apply to center pixel
        cdf = cumsum(counts) / sum(counts);
        bin_index = discretize(pix,edges);
        outputPixel = 255.0 * cdf(bin_index);
    end
end