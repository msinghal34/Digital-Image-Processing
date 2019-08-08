function [ ] = myShrinkImageByFactorD( I,map,d)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

 
A = I(1:d:end,1:d:end);

iptsetpref('ImshowAxesVisible','on');
figure('units','normalized')
subplot(1,2,1);
imshow(I, map), colorbar;
title('Original')
subplot(1,2,2);
imshow(A, map), colorbar;
title(['Subsampled with d = ',num2str(d)]);



end

