function   node_name=uv2A(isU, isV, i,j)  
% % map U_label and V_label to node indices (in the A matrix)
if isU

node_name=(i)+2*88*(j-1);

end

if isV
    node_name=(i)+2*88*(j-1)+88;
end





% % 117 118 .....     v
% % 89 90 91 ...... 116   v
% % 1 2 3 4 5......88   u







