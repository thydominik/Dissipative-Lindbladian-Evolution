function [LL] = LindbladEvol(Hamiltonian, F_op, Gamma)
    %LINDBLADEVOL Formulates the Lindbladian operator that acts on the density
    %vector.
    
    % Hami - Hamiltonian
    % F - List of the dissipators/ jump operators
    % G - List of the dissipator weights
    
    % Formulateing the Hamiltonian part:
    L_H = kron(Hamiltonian, eye(size(Hamiltonian))) - kron(eye(size(Hamiltonian)), conj(Hamiltonian));
    
    % Dissipator part:
    L_D = zeros(size(L_H));
    for ind = 1:length(Gamma)
        n = length(F_op(ind, :, :));
        tempF = reshape(F_op(ind, :, :), [n, n]);
        tempFpF = ctranspose(tempF) * tempF;
        tempMTX = 2 * kron(tempF, conj(tempF)) - kron(tempFpF, eye(size(tempFpF))) - kron(eye(size(tempFpF)), tempFpF);
        
        L_D = L_D + 1i * 0.5 * Gamma(ind) *  tempMTX;
    end
    LL = L_H + L_D;
end

