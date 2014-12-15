function result=hw2_scatterNetwork(theta,sigma,I,isdownsample)
% theta=0*pi;
% theta=pi/6;
% theta=pi/3;
% theta=pi/2;
% theta=2*pi/3;
% theta=5*pi/6;

% sigma=1;
% sigma=3;
% sigma=6;



%% 1st layer
% convoluve with real and imag part of Wavelet
magnitude=hw1_morletwavelet(theta,sigma,I);
blurred_magni=GaussianBlur(6,magnitude);

% % downsample
% k=2;
k=5;%(32*32 template)
if isdownsample==1
    fstlyer_I = imresize(blurred_magni, 2^(-k));
else fstlyer_I=blurred_magni;
end
% figure;
% imagesc(fstlyer_I); title('1st layer');
% colormap('gray');

% saveas(gcf,['sigma',num2str(sigma),'theta',num2str(theta/pi*180)],'jpeg');

%% 2nd layer

 result=fstlyer_I;













