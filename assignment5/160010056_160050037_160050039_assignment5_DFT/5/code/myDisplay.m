function myDisplay(image, Name)
	figure('Name', Name);
	imagesc(mat2gray(image));
	title(Name); 
	colormap gray;
	colorbar;
end