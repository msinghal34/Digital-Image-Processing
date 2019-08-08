% main fuction
function outputImage = myCLAHE(inputImage,winsize,thr)
    % make function handle
    fun = @(x) pixelCLAHE(x,thr);
    padsize = floor(winsize/2);
    if isequal(size(size(inputImage)),[1,3])    % means it is an RGB image
        % construct empty output image
        outputImage = zeros(size(inputImage));
        for i = 1:3     %iterate over the channels
            inputChannel = inputImage(:,:,i);
            % pad the image with nan, which produces same effect as cropping the window
            inputChannel = padarray(inputChannel,[padsize padsize],nan);
            % apply CLAHE on a per-pixel basis to the input channel
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
%     outputFilename = strcat('../images/','CLAHE_',imageName);
%     imwrite(outputImage,outputFilename);
end

% helper function to perform CLAHE on a per-pixel basis
function outputPixel = pixelCLAHE(win,THRESHOLD)
    % get value of center pixel
    center_xy = floor((size(win)+1)/2);
    pix = win(center_xy(1),center_xy(2));
    if isnan(pix)
        outputPixel = nan;
    else
        % compute histogram of window
        [counts,edges] = histcounts(win(:),256);
        %%%%%% clip histogram and re-distribute mass %%%%%%%
        max_allowed = THRESHOLD * max(counts);
        clipped_counts = min(counts,max_allowed);
        difference = counts - clipped_counts;
        aggr_diff = sum(difference);
        liftup = aggr_diff / 256;
        clipped_counts = clipped_counts + liftup;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % compute cdf and apply to center pixel
        cdf = cumsum(clipped_counts) / sum(clipped_counts);
        bin_index = discretize(pix,edges);
        outputPixel = 255.0 * cdf(bin_index);
    end
end