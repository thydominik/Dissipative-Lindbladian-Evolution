function [S] = SpinOp(handle)
    %SPINOP This function creates the spin - 1/2 spin operators from the
    %command SpinOp(handle); The 'handle' can be 1 - x, 2 - y, 3 - z, 4 -
    %p, 5 - m

    if handle == 1 || handle == 'x'
        S = Pauli('x');
    elseif handle == 2 || handle == 'y'
        S = Pauli('y');
    elseif handle == 3 || handle == 'z'
        S = Pauli('z');
    elseif handle == 4 || handle == 'p'
        S = [0 1; 0 0];
    elseif handle == 5 || handle == 'm'
        S = [0 0; 0 1];
    else
        warning('Input not appropriate, try {(1, 2, 3, 4, 5) or {x, y, z, p, m}}')
    end
end

