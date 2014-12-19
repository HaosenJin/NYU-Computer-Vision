function [row_disparity,flow]=final_graph_cut(matching_error_normalized,contrast_left,contrast_right,loopnum)

numPixel = size(matching_error_normalized,1);


disp(['building graph',num2str(loopnum)]);
N = numPixel^2*2;

A=sparse(N,N);

 

for i=1:88
    for j=1:88
        node_name_u=uv2A(1,0,i,j);
        node_name_v=uv2A(0,1,i,j);
        A(node_name_u,node_name_v)=matching_error_normalized(i,j);  % little black line
%         A(node_name_u,node_name_v)=24;
    end
end


% little gray line, from U to V
% mu=1e-4;
mu_right=little_gray_right(matching_error_normalized,contrast_right);
mu_left=little_gray_left(matching_error_normalized,contrast_left);

for i=1:87
    for j=1:88
        node_name_u=uv2A(1,0,i,j);
        node_name_v=uv2A(0,1,i+1,j);
        A(node_name_u,node_name_v)=mu_left(i);  
        A(node_name_v,node_name_u)=mu_left(i);  % little gray line

    end
end

% little gray line, from V to U
for i=1:88
    for j=1:87
        node_name_u=uv2A(1,0,i,j+1);
        node_name_v=uv2A(0,1,i,j);
        A(node_name_u,node_name_v)=mu_right(j);  % little gray line
        A(node_name_v,node_name_u)=mu_right(j);  

    end
end


% dash line, from U to U and from V to V
% horizontal dash
thresh_dash=8e9;
for i=1:87
    for j=2:88
        node_name_u1=uv2A(1,0,i,j);
        node_name_u2=uv2A(1,0,i+1,j);
        A(node_name_u1,node_name_u2)=thresh_dash;  
    end
end

for i=1:87
    for j=1:87        
        node_name_v1=uv2A(0,1,i,j);
        node_name_v2=uv2A(0,1,i+1,j);
        A(node_name_v1,node_name_v2)=thresh_dash;  % dash line

    end
end

% vertical dash
for i=1:87
    for j=88:-1:2
        node_name_u1=uv2A(1,0,i,j);
        node_name_u2=uv2A(1,0,i,j-1);

        A(node_name_u1,node_name_u2)=thresh_dash;

    end
end
for i=2:88
    for j=88:-1:2
        node_name_v1=uv2A(0,1,i,j);
        node_name_v2=uv2A(0,1,i,j-1);

        A(node_name_v1,node_name_v2)=thresh_dash;  % dash line


    end
end


T=sparse(N,2);

% % left image T(:,1)   source
% % rigt image T(:,2)    sink

thresh_gray=9e9;
for j=1:88
        node_name_vleft=uv2A(0,1,1,j);

        T(node_name_vleft,2)=thresh_gray;  
end


for i=1:88
        node_name_vup=uv2A(0,1,i,88);
        T(node_name_vup,2)=thresh_gray;  
end


for i=1:88
        node_name_udown=uv2A(1,0,i,1);
        T(node_name_udown,1)=thresh_gray;  
end

for j=1:88
        node_name_uright=uv2A(1,0,88,j);
        T(node_name_uright,1)=thresh_gray; 
end



[flow,labels] = maxflow(A,T);
disp('maximum flow label got!');

row_disparity=path2disparity(labels);

% % % change labels back to the cut path
% ind=find(labels==1);
% % initilize
% isU=zeros(sum(labels),1);
% isV=zeros(sum(labels),1);
% I=isU;
% J=isV;
% for i=1:length(ind)
%     [isU(i),isV(i),I(i),J(i)]=A2uv(ind(i));
% end

% test=[isU,I,J];
% 
sum(labels)
flow


% % % % % % show the cut image for each row
% % temp=zeros(88,88);
% % for i=1:88
% %     for j=1:88
% %         
% %         temp(i,j)=labels(uv2A(0,1,i,j));
% %     end
% % end
% % 
% % 
% % figure;
% % imshow(temp); colormap(gray);
% title(['mu = ',num2str(mu_right)],'fonts',18);





% % % labels = reshape(labels,N,N);
% % 
% % figure
% % imagesc(labels); title('labels');
% % 


% [row,col,val]=find(A);
% datatmp = [row, col, val];
% 
% save -ascii Amatrix_1.txt datatmp;

% % %data_save = spconvert(datatmp);
% % % fileID=fopen('Amatrix.txt','w');
% % % fprintf(fileID,'%d %d %d\n',datatmp);
% % % fclose(fileID);







