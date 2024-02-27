function [LL] = LindbladEvol(Hami, F, G)
    %LINDBLADEVOL Formulates the Lindbladian operator that acts on the density
    %vector.
    %Hami - Hamiltonian
    %F - List of the dissipators
    %G - List of the dissipator weights
    
    %Formulateing the Hamiltonian part:
    L_H = kron(Hami, eye(size(Hami))) - kron(eye(size(Hami)), conj(Hami));
    
    %Dissipator part:
    L_D = zeros(size(L_H));
    for ind = 1:length(G)
        n = length(F(ind, :, :));
        tempF = reshape(F(ind, :, :), [n, n]);
        tempFpF = ctranspose(tempF) * tempF;
        tempMTX = 2 * kron(tempF, conj(tempF)) - kron(tempFpF, eye(size(tempFpF))) - kron(eye(size(tempFpF)), tempFpF);
        
        L_D = L_D + 1i * 0.5 * G(ind) *  tempMTX;
    end
    LL = L_H + L_D;
end

