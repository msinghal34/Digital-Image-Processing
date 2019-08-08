tic;
%% Image Alignment using DFT
% Following are the test images I and J respectively, for the first test. I
% is translated by (-30,70) to get J.
%%
load('../data/rectangles.mat');
[x,y,cps] = AlignImages(I,J);
%%
imagesc(I);
title('Image I');
%%
imagesc(J);
title('Image J');
%%
imagesc(cps);
title('Log fourier plot of Cross power spectrum');
%%
fprintf("The predicted translation to align J with I is (%0.f,%0.f), which is equivalent to (%f,%f).\n",x,y,x,y-300);
%%
% Following are the test images with zero mean gaussian noise(sigma=20) added, for the second test. Again, I
% is translated by (-30,70) to get J.
%%
I = I + 20*randn(300);
J = J + 20*randn(300);
[x,y,cps] = AlignImages(I,J);
%%
imagesc(I);
title('Noisy Image I');
%%
imagesc(J);
title('Noisy Image J');
%%
imagesc(cps);
title('Log fourier plot of Cross power spectrum');
%%
fprintf("For this test, the predicted translation to align J with I is (%0.f,%0.f), which is equivalent to (%f,%f).\n",x,y,x,y-300);
%%
% Clearly, for both the tests, the prediction is found to be very accurate.
%
% The bottleneck step in this algorithm is the computation of the cross
% power spectrum, which has complexity of $O(N^2)$, so roughly we can say
% the algorithm has time complexity of $O(N^2)$.
%
% In a naive implementation, one could try out all the possible
% translations, compare all the pixels and check if the images look
% aligned. In this case the time complexity would be $O(N^4)$, because
% there are $N^2$ possible translations and $N^2$ pixels to compare.
%
% So, compared to the naive algorithm , the DFT based algorithm performs
% much better.
%%
toc;