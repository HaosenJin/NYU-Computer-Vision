function [cost,range_disp]=hw3b_graph_cut(img_left,d_l,left_vector_full,right_vector_full)

% % consider each row
range_cost=zeros(23,1);
range_disparities=zeros(23,1);

for i=16:32:size(img_left,1)
for j=16:32:size(img_left,2) 

    for range=-55:5:55
        if d_l(i,j)~=inf
            true_disp=d_l(i,j);
        else 
            disp_temp=d_l(i-15:i+16,j-15:j+16);
            if length(find(disp_temp~=inf))>=1
                true_disp=round(mean(disp_temp(disp_temp~=inf)));  % if inf, use neighbour value
            else true_disp=inf;
            end 
        end
        d_lnew=true_disp+range;
        center_left=[i,j];
        
%         if center_left==[336 1008]
%             a=100;
%         end
        
        center_right=[i,round(j-d_lnew)];
        
        % define the matching cost as the scatter_template error between 
%left_scatter_template centered at (i,j) and right_scatter_template centered at (i,round(j-d_lnew))
        
        range_cost((range+60)/5,1)=sca_temp_error_full(left_vector_full,right_vector_full,center_left,center_right);
        range_disparities((range+60)/5,1)=d_lnew;
        
    end
    cost{(i+16)/32,(j+16)/32}=range_cost;
    range_disp{(i+16)/32,(j+16)/32}= range_disparities;
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
