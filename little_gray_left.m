function   mu=little_gray_left(matching_error_normalized,contrast_left)


% thresh_from_black=0.3*max(matching_error_normalized(~isinf(matching_error_normalized)));

contrast_left=contrast_left/max(contrast_left);

% for k=1:87
%     little_gray(k)=log(1/contrast(k));
%         
% end
%     mu=little_gray/thresh_from_black*1;



mu=(1-contrast_left);

[nelements,xcenters] = hist(matching_error_normalized(:),100);
cumulative_hist=cumsum(nelements);

for i=1:length(cumulative_hist)
    energy=cumulative_hist(i)/(cumulative_hist(end));
    if energy>0.1
        lower_bound=xcenters(i);
    end
    if energy>0.7
        thresh_from_black=xcenters(i);
        break;
    end
    
    
end


mu=mu/max(mu)*thresh_from_black;
mu=max(mu,lower_bound)/200;   % little gray is between lower_bound and thresh_from_black









