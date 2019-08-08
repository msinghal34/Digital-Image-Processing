function [I,J,gmask] = GLowPassFilter(im,D)
    imsize = size(im);
    u = -imsize(1)/2:(imsize(1)/2-1);
    v = -imsize(2)/2:(imsize(2)/2-1);
    [V,U]=meshgrid(v,u); 
    W = V.^2 + U.^2;
    gmask = exp(-W/(2 * D^2));
    dft = fftshift(fft2(im));
    filtered_dft = dft .* gmask;
    I = ifft2(fftshift(filtered_dft));
    J = log(abs(filtered_dft)+1);
end