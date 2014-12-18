function   [isU, isV, i,j]=A2uv(node_name)  
% % map U_label and V_label to node indices (in the A matrix)


row_ind=floor(node_name/88); % 0 1 2 3     floor(1/2*  ): 0 0 1 1 ...
column_ind=rem(node_name,88);%  

if rem(row_ind,2) == 0  && column_ind~=0    % 0 1 0 1 0
    isV=0; isU=1;

elseif rem(row_ind,2) == 1 && column_ind~=0

    isV=1; isU=0;
    
elseif rem(row_ind,2) == 1 && column_ind==0
    isV=0; isU=1;
elseif rem(row_ind,2) == 0 && column_ind==0  
    isV=1; isU=0;
    
    
end

if column_ind==0    
    j=88; i=floor(row_ind/2);

else
    j=column_ind; i=floor(row_ind/2)+1;

end



% % 117 118 .....     v
% % 89 90 91 ...... 116   v
% % 1 2 3 4 5......88   u







