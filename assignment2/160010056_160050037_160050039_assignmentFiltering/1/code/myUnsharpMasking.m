function [  ] = myUnsharpMasking(s, std_dev,I, filter_size )

% scaling factor = s 
% dimensions of the gaussian filter = filter_size
g_filter = fspecial('gaussian',filter_size,std_dev); % creates the gaussian mask of size 5
conv_img = imfilter(I,g_filter,'conv'); % performs a conolution of the image with the gaussian mask
DOG = I - conv_img; 
scaled_DOG = s*DOG; % now to scale by s
out = I + scaled_DOG;

% contrast stretch the images to range [0,1] with the function from the
% previous assignment.
out = LinearContrastStretching(out,[]);
I = LinearContrastStretching(I,[]);


figure(1);
subplot(1,2,1);
imshow(I);
title('Original')
subplot(1,2,2);
imshow(out)
title('After Unsharp Masking')
end

