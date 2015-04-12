function [ features ] = f_concat( index, original, prime, pow2_dims, dims, level )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

win = 2;
win_count = (win*2+1)^2;
win_center = ceil(win_count/2);

%% Should we decend to the next layer?
below = 0;
if level < length(original)
    below = 0;
end

%% Find the neighborhood of the pixel in both original and prime
N_o = Neighborhood([win,win],index,pow2_dims{level},dims{level});


% Substitute out-of-bounds with center pixel
N = N_o;
% TODO: GOT A -10 FOR ONE OF THESE. CHECK THAT OUT SOMETIME.
N(N <= 0) = index;
% trim prime to only include up to the center pixel ( because we 
% haven't scanned past this yet)
trimmed_N = N(1:win_center);


features_original = original{level}(N,:);
features_prime = prime{level}(trimmed_N,:);

features = [features_original; features_prime];


if below == 1
    win_lower = win-1;
    win_count_lower = (win_lower*2+1)^2;
    win_center_lower = ceil(win_count_lower/2);


    N_lower = Neighborhood([win_lower,win_lower],index,pow2_dims{level+1},dims{level+1});
    % Substitute out-of-bounds with center pixel
    N_lower(N_lower == -1) = floor(index/2);
    % trim prime to only include up to the center pixel ( because we 
    % haven't scanned past this yet)
    N_lower_trimmed = N_lower(1:win_center_lower);
    
    features_original_lower = original{level}(N_lower,:);
    features_prime_lower = prime{level}(N_lower_trimmed,:);
    
    features_lower = [features_original_lower; features_prime_lower];
    
    features = [features;features_lower];

end

%% Turn into a 1D-vector
features = reshape(features, numel(features),1);



end

