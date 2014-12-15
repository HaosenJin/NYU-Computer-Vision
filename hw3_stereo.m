clear 
clc
close all
%% preparing for data
filePath_l='/Users/Chenge/Documents/2014Fall/Computer Vison/cvhw3/imgs/disp0.pfm';
filePath_r='/Users/Chenge/Documents/2014Fall/Computer Vison/cvhw3/imgs/disp1.pfm';
d_l=read_pfm(filePath_l);
d_r=read_pfm(filePath_r);

ind_l_inf=zeros(size(d_l));
ind_l_inf(d_l==inf)=1;    % locations where d_l is inf

colorimg_left=imread('/Users/Chenge/Documents/2014Fall/Computer Vison/cvhw3/imgs/im0.png');
colorimg_right=imread('/Users/Chenge/Documents/2014Fall/Computer Vison/cvhw3/imgs/im1.png');
img_left=double(rgb2gray(colorimg_left));  %0~255
img_right=double(rgb2gray(colorimg_right));


% load scatter_vectors.mat; % 1*19 cell (60*89)
load scatter_vectors_full.mat; % 1*19 cell (1920*2820)


%% check for occlusion

xr_j=zeros(size(img_left));

for i=1:size(img_left,1)
    for j=1:size(img_left,2)
        xr_j(i,j)=round(j-d_l(i,j));  %xr_i==i
    end
end

occlusion_area=img_left;
difference=zeros(size(img_left));
occlusion_area(xr_j<=0)=0;
occlusion_area(xr_j>size(img_left,2))=0;   % occlusion_area contains inf locations


for i=1:size(img_left,1)
    for j=1:size(img_left,2)
        if (xr_j(i,j)>0) && (xr_j(i,j)<size(img_left,2))
            difference(i,j)=abs(d_l(i,j)-d_r(i,xr_j(i,j)));
        end
    end
end



occlusion_area(difference>=0.2)=0;  % use 0.2 as the threshold now
figure;
imagesc(occlusion_area);
colormap gray
title('occlusion area','fonts',18);

red_layer=colorimg_left(:,:,1);
red_layer(occlusion_area==0)=red_layer(occlusion_area==0)+100;
% red_layer(invalid_area==1)=red_layer(invalid_area==1)+100;

colorimg_left(:,:,1)=red_layer;
figure
imagesc(colorimg_left); title('occlusion area','fonts',18);

invalid_area=zeros(size(img_left));
% invalid_area(ind_l_inf==1)=1;
invalid_area(occlusion_area==0)=1;

%% take right as reference
% % % indr_inf=find(d_r==inf);
% % % 
% % % xl_j=zeros(size(img_left));
% % % 
% % % for i=1:size(img_left,1)
% % %     for j=1:size(img_left,2)
% % %         xl_j(i,j)=round(j+d_r(i,j));  %xr_i==i
% % %     end
% % % end
% % % 
% % % occlusion_area=img_right;
% % % difference=zeros(size(img_left));
% % % occlusion_area(xl_j<=0)=0;
% % % occlusion_area(xl_j>size(img_left,2))=0;
% % % 
% % % for i=1:size(img_left,1)
% % %     for j=1:size(img_left,2)
% % %         if (xl_j(i,j)>0) && (xl_j(i,j)<size(img_left,2))
% % %             difference(i,j)=abs(d_l(i,xl_j(i,j))-d_r(i,j));
% % %         end
% % %     end
% % % end
% % %       
% % % occlusion_area(difference>=1)=0;
% % % figure;
% % % imagesc(occlusion_area);
% % % colormap gray
% % % title('(right) occlusion area','fonts',18);
% % % 
% % % 
% % % red_layer=colorimg_right(:,:,1);
% % % red_layer(occlusion_area==0)=red_layer(occlusion_area==0)+100;
% % % colorimg_right(:,:,1)=red_layer;
% % % figure
% % % imagesc(colorimg_right); title('(right) occlusion area','fonts',18);


%% two kinds of errors
pixel_error=pixel_e(img_left,img_right,xr_j);

%% % % 2nd error % % % scatter error
% scatter vectors
% isdownsample=0;
% left_vector_full=loop(img_left,isdownsample);
% right_vector_full=loop(img_right,isdownsample);
% save('scatter_vectors_full.mat','left_vector_full','right_vector_full');


load scatter_vectors.mat;


% % % % % downsample disparity map first
% % % % % % % % d_l_down=imresize(d_l, 2^(-5)); %%downsampled the disparity map, but its content is still related with the full image!!
% % % % % % % % xr_j_down=zeros(size(d_l_down));
% % % % % % % % 
% % % % % % % % for i=1:m
% % % % % % % %     for j=1:n
% % % % % % % %         xr_j_down(i,j)=round(16+32*(j-1)-d_l_down(i,j));  % real y location in terms of full image
% % % % % % % %         xr_j_down(i,j)=round(xr_j_down(i,j)./32);  % change the disparity value inligned with the smaller image scale
% % % % % % % %     end
% % % % % % % % end
% % % % % % % % 
% % % % % % % % scatter_error=zeros(m,n-1);
% % % % % % % % for i=1:m
% % % % % % % %     for j=1:n-1   %ignore the rightmost 4 columns of pixels
% % % % % % % %         for k=1:19
% % % % % % % %             I_l=left_vector{k};
% % % % % % % %             I_r=right_vector{k};
% % % % % % % %             if (xr_j_down(i,j)>=1) && (xr_j_down(i,j)<=n)
% % % % % % % %                 I_left=I_l(i,j);
% % % % % % % %                 I_right=I_r(i , xr_j_down(i,j));
% % % % % % % %                 scatter_error(i,j)=scatter_error(i,j)+(I_left-I_right)^2;
% % % % % % % %             else scatter_error(i,j)=inf;
% % % % % % % %             end
% % % % % % % %                        
% % % % % % % %         end
% % % % % % % %     end
% % % % % % % % end


