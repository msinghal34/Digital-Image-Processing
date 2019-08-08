
function [ Zfi ] = notch( Zf,R )

[m,n] = size(Zf);

for i = 1:m
    for j = 1:n
        if(((((i - 139)^2) + ((j - 134)^2)) < R^2) || ((((i - 119)^2) + ((j - 124)^2)) < R^2) )
            Zf(i,j) = 0;
        end
    end
end
Zfi = ifft2(Zf);
Zfi = (Zfi - min(min(Zfi)))/(max(max(Zfi)) - min(min(Zfi)));
end

