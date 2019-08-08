function [I, Ix, Iy, eig1, eig2, corner] = myHarrisCornerDetector(inputImage, smoothsigma, weightsigma, k)
	
	% constants
	window_size = 5;

	% Rescaled Image
	I  = inputImage.imageOrig;
	I  = I./255;

	% size
	sizex = size(I,1);
	sizey = size(I,2);
	
	% Sobel operators
	sobelx = [-1 0 1; -2 0 2; -1 0 1];
	sobely = [1 2 1; 0 0 0; -1 -2 -1];
	
	% Image Derivatives
	Ix = filter2(sobelx, I);
	Iy = filter2(sobely, I);
	
	% Masks
	smooth = fspecial('gaussian', window_size, smoothsigma);
	weights = fspecial('gaussian', window_size, weightsigma);
	
	% smooth images
	sIx = filter2(smooth, Ix);
	sIy = filter2(smooth, Iy);
	sIx2 = sIx.*sIx;
	sIxIy = sIx.*sIy;
	sIy2 = sIy.*sIy;
	
	% Padded smooth Images
	psIx2 = padarray(sIx2, [2, 2], 0, 'both');
	psIy2 = padarray(sIy2, [2, 2], 0, 'both');
	psIxIy = padarray(sIxIy, [2, 2], 0, 'both');
	
	% eigen values matrix
	eig1 = zeros(size(I));
	eig2 = zeros(size(I));

	% Cornerness measure
	corner = zeros(size(I));
	
	% Implementation
	for i = 1:sizex
        for j = 1:sizey
            % Structure Tensor
	        M = zeros(2,2);
	        
	        M(1,1) = sum(sum(weights.*psIx2(i:i+4, j:j+4)));
	        M(1,2) = sum(sum(weights.*psIxIy(i:i+4, j:j+4)));
	        M(2,1) = sum(sum(weights.*psIxIy(i:i+4, j:j+4)));
	        M(2,2) = sum(sum(weights.*psIy2(i:i+4, j:j+4)));
	        
	        determinant = det(M);
	        
	        corner(i,j) = determinant - k*trace(M)*trace(M);
	        
	        eigen = eig(M);
	        eig1(i,j) = max(eigen);
	        eig2(i,j) = min(eigen);
        end
    end
    corner = corner > 0.01;
end