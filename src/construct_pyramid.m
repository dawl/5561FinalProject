function [ pyramid ] = construct_pyramid(input_image, levels, hsize, sigma)

    result = cell(1,levels);

    h = fspecial('Gaussian',hsize,sigma);

    image = im2double(input_image);
    
    channels = size(image,3);
    for l = 1:levels-1
        blurred_image = image;
        for i = 1:channels
            blurred_image(:,:,i) = conv2(image(:,:,i),h,'same');
        end
        
        half = blurred_image(1:2:end,1:2:end,:);
        
        % Simulate upscaling so that we know 
        % what the incoming up-scaled will be
        % for calculating the perfect difference. 
        reupscale = upscale(half);

        difference = image-reupscale;
        result(l) = {difference};
        image = half;
        
    end
    result(levels) = {image};
    pyramid = result;
end

function [ reupscale ] = upscale( image )
    channels = size(image,3);
    image = im2double(image);
    reupscale = upsample(permute(upsample(permute(image,[2,1,3]),2,0),[2,1,3]),2,0);
     h = [0.5, 0, 0.5];
     image_horz = reupscale;
     for i = 1:channels
        image_horz(:,:,i) = conv2(reupscale(:,:,i),h,'same') + reupscale(:,:,i);
     end
     for i = 1:channels
        reupscale(:,:,i) = conv2(image_horz(:,:,i),h.','same') + image_horz(:,:,i);
     end
end



