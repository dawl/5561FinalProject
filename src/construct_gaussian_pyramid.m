function [ gaussian_pyramid ] = construct_gaussian_pyramid( image)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

sigma = 4;
hsize = 4;
dim = size(image)
smallest_dim = min(dim(1:2))
power = floor(log2(smallest_dim));
levels = power-2

laplacian_pyramid = construct_pyramid(image, levels, sigma, hsize);
gaussian_pyramid = laplacian_to_gaussian(laplacian_pyramid);

end


function [pyramid] = laplacian_to_gaussian(l_pyramid)
    pyramid = l_pyramid;
    for l = length(pyramid)-1:-1:1
        pyramid{l} = reconstruct_image(pyramid(l:l+1));
    end
end

