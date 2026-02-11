function [U, LU] = OneQubitOp(GateInput, qubit, rho)
% NQUBITOP: Takes a one qubit gate and constructs the gate that acts
% on the whole |rho) with that such that: G -> ...I x I x G x I x I... and
% gives back the operator that acts on the Liouville space

% NOTE: this is not an efficient way of acting with any gate!

% INPUT --------------------------------------------
% GateInput - [Matrix], The quantum gate
% rho - [Vector], density vector
% qubit - [Integer], # of the first qubit that we want to act on
% INPUT --------------------------------------------

Length_Rho_vec  = length(rho);                          %length of Rho vector
NoQ             = round(log((Length_Rho_vec))/log(2));  %Number of qubits in the system

% Building up the operator on Hilbert space:
Length_G    = length(GateInput);
NoQG        = round(log(Length_G)/log(2));  % how many qubits are involved in the gate action

% populating the hilbert space gate with identity operators
if qubit == 1 && (NoQG < NoQ)
    U   = sparse(GateInput);
    U   = kron(U, speye(NoQ - 1));
    LU  = kron(U, conj(U));

elseif qubit == NoQ && (NoQG == 1)
    U   = sparse(GateInput);
    U   = kron(speye(NoQ - 1), U);
    LU  = kron(U, conj(U));

elseif (qubit + NoQG - 1) <= NoQ
    U   = sparse(GateInput);
    U   = kron(speye(qubit - 1), U);
    U   = kron(U, speye(NoQ - qubit));
    LU  = kron(U, conj(U));

else
    warning('There is no qubit there pal.')
    U = 0;
    LU = U;
end
end

