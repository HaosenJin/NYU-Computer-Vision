function [pixel_error]=pixel_e(img_left,img_right,xr_j)

[h,w]=size(img_left);
m=floor(h/32)+ceil(rem(h,32)/32);
n=floor(w/32)+ceil(rem(w,32)/32);

% % % % pixel error
pixel_error=zeros(m,n-1);
for i=1:m
    for j=1:n-1   %ignore the rightmost 4 columns of pixels, treat as error=inf
        for k=-15:16
            for l= -15:16
                if (xr_j(16+32*(i-1)+k,16+32*(j-1)+l)>=1) && (xr_j(16+32*(i-1)+k,16+32*(j-1)+l)<=size(img_left,2))
                I_l=img_left(16+32*(i-1)+k,16+32*(j-1)+l)/255;
                I_r=img_right(16+32*(i-1)+k,xr_j(16+32*(i-1)+k,16+32*(j-1)+l))/255;
                pixel_error(i,j)=pixel_error(i,j)+(I_l-I_r)^2;
                else pixel_error(i,j)=inf;
                end
            end           
        end
    end
end


pixel_error=pixel_error/32/32;  % the first error



end