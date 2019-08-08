function [sz_unir , FI] = myMeanShiftSegmentation(I,iterations,hr,hs)

% first we need to create a 5d mapping of the matrix so that we can do the
% mean shift segmentation on those vectors. Each vector is i,j,r,g,b. For
% that we need to do something similar to row order storage of the indexes.
% create a 2d matrix of 5 rows and each column represents a 5d vecor in
% space.

gf = fspecial('gaussian',7,1);
filtered_img = imfilter(I,gf,'conv'); % image after convolution
RI = filtered_img(1:2:end,1:2:end,:); % this is the resized image
[m, n, d] = size(RI); 

row_order_stored = zeros(5,m*n);
for i = 1:m
    for j = 1:n
        row_order_stored(:,((m-1)*i) + j) = [i;j;RI(i,j,1);RI(i,j,2);RI(i,j,3)];
    end
end

row_order_stored(1:2,:) = bsxfun(@rdivide,row_order_stored(1:2,:),hr);
row_order_stored(3:5,:) = bsxfun(@rdivide,row_order_stored(3:5,:),hs);
row_trans = row_order_stored';
updated_vectors = row_trans; % this is the initial value. This gets modified after ecah iteration

for i = 1:iterations
    [indices, distances] = knnsearch(row_trans,row_trans,'k',100);
    for v = 1:m*n
        w = exp((-1/2)*(distances(v,:).^2));% this is a vector of the weights fom 1 to n(here my n = 100)
        denom_w = sum(w); % this is the denominator of the derivative of log(f(x))
        % for the numerator take dot product of this weight vector with
        % each of the n(=100) closest vectors
        w = w';
        w = repmat(w,1,5);
        numerator_w = sum(w.*row_trans(indices(v,:),:));
        updated_vectors(v,:) = numerator_w/denom_w;
    end
    row_trans = updated_vectors; % sir mentioned in the class to update only after ech iteration 
                                 % and not after update of each vector
end

% now to get the output back in the 2d form for each colour
% so map back the row ordered indices into its corresponding 2d indices

for i = 1:m
    for j= 1:n
        segmented_img(i,j,1:3) = row_trans(((m-1)*i) + j,3:5);
    end
end

%converting into uint8
segmented_img = uint8(segmented_img);

% contrast stretching the image to [0,255]
for i=1:d
	    mx = max(max(segmented_img(:,:,i)));
		mn = min(min(segmented_img(:,:,i)));
	    FI(:,:,i) = (segmented_img(:,:,i)-mn)*(255/(mx- mn)); 
end

uni = unique(FI);
[sz_unir, ~] = size(uni);
end

