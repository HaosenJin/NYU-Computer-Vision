function   [isU, isV, i,j]=A2uv(node_name)  
% % map U_label and V_label to node indices (in the A matrix)


row_ind=floor(node_name/88)+1;
column_ind=rem(node_name,88);

if mod(row_ind,2) == 0
    isV=1; isU=0;
else isV=0; isU=1;

end

     i=row_ind;
    j=column_ind;



% % 117 118 .....     v
% % 89 90 91 ...... 116   v
% % 1 2 3 4 5......88   u







