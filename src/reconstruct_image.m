function [ image ] = reconstruct_image(pyramid)
    levels = length(pyramid);
    
    image = pyramid{levels};
    
    for l = levels-1:-1:1
 
        image = upscale(image);
        image = image + pyramid{l};
    end
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

