clc
clear all
% this is a 1 qubit/spin example under dissipaiton of variable rates:

Switch_Figure = 1; % 1 - show and save figures; 0 - no figures, no saves
Switch_Random = 1; % 1 - random initial state; 0 - user defined initial state

seed = 1;   % Random seed
rng(seed);

Starting_state = [1 0];

NoQ = 1; % Number of Qubits

%% Qubit initialization:
if Switch_Random == 1
    Starting_State(1) = rand(1);
    Starting_State(2) = sqrt(1 - Starting_State(1)^2);
elseif Switch_Random == 0
    Starting_state = [1 0];
end

%% Creating the quantum system:

