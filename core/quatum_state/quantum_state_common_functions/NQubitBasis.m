function [Basis] = NQubitBasis(N)
    %NQUBITBASIS: Creates (just for show) an N - qubit basis
% OLD --------------------------------------------
% Basis = zeros(2^N, floor(1 + log(N)/(log(2))));
% S = floor(1 + log(N)/(log(2)));
% for i = 1:2^N
%     temp = flip(de2bi(i - 1));
%     temp_length = length(temp);
%     temp_zeros = zeros(1, S - temp_length);
%     b = [temp_zeros temp]
%     Basis(i, :) = b;
% end
% OLD --------------------------------------------

% NEW ---------------------------
Basis = dec2bin(0:1:2^N-1)-'0';
% NEW ---------------------------
end

