function [ p ] = best_approximate_match( A_feat, Ap_feat, B_feat, Bp_feat, A_dims, B_dims, level, q  )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    p = 1;
    p = knnsearch(A_feat{level},B_feat{level}(q,:));
end

