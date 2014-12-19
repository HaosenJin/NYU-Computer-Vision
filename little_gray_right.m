function   mu=little_gray_right(matching_error_normalized,contrast_right)


% thresh_from_black=0.3*max(matching_error_normalized(~isinf(matching_error_normalized)));

contrast_right=contrast_right/max(contrast_right);

% for k=1:87
%     little_gray(k)=log(1/contrast(k));
%         
% end
%     mu=little_gray/thresh_from_black*1;



mu=(1-contrast_right);

[nelements,xcenters] = hist(matching_error_normalized(:),100);
cumulative_hist=cumsum(nelements);

for i=1:length(cumulative_hist)
    energy=cumulative_hist(i)/(cumulative_hist(end));
    if energy>0.05
        lower_bound=xcenters(i);
    end
    if energy>0.8
        thresh_from_black=xcenters(i);
        break;
    end
    
    
end


mu=mu/max(mu)*thresh_from_black;
mu=max(mu,lower_bound)/200;   % little gray is between lower_bound and thresh_from_black










