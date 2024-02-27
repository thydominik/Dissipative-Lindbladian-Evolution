function [U, UU] = OneQubitOp(G, q, rho)
% NQUBITOP: Takes a one qubit gate and constructs the gate that acts
% on the whole |rho) with that such that: G -> ...I x I x G x I x I... and
% gives back the operator that acts on the Liouville space
% q - # of the first qubit that we want to act on
% rho - density vector
% G - gate

    NRhoV  = length(rho); %length of Rho vector
    NoQ   = round(log((NRhoV))/log(2));  %Number of qubits in the system
    
    % Building up the operator on Hilbert space:
    Length_G = length(G);
    NoQG = round(log(Length_G)/log(2)); 
    
    if q == 1 && (NoQG < NoQ)
        U = sparse(G);

        U = kron(U, speye(NoQ - 1)); % !!!!!!!!!!!!!!

        UU = kron(U, conj(U));
    elseif q == NoQ && (NoQG == 1)
        U = sparse(G);

        U = kron(speye(NoQ - 1), U); % !!!!!!!!!!!!!!!!!!!!

        UU = kron(U, conj(U));
    elseif (q + NoQG - 1) <= NoQ
        U = sparse(G);

        U = kron(speye(q - 1), U);
        U = kron(U, speye(NoQ - q));

        UU = kron(U, conj(U));
    else
        warning('There is no qubit there pal.')
        U = 0;
        UU = U;
    end
    
    %Now the Liouville space operator:
    

end

