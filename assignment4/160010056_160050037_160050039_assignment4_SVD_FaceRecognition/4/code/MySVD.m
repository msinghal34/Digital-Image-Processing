function [U S V ] = MySVD( A)

X = mtimes(A,A');
Y = mtimes(A',A);

[Qleft lamleft] = eig(X);
[Qright lamright] = eig(Y);

l = size(Qleft);
r = size(Qright);
[m n] = size(A);

% reverse the cols as the cols are getting reversed while using eig - as
% eig orders in ascending order of eigenvalues but svd() does it in
% descending order of singular values

for i = 1:l(2)
    U(:,i) = Qleft(:,l(2)+ 1 - i);
end
for i = 1:r(2)
    V(:,i) = Qright(:,r(2)+ 1 - i);
end


% to replace eigenvalues < 0 with 0
lamleft(lamleft < -0) = 0; % don't take absolute again as this removes even all -0
lamright(lamright < -0) = 0;

lam = zeros(size(A));

% as eig orders eigenvalues in ascending order we have to reverse the
% diagonal to get all the non zero diagonal entries

for i = 1:min(m,n)
    lam(i,i) = lamleft(m+1 - i,m+1 - i);
end
S = sqrt(lam);
% now to fix the -ve sign in the matrix U
M1 = U*S;
M2 = A*V;
for i = 1:n
    a = M2(:,i) > 0;
    b = M1(:,i) < 0;
    if(isequal(a,b)) % JUst check if the vecors have opposite sign. Not with magnitude as rounded values are shown when dislplaying. Dont get misled
        U(:,i) = -U(:,i);
    end
end
U = -U;
V = -V;
disp(norm(A - U*S*V'));
