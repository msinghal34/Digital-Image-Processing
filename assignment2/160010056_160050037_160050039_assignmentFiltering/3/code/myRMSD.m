function r = myRMSD(I,J)
    diff = I - J;
    squareDiff = diff.^2;
    squareDiff = squareDiff(:);
    squareDiff(isnan(squareDiff)) = [];
    N = length(squareDiff);
    avrg = sum(squareDiff) / N;
    r = sqrt(avrg);
end