scatter_error=scatter_e(left_vector,right_vector,img_left,d_l);

  % the second error

%% draw the two errors' histograms
figure;
p_e=sort(pixel_error(:));
ind1=find(p_e<1);
hist(p_e(p_e<10^-4),100);
title('pixel error histogram','fonts',18);




figure;
s_e=scatter_error(:);
hist(s_e(s_e<3*10^-3),100);
title('scatter error histogram','fonts',18);


ind2=find(s_e<1);
title('scatter error histogram','fonts',18);
hist(s_e(ind2),100);


% figure;
% hist(p_e(p_e<0.005));
%  hold on;
%  hist(s_e(s_e<0.005));
%  
% h = findobj(gca,'Type','patch');
% display(h)
%  
% set(h(1),'FaceColor','r','EdgeColor','k');
% set(h(2),'FaceColor','g','EdgeColor','k');

h1=hist(p_e(p_e<10^-4),100);
h2=hist(s_e(s_e<10^-4),100);
figure(111)
bin=linspace(0,10^-4,100);
bar(bin,[h1;h2]')
title('two error histograms','fonts',18);
legend('pixel error','scatter error');


%%
% % % % get the mean and sigma of the errors
pixel_error_noma=pixel_error(pixel_error<0.005);
psum=sum(sum(pixel_error_noma));
pixel_error_noma=pixel_error_noma/psum;

p_e_mean=mean(pixel_error_noma);
p_e_std=sqrt(var(pixel_error_noma));

p_e=pixel_error_noma(:);
figure;
hist(p_e(p_e<0.005),100);
title('pixel error histogram(after nomalization)','fonts',18);
legend(['pixel error mean',num2str(p_e_mean), 'variance',num2str(s_e_std)]);


% %%%
scatter_error_noma=scatter_error(scatter_error<6*10^(-4));
ssum=sum(sum(scatter_error_noma));
scatter_error_noma=scatter_error_noma/ssum;
scatter_error_noma=scatter_error_noma(:);
scatter_error_noma(scatter_error_noma==inf)=[];

s_e_mean=mean(scatter_error_noma);
s_e_std=sqrt(var(scatter_error_noma));


figure;
hist(s_e(s_e<0.005),100);
title('scatter error histogram(after nomalization)','fonts',18);
xlabel(['scatter error mean',num2str(s_e_mean), 'variance',num2str(s_e_std)]);



%% using fake disparity
random_1=round(rand(size(img_left)));
random_1(random_1==0)=-2; random_1(random_1==1)=2;

% % % % fake pixel error
fake_disparity=xr_j+random_1;
fakepixel_error=pixel_e(img_left,img_right,fake_disparity);
figure;
fp_e=fakepixel_error(:);
ind1=find(fp_e<10^-3);
hist(fp_e(fp_e<10^-3),100);
title(['pixel error histogram, totally ',num2str(length(ind1))],'fonts',18);

% % % fake scatter error
fakescatter_error=scatter_e(left_vector,right_vector,img_left,d_l+random_1);
figure;
fakes_e=fakescatter_error(:);
ind2=find(fakes_e<10^-3);
hist(fakes_e(fakes_e<10^-3),100);
title(['scatter error histogram, totally ',num2str(length(ind2))],'fonts',18);


% % % get the mean and std for the fake disparity
scatter_error_noma=fakescatter_error(fakescatter_error<6*10^(-4));
ssum=sum(sum(scatter_error_noma));
scatter_error_noma=scatter_error_noma/ssum;
scatter_error_noma=scatter_error_noma(:);
scatter_error_noma(scatter_error_noma==inf)=[];

fake_s_e_mean=mean(scatter_error_noma);
fake_s_e_std=sqrt(var(scatter_error_noma));




%%   hw 3b 
%% mataching error cost=60*88*23
% load scatter_vectors_full.mat;
cost=cell(60,88);
range_disp=cell(60,88);  % the j locations the rigth image
[cost,range_disp]=hw3b_graph_cut(img_left,d_l,left_vector_full,right_vector_full);

disparity_map=ones(60,88)*10000;
for i=1:60
    for j=1:88
        cost_here=cost{i,j};
        disp_here=range_disp{i,j};
        [~,ind]=sort(cost_here,'ascend');
        disparity_map(i,j)=disp_here(ind(1));
  
    end
end

figure;
imagesc(disparity_map);

