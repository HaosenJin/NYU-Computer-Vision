function cost=get_matching_cost(img_left,left_vector_full,right_vector_full)

cost=cell(60,1);
% % consider each row
cost_each_Row=zeros(88,88);

for i=16:32:size(img_left,1)
for j=16:32:size(img_left,2) 

% %         center_left=[i,j];
% %         
% %         center_right=[i,j];
% %         
% %         % define the matching cost as the scatter_template error between 
% % %left_scatter_template centered at (i,j) and right_scatter_template centered at (i,round(j-d_lnew))
% %         
% %         cost((i+16)/32,(j+16)/32)=sca_temp_error_full(left_vector_full,right_vector_full,center_left,center_right);
center_left=[i,j];    
for k=16:32:size(img_left,2)
center_right=[i,k];
        
        % define the matching cost as the scatter_template error between 
%left_scatter_template centered at (i,j) and right_scatter_template centered at (i,round(j-d_lnew))
        
        cost_each_Row((j+16)/32,(k+16)/32)=sca_temp_error_full(left_vector_full,right_vector_full,center_left,center_right);
        
    end
    cost{(i+16)/32,1}=cost_each_Row;

    
    
end
end




function sca_error_cost=sca_temp_error_full(left_vector_full,right_vector_full,center_left,center_right)
error=0;

% check right location validality 
if (center_right(2)<=15) || (center_right(2)>=2805)   %if the rigth template center is out of scope, inf
    sca_error_cost=inf;
else 
    for l=1:19
        lth_vector_left=left_vector_full{l};
        lth_vector_right=right_vector_full{l};

        left=lth_vector_left(center_left(1)-15:center_left(1)+16,center_left(2)-15:center_left(2)+16);
        right=lth_vector_right(center_right(1)-15:center_right(1)+16,center_right(2)-15:center_right(2)+16);
        
        error_templ=(left-right).^2;
        error=error+sum(sum(error_templ))/32/32;
    end
    sca_error_cost=error/19;
end

end





end
