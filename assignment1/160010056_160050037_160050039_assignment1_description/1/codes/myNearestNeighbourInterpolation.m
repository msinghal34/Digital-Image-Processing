function [  ] = myNearestNeighbourInterpolation( I,map,nr,nc )
[m,n] = size(I);
zoom_r = ceil(nr/m);
zoom_c = ceil(nc/n);

% nr and nc are the new no of rows and columns 
% here nr = 3m-2, nc = 2n-1 
for i = 1:nr
    for j= 1:nc
        x = round(i/zoom_r);
        y = round(j/zoom_c);
         if (x==0)% again due to matlab indexing of arrays
            x = 1;
        end
        if(y == 0)
            y = 1;
        end
        FI(i,j) = I(x,y);
    end
end 
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized')
subplot(1,2,1);
imshow(I, map), colorbar;
title('Original')
subplot(1,2,2);
imshow(FI, map), colorbar;
title(['Nearest neighbour']);

end

