function [Gates, Labels] = Generate_All_1_Qubit_Clifford_Gates()

% Generating all the one and two qubit Clifford gates.
% One site Clifford qubit gates (24):

    % Identity
    Id = [1 0; 0 1];

    % Pauli Gates
    PX = [0 1; 1 0];
    PY = [0 -1i; 1i 0];
    PZ = [1 0; 0 -1];

    % Hadamard;
    H = 1/sqrt(2) * [1 1; 1 -1];

    % Phase gate
    S = [1 0; 0 1i];
    
    % The product of the following two dictionaries will give all possible matrix products from the generator set {X, Z, H, S}
    % The states that we are going to transform
    States = {};

    States{1} = Id;
    States{2} = PX;
    States{3} = PY;
    States{4} = PZ;

    % Giving labels to the gates:
    StatesLabels{1} = 'Id';
    StatesLabels{2} = 'X';
    StatesLabels{3} = 'Y';
    StatesLabels{4} = 'Z';

    % Rotations around the bloch sphere
    Rotations = {};

    Rotations{1} = Id;
    Rotations{2} = H;
    Rotations{3} = S;
    Rotations{4} = H * S;
    Rotations{5} = S * H;
    Rotations{6} = S * H * S;

    % Labels again
    RotationsLabels{1} = 'Id';
    RotationsLabels{2} = 'H';
    RotationsLabels{3} = 'S';
    RotationsLabels{4} = 'HS';
    RotationsLabels{5} = 'SH';
    RotationsLabels{6} = 'SHS';

    %Generating the 1 qubit clifford gates
    CliffordGates_1Site = {};       % with size length(Rotations) * length(States) = 24

    CliffordGates_1Site_labels = {};

    for StateInd = 1:length(States)
        for RotationsInd = 1:length(Rotations)
            CliffordGates_1Site{length(CliffordGates_1Site) + 1}                = States{StateInd} * Rotations{RotationsInd};
            CliffordGates_1Site_labels{length(CliffordGates_1Site_labels) + 1}  = [StatesLabels{StateInd} RotationsLabels{RotationsInd}];
        end
    end
    Gates   = CliffordGates_1Site;
    Labels  = CliffordGates_1Site_labels;

end

