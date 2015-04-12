function [ isValid ] = isValidIndex(index, pow2_image_dim, image_dim )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

pos_x = floor((index-1)/pow2_image_dim(2))+1;
pos_y =  mod((index-1), pow2_image_dim(1))+1;
if pos_x > 30
end

coord = [ pos_y, pos_x];

isValid = 1;

comp = coord > image_dim(1:2);

if max(comp) == 1 || pos_y <= 0 || pos_x <= 0
    isValid  = 0;
end

end

