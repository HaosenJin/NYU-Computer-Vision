function  row_disparity=path2disparity(labels)
% % map from left image to right image


cuthere=zeros(88,88);
disparity=zeros(1,88);
for i=1:88
    for j=1:88
        
        node_u=uv2A(1,0,i,j);
        node_v=uv2A(0,1,i,j);
        
        if labels(node_u)~=labels(node_v)
            cuthere(i,j)=1;
            disparity(i)=i-j;
%             break;   %???
        end

    end
    
    if sum(cuthere(i,:))==0
        disparity(i)=23444; % this means occlusion!!
    elseif sum(cuthere(i,:))>1
        print error!
    end

end


row_disparity=disparity;













