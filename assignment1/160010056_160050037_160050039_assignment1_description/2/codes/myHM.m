function new_img = myHM( I,I_ref)
I = uint8(255*I);
I_ref = uint8(255*I_ref);
[m,n,ch] = size(I);
[m_ref,n_ref,ch_ref] = size(I_ref);

% find the cdf of reference image and original image

count_ref = zeros(1,256);
count = zeros(1,256);
for k = 1:ch_ref
for i = 1:m_ref
    for j = 1:n_ref
        ind = I_ref(i,j,k) + 1;
        if isnan(ind)
            
        else
            count_ref(ind) = count_ref(ind) + 1;
        end
    end
end
for i =1:m
    for j = 1:n
        index = I(i,j,k)+ 1;
        if isnan(index)
            
        else
            count(index) = count(index) + 1;
        end
    end
end

count_ref = count_ref/(m_ref*n_ref);
count = count/(m*n);
c_ref(1) = count_ref(1) * 255;
c(1) = count(1) * 255;
for i = 2:256
    c_ref(i) = c_ref(i-1) + (count_ref(i)*255);
    c(i) = c(i-1) + (count(i)*255);
end
% computing th quantile function
for i = 1:256
    for j = 1:256
        flag = 0;
        if(c_ref(j) >= i)
            q(i) = j;
            flag = 1;
            break;
        end    
    end
    if (flag == 0)
        q(i) = 255;
    end
end
temp2 =double(uint8(c(double(I(:,:,k)) + 1)));
temp1 = q(temp2);
new_img(:,:,k) = uint8(temp1);
end
end

