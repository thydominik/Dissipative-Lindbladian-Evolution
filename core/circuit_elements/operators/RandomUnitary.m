function [UnitaryMatrix, Verification] = RandomUnitary(n)
% Generates a random complex unitary matrix  
% example: [U, ~] = RandomUnitary(2^NoQ);

Temp_matrix = complex(rand(n), rand(n)); 

% factorize the matrix 
[Q, R]  = qr(Temp_matrix); 
R       = diag(diag(R)./abs(diag(R))); 

% unitary matrix 
UnitaryMatrix = Q * R; 

% verification 
Verification = UnitaryMatrix * UnitaryMatrix';

end

