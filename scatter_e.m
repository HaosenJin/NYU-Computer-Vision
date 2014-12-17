function scatter_error=scatter_e(left_vector,right_vector,img_left,d_l)
[h,w]=size(img_left);
m=floor(h/32)+ceil(rem(h,32)/32);
n=floor(w/32)+ceil(rem(w,32)/32);
xr_j_sca=zeros(m,n);

for i=1:m
    for j=1:n-1
        xr_j_sca(i,j)=round(16+32*(j-1)-d_l(16+32*(i-1),16+32*(j-1)));  % real y location in terms of full image
    end
end

scatter_error=zeros(m,n-1);
for i=1:m
    for j=1:n-1   %ignore the rightmost 4 columns of pixels
        for k=1:19
            I_l=left_vector{k};
            I_r=right_vector{k};
            if (xr_j_sca(i,j)>=1) && (xr_j_sca(i,j)<=size(img_left,2))
                I_left=I_l(i,j);
                I_right=I_r(i , ceil(xr_j_sca(i,j)/32)); % ceil(xr_j_down(i,j)/32) is the template index
                scatter_error(i,j)=scatter_error(i,j)+(I_left-I_right)^2;
            else scatter_error(i,j)=inf;
            end
                       
        end
    end
end

scatter_error=scatter_error/19;
end