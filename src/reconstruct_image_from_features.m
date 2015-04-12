function [ image ] = reconstruct_image_from_features( features, dimension )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
dimension
size(features(:,1:3))
image = reshape(features(:,1:3),dimension);

end

