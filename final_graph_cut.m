% function cutpath=final_graph_cut(matching_error_normalized)

numPixel = size(matching_error_normalized,1);


disp('building graph');
N = numPixel^2*2;

A=sparse(N,N);

 

for i=1:88
    for j=1:88
        node_name_u=uv2A(1,0,i,j);
        node_name_v=uv2A(0,1,i,j);
        A(node_name_u,node_name_v)=matching_error_normalized(i,j);  % little black line
        
    end
end


% little gray line, from U to V
mu=13;

for i=1:87
    for j=1:88
        node_name_u=uv2A(1,0,i,j);
        node_name_v=uv2A(0,1,i+1,j);
        A(node_name_u,node_name_v)=mu;  
        A(node_name_v,node_name_u)=mu;  % little gray line

    end
end

% little gray line, from V to U
for i=1:88
    for j=1:87
        node_name_u=uv2A(1,0,i,j+1);
        node_name_v=uv2A(0,1,i,j);
        A(node_name_u,node_name_v)=mu;  % little gray line
        A(node_name_v,node_name_u)=mu;  

    end
end


% dash line, from U to U and from V to V
% horizontal dash
for i=1:87
    for j=2:88
        node_name_u1=uv2A(1,0,i,j);
        node_name_u2=uv2A(1,0,i+1,j);
        A(node_name_u1,node_name_u2)=35;  

    end
end

for i=1:87
    for j=1:87        
        node_name_v1=uv2A(0,1,i,j);
        node_name_v2=uv2A(0,1,i+1,j);
        A(node_name_v1,node_name_v2)=35;  % dash line

    end
end

% vertical dash
for i=1:87
    for j=88:-1:2
        node_name_u1=uv2A(1,0,i,j);
        node_name_u2=uv2A(1,0,i,j-1);

        A(node_name_u1,node_name_u2)=35;  

    end
end
for i=2:88
    for j=88:-1:2
        node_name_v1=uv2A(0,1,i,j);
        node_name_v2=uv2A(0,1,i,j-1);

        A(node_name_v1,node_name_v2)=35;  % dash line


    end
end


T=sparse(N,2);

% % left image T(:,1)
% % rigt image T(:,2)

thresh_gray=100;
for j=1:88
        node_name_vleft=uv2A(0,1,1,j);

        T(node_name_vleft,2)=thresh_gray;  
end


for i=1:88
        node_name_vup=uv2A(0,1,i,88);
        T(node_name_vup,2)=thresh_gray;  
end


for j=1:88
        node_name_udown=uv2A(1,0,1,j);
        T(node_name_udown,1)=thresh_gray;  
end

for i=1:88
        node_name_uright=uv2A(1,0,i,88);
        T(node_name_uright,1)=thresh_gray; 
end


disp('calculating maximum flow');

[flow,labels] = maxflow(A,T);
% labels = reshape(A,N,N);
% 
% figure
% imagesc(labels); title('labels');
% 
% 






