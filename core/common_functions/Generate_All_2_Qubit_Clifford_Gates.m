function [Clifford_Gates_2_Qubits, Clifford_Lables] = Generate_All_2_Qubit_Clifford_Gates()

% Identity
Id = [1 0; 0 1];
% Pauli Gates
PX = [0 1; 1 0];
PY = [0 -1i; 1i 0];
PZ = [1 0; 0 -1];
% Hadamard
H = 1/sqrt(2) * [1 1; 1 -1];
% Phase gate
S = [1 0; 0 1i];
% Two site Clifford qubit gates (11520):
Clifford_Gates_2_Site = {};

% Hadamard "group" and it's labels
Hadamard_group       = {};
Hadamard_group{1}    = Id;
Hadamard_group{2}    = H;

Hadamard_group_labels{1} = 'I';
Hadamard_group_labels{2} = 'H';

% Phase shift "group" and it's labels
Phaseshift_group       = {};
Phaseshift_group{1}    = Id;
Phaseshift_group{2}    = H * S;
Phaseshift_group{3}    = S * H;

Phaseshift_group_labels{1} = 'I';
Phaseshift_group_labels{2} = 'HS';
Phaseshift_group_labels{3} = 'SH';

% "States" "group" and it's labels
Pauli_group       = {};
Pauli_group{1}    = Id;
Pauli_group{2}    = PX;
Pauli_group{3}    = PY;
Pauli_group{4}    = PZ;

Pauli_group_labels{1} = 'I';
Pauli_group_labels{2} = 'X';
Pauli_group_labels{3} = 'Y';
Pauli_group_labels{4} = 'Z';

% these will be accesed multiple t1ies (although the code is almost instantenious regardless...)
Dimension_Hadamard_group    = length(Hadamard_group);
Dimension_Phaseshift_group  = length(Phaseshift_group);
Dimension_Pauli_group       = length(Pauli_group);

% Gates created from the 1 qubit clifford gates (2, 2, 3, 3, 4, 4)
Clifford_Lables = {};
for hj1 = 1:Dimension_Hadamard_group
    for hj2 = 1:Dimension_Hadamard_group
        for vj1 = 1:Dimension_Phaseshift_group
            for vj2 = 1:Dimension_Phaseshift_group
                for pj1 = 1:Dimension_Pauli_group
                    for pj2 = 1:Dimension_Pauli_group
                        Clifford_Gates_2_Site{length(Clifford_Gates_2_Site) + 1} = kron(Hadamard_group{hj1}, Hadamard_group{hj2}) * kron(Phaseshift_group{vj1}, Phaseshift_group{vj2}) * kron(Pauli_group{pj1}, Pauli_group{pj2});
                        Clifford_Lables{length(Clifford_Lables) + 1} = ['(' Hadamard_group_labels{hj1} '⊗' Hadamard_group_labels{hj2} ')' '*' '(' Phaseshift_group_labels{vj1} '⊗' Phaseshift_group_labels{vj2} ')' '*' '(' Pauli_group_labels{pj1} '⊗' Pauli_group_labels{pj2} ')'];
                    end % pj2
                end % pj1
            end % vj2
        end % vj1
    end % hj2
end % hj1

% CNOT class contains 5184 elements = 24^2*3^2 or (2, 2, 3, 3, 3, 3, 4, 4)

CNOT = [1 0 0 0
    0 1 0 0
    0 0 0 1
    0 0 1 0];


