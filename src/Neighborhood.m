function [ N ] = Neighborhood(window_radius, p, pow2_image_dim, image_dim  )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
if(p == 24)
end
%% Calculate coords of current p
pos_y = floor(p/pow2_image_dim(2));
pos_x =  mod(p, pow2_image_dim(1));
coord = [pos_y, pos_x];

%% Calcualte p for lower level
lower_coord = floor(coord/2);

%% Init Neighbor array
N = zeros((window_radius(1)*2 + 1)*(window_radius(2)*2 + 1),1);
N_count = 0;

%% Loops
for row_offset = -window_radius(1):window_radius(1)
    for col_offset = -window_radius(2):window_radius(2)
        neighbor_x = pos_x + col_offset;
        neighbor_y = pos_y + row_offset;
        neighbor_coord = [ neighbor_y, neighbor_x];
        
        p_offset = p + row_offset*pow2_image_dim(1) + col_offset;
        
        cond1 = (min(neighbor_coord >= [1,1]) == 1);
        cond2 = (min(neighbor_coord <= image_dim) == 1);
        
        N_count = N_count+1;

                    
        if  cond1 && cond2 
            N(N_count) = p_offset;
        else
            %fprintf('Skip\n');
            %% Pick a random spot we've already looked at if offscreen.
            %  May need work.
            N(N_count) = -1;

        end
    end
end
end

