function new_img = myHE(I)
I = uint8(255*I);
[m,n,ch] = size(I);

bin_locations = 0:256;
counts = zeros(size(bin_locations));
cdf = zeros(size(counts));  
for k = 1:ch
    for i = 1:m
        for j = 1:n
            index = I(i,j,k);
            if isnan(index)
                
            else
                counts(index + 1) = counts(index + 1)+ 1;
            end
        end
    end
    counts = counts/(m*n); % to make sum to 1 - like a PDF - see slides
    % now to find the CDF
    cdf(1) = counts(1) * 255;
    for i = 2:256
        cdf(i) = cdf(i-1) + (counts(i)*255); % multiply by 255 as the intensities of the new_img should be in 0-255
    end
    new_img(:,:,k) = cdf(double(I(:,:,k)) + 1);
end

end
