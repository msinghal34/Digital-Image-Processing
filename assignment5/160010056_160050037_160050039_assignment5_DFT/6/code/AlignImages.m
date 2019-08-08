function [X,Y,cps] = AlignImages(I1,I2)
    % get FFTs of both images
    dft1 = fftshift(fft2(I1));
    dft2 = fftshift(fft2(I2));
    % compute cross power spectrum phase
    % adding small value to denominator to avoid getting NaNs
    cps = (dft1 .* conj(dft2)) ./ (abs(dft1 .* dft2) + 0.0000001);
    % find inverse FFT of of the cps
    i = ifft2(cps);
    s = size(i);
    m = max(i(:));
    for x=1:s(1)
        for y=1:s(2)
            if i(x,y) == m
                X = x-1;
                Y = y-1;
            end
        end
    end
    % get log magnitude of the cps
    cps = log(abs(dft1 .* conj(dft2))+1);
end