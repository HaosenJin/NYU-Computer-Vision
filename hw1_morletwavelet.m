function magnitude=hw1_morletwavelet(theta,sigma,I)
close all; 
% theta=0*pi;
% theta=pi/6;
% theta=pi/4;
% theta=pi/3;
% theta=pi/2;
% theta=2*pi/3;
% theta=3*pi/4;
% theta=5*pi/6;

% sigma=1;
% sigma=3;
% sigma=6;

i=sqrt(-1);
% x-y domain for physical space wavelet
x=-3*sigma:3*sigma;
% x =-15:15;
% xs = x/a; % dilation of wavelet %????
[x,y] = meshgrid(x); % 2D grid of x's and y's (x,y)
% rotate the coordinates
u_dot_etheta=x*cos(theta)+y*sin(theta);
u2=x.^2+y.^2;
%% psi(u)
ipsonal=4*sigma;


k1=exp(i*(2*pi/ipsonal).*u_dot_etheta);
k2=exp(-u2./(2*sigma^2));
c2=sum(sum(k1.*k2))/sum(sum(k2));
c1=sqrt(1/(   sum(sum( (k1-c2).*k2.*(conj((k1-c2).*k2))))));

psi=c1*(k1-c2).*k2;

real_Mlet=real(psi);
img_Mlet=imag(psi);
% col=size(psi,2);
% row=size(psi,1);


% figure;
% mesh(x,y,real(psi));  
% a=title(['Real part of psi(u): sigma=',num2str(sigma),', theta=',num2str(theta/pi*180),'']);
% set(a,'fontsize',18);
% saveas(gcf,['psi(u)--','sigma',num2str(sigma),'theta',num2str(theta/pi*180),'real'],'jpeg');


% figure;
% mesh(x,y,imag(psi)); b=title(['imaginary part of psi(u): sigma=',num2str(sigma),', theta=',num2str(theta/pi*180),'']);
% set(b,'fontsize',18); 
% saveas(gcf,['psi(u)--','sigma',num2str(sigma),'theta',num2str(theta/pi*180),'imag'],'jpeg');

% figure;
% mesh(x,y,abs(psi));  c=title(['magnitude of psi(u): sigma=',num2str(sigma),', theta=',num2str(theta),'']);
% set(c,'fontsize',18); 


%% convolve with psi(u)

conv_Mlet=conv2(I,real_Mlet,'same');
% figure;
% imshow(conv_Mlet);  a=title(['wavelet(real) convolved Image',' , theta=',num2str(theta)]);
% set(a,'fontsize',18);
% colormap('gray');
% saveas(gcf,['sigma',num2str(sigma),'theta',num2str(theta/pi*180),'real'],'jpeg');

conv_Mlet2=conv2(I,img_Mlet,'same');
% figure;
% imshow(conv_Mlet2);  a=title(['wavelet(img) convolved Image',', theta=',num2str(theta)]);
% set(a,'fontsize',18);
% colormap('gray');
% saveas(gcf,['sigma',num2str(sigma),'theta',num2str(theta/pi*180),'imag'],'jpeg');


%% 
magnitude=sqrt((conv_Mlet).^2+(conv_Mlet2).^2);












