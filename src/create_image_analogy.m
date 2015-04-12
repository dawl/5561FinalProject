function [ Bp_image ] = create_image_analogy( A_path, Ap_path, B_path )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
display_steps = 1
input_A = im2double((imread(A_path)));
input_B = im2double((imread(B_path)));
input_Ap = im2double(imread(Ap_path));

A = initImage(input_A);
B = initImage(input_B);
Ap = initImage(input_Ap);
if display_steps
figure;
imshow(A);
figure;
imshow(B);
end

%% Compute Gaussian pyramids for A, A?, and B
A_gauss = construct_gaussian_pyramid(A);
B_gauss = construct_gaussian_pyramid(B);
Ap_gauss = construct_gaussian_pyramid(Ap);

levels = min(length(A_gauss), length(B_gauss));

A_dims = cell(1,levels);
B_dims = cell(1, levels);
A_pow2_dims = cell(1,levels);
B_pow2_dims = cell(1, levels);
A_size = size(input_A);
B_size = size(input_B);
for l = 1:levels
    A_pow2_dims{l} = size(A_gauss{l});
    B_pow2_dims{l} = size(B_gauss{l});
    A_dims{l} = floor(A_size(1:2)/2^(l-1));
    B_dims{l} = floor(B_size(1:2)/2^(l-1));

    
end


%% Display Pyramids
if display_steps
    display_gaussian_pyramid(A_gauss);
    display_gaussian_pyramid(Ap_gauss);
    display_gaussian_pyramid(B_gauss);
end

%% Compute features for A, A?, and B
A_feat = cell(1,levels);
Ap_feat = cell(1,levels);
B_feat = cell(1,levels);

for l = 1:levels
    A_feat{l} = compute_features(initImage(A_gauss{l}));
    Ap_feat{l} = compute_features(initImage(Ap_gauss{l}));
    B_feat{l} = compute_features(initImage(B_gauss{l}));
end


%% Initialize the search structures (e.g., for ANN)


Bp_feat = cell(1,levels);
for l = levels:-1:1
    Bp_feat{l} = zeros(size(B_feat{l}));
end
s = Bp_feat;


%% Loops
for l = levels:-1:1
    for q = 1:length(B_feat{l})
        if q == 3903
            
        end
        if( isValidIndex(q, B_pow2_dims{l}, B_dims{l} ) == 1)
            %q
            p = best_match(A_feat,Ap_feat,B_feat,Bp_feat,A_dims,A_pow2_dims, B_dims,B_pow2_dims, s,l,q);
%             N = Neighborhood([2,2],p,B_pow2_dims{l},B_dims{l});
% 
%             F = f_concat(q,B_feat,Bp_feat,B_pow2_dims,B_dims,l);
%             F
            feat = Ap_feat{l}(p,:);
       
            Bp_feat{l}(q,:) = feat;
%                         Bp_feat{l}(q,:) =  B_feat{l}(q,:);

            s{l} = p;
        end
    end
end


%% Reconstruct result
Bp_image = reconstruct_image_from_features(Bp_feat{1},size(B_gauss{1}));

end

