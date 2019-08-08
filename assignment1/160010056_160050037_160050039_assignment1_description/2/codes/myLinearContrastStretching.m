function outputImage = myLinearContrastStretching(inputImage)
    if isequal(size(size(inputImage)),[1,3])
        outputImage = zeros(size(inputImage));
        for i = 1:3
            inputChannel = inputImage(:,:,i);
            imageUpperLimit = max(max(inputImage(:,:,i)));
            imageLowerLimit = min(min(inputImage(:,:,i)));
            linearTransform = @(x) (255.0 * (x - imageLowerLimit) / (imageUpperLimit - imageLowerLimit));
            outputChannel = arrayfun(linearTransform, inputChannel);
            outputImage(:,:,i) = outputChannel;
        end
    else
        imageLowerLimit = (min(inputImage(:)));
        imageUpperLimit = (max(inputImage(:)));
        linearTransform = @(x) (255.0 * (x - imageLowerLimit) / (imageUpperLimit - imageLowerLimit));
        outputImage = arrayfun(linearTransform, inputImage);
    end
%       write output image to file
%     outputFilename = strcat('../images/','LCS_',imageName);
%     imwrite(outputImage,outputFilename);
end