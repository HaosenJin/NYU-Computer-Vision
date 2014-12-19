function matching_error_normalized=normalize_matching_error(matching_error_black)

matching_error_normalized=zeros(size(matching_error_black));
for i=1:size(matching_error_black,1)
    error_row=matching_error_black(i,:);
    error_threshold=0.5*max(error_row(~isinf(error_row)));
    error_row(error_threshold)
    matching_error_normalized(i,:)=error_row/error_threshold*1;

end








