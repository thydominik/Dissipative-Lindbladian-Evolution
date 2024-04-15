function [dm] = dv2dm(dv)
    %DV2DM: Density Vector to Density matrix. From a |rho) which is (n * n) x 1
    %dimensional vector we get a n x n dimensional matrix

    NoQ = log(sqrt(length(dv)))/log(2);
    dv  = InverseBasisTransform(dv, 'v', NoQ );

    dm  = reshape(dv, [2^NoQ 2^NoQ]).';
end

