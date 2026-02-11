function [BV, Norm] = dm2bv(rho)
%KET2BV: Ket vector to Bloch vector

Sx = [0 1; 1 0];
Sz = [1 0; 0 -1];
Sy = 1i * Sx * Sz;

BV      = [trace(Sx * rho); trace(Sy * rho); trace(Sz * rho)];  
Norm    = norm(BV);                                             % important for dissipative systems.
end

