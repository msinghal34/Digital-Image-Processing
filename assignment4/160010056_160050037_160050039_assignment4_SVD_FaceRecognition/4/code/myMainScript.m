tic;
%% Q4 - Implementation of SVD with eigen decompostion
%  Square root of mean Square difference between the original matrix and USV' = 
A = rand(1000, 1500);

[U,S,V] = MySVD(A);

toc;