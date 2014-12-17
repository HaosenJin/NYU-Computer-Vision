function blurred_I=GaussianBlur(sigma,I)
%% Convolve with a Gaussian Blur
x=-3*sigma:3*sigma;
[x,y] = meshgrid(x); % 2D grid of x's and y's (x,y)
u2=x.^2+y.^2;

C=1/sqrt(2*pi)/sigma;  
Gau_Blur=C*exp(-u2/2/sigma^2);
Gau_Blur=Gau_Blur/sum(Gau_Blur(:)); %%still need to normalize!!!!why??

% figure;
% mesh(x,y,Gau_Blur); d=title('Gaussian Blur'); set(d,'fontsize',18);
% 

blurred_I=conv2(I,Gau_Blur,'same');

% figure;
% imagesc(blurred_I);  a=title('Blurred Image');
% set(a,'fontsize',18);
% colormap('gray');
