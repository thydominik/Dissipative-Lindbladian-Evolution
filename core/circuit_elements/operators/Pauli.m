function [Pauli_mtx] = Pauli(handle)
    %PAULI This function creates the appropriate Pauli matrix from the command
    % Pauli(handle); The 'handle' can be 1, 2, 3 or x, y, z
    
    if  handle == 1 || handle == 'x' || handle == 'X'
        Pauli_mtx = [0 1; 1 0];
    elseif  handle == 2 || handle == 'y' || handle == 'Y'
        Pauli_mtx = [0 -1i; 1i 0];
    elseif  handle == 3 || handle == 'z' || handle == 'Z'
        Pauli_mtx = [1 0; 0 -1];
    else
        warning('Input not appropriate, try {1, 2, 3}, {x, y, z} or {X, Y, Z}')
    end
end

