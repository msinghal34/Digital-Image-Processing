function [  ] = myBilinearInterpolation( I,map,nr,nc )

% nr and nc are the new no of rows and columns 
% here nr = 3m-2, nc = 2n-1 
[m,n] = size(I);
zoom_r = ceil(nr/m);
zoom_c = ceil(nc/n);
for i = 1:nr
    for j = 1:nc
        x = round((i-1)/zoom_r);
        y = round((j-1)/zoom_c);
        x1 = ceil(x);
        x2 = floor(x);
        y1 = ceil(y);
        y2  = floor(y);
        y1 = y1 + 1;
        y2 = y2 + 1;
        x1 = x1 + 1;
        x2 = x2 + 1;
        I1 = I(x1,y1);
        I2 = I(x2,y1);
        I3 = I(x1,y2);
        I4 = I(x2,y2);
        I11 = I3*((y1 - y)) + I1*((y-y2));
        I12 = I4*((y1 - y)) + I2*((y-y2));
        IF = I12*((x1-x)) + I11*((x-x2));
        new_img(i,j) = IF;
    end
end
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized')
subplot(1,2,1);
imshow(I, map), colorbar;
title('Original')
subplot(1,2,2);
imshow(new_img, map), colorbar;
title(['Bilinear Interpolation ']);

end
