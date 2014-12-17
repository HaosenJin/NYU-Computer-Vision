function cutpath=final_graph_cut(matching_error_normalized)

numPixel = size(matching_error_normalized,1);


disp('building graph');
N = numPixel^2*2;

A=sparse(N,N);
U_label=zeros(88,88,2); % each node has two sub indices 00 01 ...
V_label=zeros(88,88,2);

for l=1:88
    for r=1:88
        
        U_label(l,r,1)=r-1;  % 1st subindex, left
        U_label(l,r,2)=l-1;   %2nd subindex, right
        
        V_label(l,r,1)=l-1;
        V_label(l,r,2)=r-1;
   
    end
end


 

for i=1:88
    for j=1:88
        node_name_u=uv2A(1,0,i,j);
        node_name_v=uv2A(0,1,i,j);
        A(node_name_u,node_name_v)=matching_error_normalized(i,j);
        
    end
end







    
for i=1:88
    A(i,i+88)=matching_error_normalized(i,i);
    
end



% construct graph
E = edges4connected(height,width);
V = abs(m(E(:,1))-m(E(:,2)))+eps;
A = sparse(E(:,1),E(:,2),V,N,N,4*N);

% terminal weights
% connect source to leftmost column.
% connect rightmost column to target.
T = sparse([(1:height)';(N-height+1:N)'],[ones(height,1);ones(height,1)*2],ones(2*height,1)*9e9);

% T = sparse([(1:height)';(N-87+1:N)'],[ones(87,1);ones(87,1)*2],ones(2*87,1)*9e9);
% T=sparse(N,2,0);

disp('calculating maximum flow');

[flow,labels] = maxflow(A,T);
labels = reshape(labels,height,width);

figure
imagesc(labels); title('labels');


%% 
test_image=zeros(size(m));
test_image(:,1:140)=10;

test_image(:,141:end)=250;

figure;
imagesc(test_image);


m=test_image;








