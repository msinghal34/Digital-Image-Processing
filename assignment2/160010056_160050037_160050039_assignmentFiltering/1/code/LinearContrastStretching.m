function [FI ] = LinearContrastStretching( I ,M )

 % m is the number of rows, n is the # of columns and ch is the # of channels
%FI =zeros(size(I));

[m , n, ch] = size(I);
for i=1:ch
	    mx = max(max(I(:,:,i)));
		mn = min(min(I(:,:,i)));
	    FI(:,:,i) = (I(:,:,i)-mn)*(1/(mx- mn)); 
end
end

