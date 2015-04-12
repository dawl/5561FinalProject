function display_gaussian_pyramid( gaussian_pyramid )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%% Display 
levels = length(gaussian_pyramid);
figure;
disp_count = levels+1;
for i=1:levels
   
    subplot(1, disp_count, 1+i);
    if i == levels
        imshow(gaussian_pyramid{i});
        title(strcat('level ',int2str(i)))

    else
        imshow(gaussian_pyramid{i},[-1,1]);
        title(strcat(strcat('level  ',int2str(i)),'[-1,1]'));

    end
end

end

