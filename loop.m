%% read in the image
% I=imread('/Users/HeyChenge/Documents/2014fall/computer vision/butterfly.jpg');
% I=imread('/Users/HeyChenge/Documents/2014fall/computer vision/noise-circle.jpg');
% I_left=imread('/Users/Chenge/Desktop/im0.png');
% I_right=imread('/Users/Chenge/Desktop/im1.png');


function final_vector=loop(I,isdownsample)
if size(I,3)==3
    I=rgb2gray(I);
end
%(not downsample)
% % min_dim=min(size(I,1),size(I,2));
% % n = floor(log(min_dim)/log(2));
% % I = imresize(I,[2^n 2^n]);

I=double(I)/255;

%% 0th layer
blurred_I=GaussianBlur(6,I);

% % downsample

k=5;%(32*32 template)
if isdownsample==1
    zerolyer_I = imresize(blurred_I, 2^(-k));
else zerolyer_I=blurred_I;
end
% figure;
% imagesc(zerolyer_I); title('zero layer');
% colormap('gray');
% saveas(gcf,'zero layer','jpeg');

%% other layers
result=cell(1,18); 
result{1,1}=hw2_scatterNetwork(0,1,I,isdownsample);
result{2}=hw2_scatterNetwork(pi/6,1,I,isdownsample); 
result{3}= hw2_scatterNetwork(pi/3,1,I,isdownsample);
result{4}=hw2_scatterNetwork(pi/2,1,I,isdownsample);
result{5}= hw2_scatterNetwork(2*pi/3,1,I,isdownsample);
result{6}= hw2_scatterNetwork(5*pi/6,1,I,isdownsample);

result{7}= hw2_scatterNetwork(0,3,I,isdownsample);
 result{8}=hw2_scatterNetwork(pi/6,3,I,isdownsample); 
 result{9}=hw2_scatterNetwork(pi/3,3,I,isdownsample);
 result{10}=hw2_scatterNetwork(pi/2,3,I,isdownsample);
 result{11}=hw2_scatterNetwork(2*pi/3,3,I,isdownsample);
 result{12}=hw2_scatterNetwork(5*pi/6,3,I,isdownsample);
 
 result{13}=hw2_scatterNetwork(0,6,I,isdownsample);
 result{14}=hw2_scatterNetwork(pi/6,6,I,isdownsample); 
 result{15}=hw2_scatterNetwork(pi/3,6,I,isdownsample);
 result{16}=hw2_scatterNetwork(pi/2,6,I,isdownsample);
 result{17}=hw2_scatterNetwork(2*pi/3,6,I,isdownsample);
 result{18}=hw2_scatterNetwork(5*pi/6,6,I,isdownsample);
 
 final_vector=cell(1,19);
 final_vector{1,1}=zerolyer_I;
 for i=2:19
     final_vector{1,i}=result{1,i-1};
 end
 
 
 close all;
 for i=1:19
     figure
     imagesc(final_vector{1,i});
     colormap('gray');
 end
 
 
  
 
 
 
 
 
 
 