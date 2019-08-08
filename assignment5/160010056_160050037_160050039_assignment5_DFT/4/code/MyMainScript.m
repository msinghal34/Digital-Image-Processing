tic;
%% Ideal Low Pass Filter
% Pure low pass filter used with value of parameter D as 40 and 80.
% Following are filter masks used in this frequency domain filtering:
%%
input = im2double(imread('../data/barbara256.png'));
input_dft = log(abs(fftshift(fft2(input)))+1);
[output1,output_dft1,mask1] = IdealLowPassFilter(input,40);
[output2,output_dft2,mask2] = IdealLowPassFilter(input,80);
%%
imagesc(mask1);
colormap gray;
title('Filter mask with D=40');
%%
imagesc(mask2);
title('Filter mask with D=80');
%%
% Following are the input and output images 
%%
imagesc(input);
title('Input image');
%%
imagesc(output1);
title('Output image with D=40');
%%
imagesc(output2);
title('Output image with D=80');
%%
% Following are the log fourier plots of the input and output images:
%%
imagesc(input_dft);
colormap jet;
title('DFT of Input image');
%%
imagesc(output_dft1);
title('DFT of Output image with D=40');
%%
imagesc(output_dft2);
title('DFT of Output image with D=80');
%%
% The image filtered with $D=40$ shows very prominent ringing artifacts.
% In the second image, though not as blatant as the first one, there are
% still slightly visible artifacts.
%%
%% Gaussian Low Pass Filter
% Gaussia low pass filter used with value of standard deviation as 40 and 80.
% Following are filter masks used in this frequency domain filtering:
%%
[output1,output_dft1,mask1] = GLowPassFilter(input,40);
[output2,output_dft2,mask2] = GLowPassFilter(input,80);
%%
imagesc(mask1);
colormap gray;
title('Filter mask with sigma=40');
%%
imagesc(mask2);
title('Filter mask with sigma=80');
%%
% Following are the input and output images 
%%
imagesc(input);
title('Input image');
%%
imagesc(output1);
title('Output image with sigma=40');
%%
imagesc(output2);
title('Output image with sigma=80');
%%
% Following are the log fourier plots of the input and output images:
%%
imagesc(input_dft);
colormap jet;
title('DFT of Input image');
%%
imagesc(output_dft1);
title('DFT of Output image with sigma=40');
%%
imagesc(output_dft2);
title('DFT of Output image with sigma=80');
%%
% The first output image is very cleanly smoothened, with no visible
% artifacting, unlike the ones obtained with the ideal filter. Second
% output image is visually almost identical to the input image.
%%
toc;