function [rho_Q] = PartialTrace(RhoV, q)
%PARTIALTRACE: Gets a density vector then calculates the partial trace of
%that, and gives back a 4 by 1 density vector of selected qubit.
% RhoV - density vector
% q - the cubit that we want to trace out.

NRhoV   = length(RhoV);                     %length of Rho vector
NoQ     = round(log(sqrt(NRhoV))/log(2));   %Number of qubits in the system

if q > NoQ || q < 0
    warning('There is no qubit there, q must be [1 N]')
end

%alpha       = 0:1:2^(2 * NoQ)-1;

% The structure of alpha = Ar Br Cr Dr... Ac Bc Cc Dc..., so there are 2 *
% NoQ indicies. If we want to trace out the 2nd qubit for example:

%Selecting the qth cubit
index = zeros(2*NoQ, 1);

for i = 1:2
    for j = 1:2
        rho_Q(2 * (i - 1) + j)  = 0;

        index(q)        = i - 1;
        index(NoQ + q)  = j - 1;

        for m = 0:(2^(NoQ - 1) - 1)
            index_temp = flip(de2bi(m, NoQ - 1));

            alphaBiL = [index_temp(1:q - 1) (i - 1) index_temp(q:end)];
            alphaBiR = [index_temp(1:q - 1) (j - 1) index_temp(q:end)];

            alpha = bi2de(flip([alphaBiL alphaBiR])) + 1;

            rho_Q(2 * (i - 1) + j) = rho_Q(2 * (i - 1) + j) + RhoV(alpha);
        end
    end
end
end

