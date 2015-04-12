function [ image_feature_array ] = compute_features( input_image )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
rgb_channels = 3;
pixel_count = numel(input_image(:,:,1));

rgb_vector = reshape(input_image,pixel_count,rgb_channels);

luma_vector =  0.2126 *rgb_vector(:,1) + 0.7152 *rgb_vector(:,2) + 0.0722 *rgb_vector(:,3); 

image_feature_array = [rgb_vector, luma_vector];

end

