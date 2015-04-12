function [ p ] = best_match( A_feat, Ap_feat, B_feat, Bp_feat, A_dims,A_pow2_dims, B_dims, B_pow2_dims,  s, level, q )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

F_q = f_concat(q,B_feat,Bp_feat,B_pow2_dims,B_dims, level);
p_app = best_approximate_match( A_feat, Ap_feat, B_feat, Bp_feat, A_dims, B_dims, level, q  );
p_coh = best_coherence_match( A_feat, Ap_feat, B_feat, Bp_feat, A_dims, B_dims, s, level,  q  );

F_p_app =  f_concat(p_app,A_feat,Ap_feat,A_pow2_dims,A_dims, level);
F_p_coh =  f_concat(p_coh,A_feat,Ap_feat,A_pow2_dims,A_dims, level);

d_app = norm(F_p_app - F_q)^2
d_coh = norm(F_p_coh - F_q)^2


p = p_app;
end