for hj1 = 1:Dimension_Hadamard_group
    for hj2 = 1:Dimension_Hadamard_group
        for vj1 = 1:Dimension_Phaseshift_group
            for vj2 = 1:Dimension_Phaseshift_group
                for vj3 = 1:Dimension_Phaseshift_group
                    for vj4 = 1:Dimension_Phaseshift_group
                        for pj1 = 1:Dimension_Pauli_group
                            for pj2 = 1:Dimension_Pauli_group
                                Clifford_Gates_2_Site{length(Clifford_Gates_2_Site) + 1} = kron(Hadamard_group{hj1}, Hadamard_group{hj2}) * kron(Phaseshift_group{vj1}, Phaseshift_group{vj2}) * CNOT * kron(Phaseshift_group{vj3}, Phaseshift_group{vj4}) * kron(Pauli_group{pj1}, Pauli_group{pj2});
                                Clifford_Lables{length(Clifford_Lables) + 1} = ['(' Hadamard_group_labels{hj1} '⊗' Hadamard_group_labels{hj2} ')' '*' '(' Phaseshift_group_labels{vj1} '⊗' Phaseshift_group_labels{vj2} ')' '*' 'CNOT' '*' '(' Phaseshift_group_labels{vj1} '⊗' Phaseshift_group_labels{vj2} ')' '*' '(' Pauli_group_labels{pj1} '⊗' Pauli_group_labels{pj2} ')'];
                            end % pj2
                        end % pj1
                    end % vj4
                end % vj3
            end % vj2
        end % vj1
    end % hj2
end % hj1

% class 3 elements with SWAP and CNOT class contains 5184 elements

SWAP = [1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1];

for hj1 = 1:Dimension_Hadamard_group
    for hj2 = 1:Dimension_Hadamard_group
        for vj1 = 1:Dimension_Phaseshift_group
            for vj2 = 1:Dimension_Phaseshift_group
                for vj3 = 1:Dimension_Phaseshift_group
                    for vj4 = 1:Dimension_Phaseshift_group
                        for pj1=1:Dimension_Pauli_group
                            for pj2=1:Dimension_Pauli_group
                                Clifford_Gates_2_Site{length(Clifford_Gates_2_Site) + 1} = kron(Hadamard_group{hj1}, Hadamard_group{hj2}) * kron(Phaseshift_group{vj1}, Phaseshift_group{vj2}) * SWAP * CNOT * kron(Phaseshift_group{vj3}, Phaseshift_group{vj4}) * kron(Pauli_group{pj1}, Pauli_group{pj2});
                                Clifford_Lables{length(Clifford_Lables) + 1} = ['(' Hadamard_group_labels{hj1} '⊗' Hadamard_group_labels{hj2} ')' '*' '(' Phaseshift_group_labels{vj1} '⊗' Phaseshift_group_labels{vj2} ')' '*' 'SWAP' '*' 'CNOT' '*' '(' Phaseshift_group_labels{vj1} '⊗' Phaseshift_group_labels{vj2} ')' '*' '(' Pauli_group_labels{pj1} '⊗' Pauli_group_labels{pj2} ')'];
                            end % pj2
                        end % pj1
                    end % vj4
                end % vj3
            end % vj2
        end % vj1
    end % hj2
end % hj1

% class 4 elements contains 576 elements (2, 2, 3, 3, 4, 4).

for hj1 = 1:Dimension_Hadamard_group
    for hj2 = 1:Dimension_Hadamard_group
        for vj1 = 1:Dimension_Phaseshift_group
            for vj2 = 1:Dimension_Phaseshift_group
                for pj1=1:Dimension_Pauli_group
                    for pj2=1:Dimension_Pauli_group
                        Clifford_Gates_2_Site{length(Clifford_Gates_2_Site) + 1} = kron(Hadamard_group{hj1}, Hadamard_group{hj2}) * kron(Phaseshift_group{vj1}, Phaseshift_group{vj2}) * SWAP * kron(Pauli_group{pj1}, Pauli_group{pj2});
                        Clifford_Lables{length(Clifford_Lables) + 1} = ['(' Hadamard_group_labels{hj1} '⊗' Hadamard_group_labels{hj2} ')' '*' '(' Phaseshift_group_labels{vj1} '⊗' Phaseshift_group_labels{vj2} ')' '*' 'SWAP' '*' '(' Pauli_group_labels{pj1} '⊗' Pauli_group_labels{pj2} ')'];
                    end % pj2
                end % pj1
            end % vj2
        end % vj1
    end % hj2
end % hj1
Clifford_Gates_2_Qubits     = Clifford_Gates_2_Site;
Labels                      = Clifford_Lables;
end

