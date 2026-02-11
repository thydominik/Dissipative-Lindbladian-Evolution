function [S] = SpinOp(handle)
% SPINOP This function creates the spin - 1/2 spin operators from the
% command SpinOp(handle); The 'handle' can be 1 - x, 2 - y, 3 - z, 4 -
% p, 5 - m

hbar = 1;

if handle == 1 || strmpi(handle, 'x')
    S = hbar/2 * Pauli('x');
elseif handle == 2 || strmpi(handle, 'y')
    S = hbar/2 * Pauli('y');
elseif handle == 3 || strmpi(handle, 'z')
    S = hbar/2 * Pauli('z');
elseif handle == 4 || strmpi(handle, 'p') || strmpi(handle, '+')
    S = [0 1; 0 0];
elseif handle == 5 || strmpi(handle, 'm') || strmpi(handle, '-')
    S = [0 0; 0 1];
else
    warning('Input not appropriate, try {(1, 2, 3, 4, 5) or {x, y, z, p, m}}')
end
end

