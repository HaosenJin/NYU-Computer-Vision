


for k=1:19
    I_l=left_vector{k};
    I_r=right_vector{k};
    for i=1:m
        for j=1:n   %ignore the rightmost 4 columns of pixels
                if (xr_j_down(i,j)>0) && (xr_j_down(i,j)<size(vector,2))
                    I_left=I_l(i,j);
                    I_right=I_r(i , xr_j_down(i,j));
                    scatter_error(i,j)=(I_left-I_right)^2;
                else scatter_error(i,j)=1000;
                end
                       
        end
    end
    scatter_error_sum=scatter_error_sum+scatter_error;
end