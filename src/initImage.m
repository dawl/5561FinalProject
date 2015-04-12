function [proc_image] = initImage( image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
im_channels = size(image,3);
rgb_channels = 3;
% If the image is grayscale, copy the data to the RGB channels
if im_channels == 1
    image = image(:,:,ones(rgb_channels,1));
end

dim = size(image);
power = ceil(log2(dim));

proc_image = zeros(2^power(1), 2^power(2),3);

proc_image(1:dim(1), 1:dim(2), :) = image(:,:,:);


