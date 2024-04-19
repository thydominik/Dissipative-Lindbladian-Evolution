clc
clear all

%% Goal:
% Define a randomly initialized N qubit system. Define dissipative gates that prepares the GHZ state if the qubit are prepared correctly and do the time evolution
% on them.

%% Calculation steps--same as for 1 qubit--------
% 1. General parameters and switches
% 2. Define the starting states of the qubits
% 3. Create the quantum state environment
% 4. Define the dissipative gates used in the circuit
% 5. Time-evolution
% 6. Measurements
% 7. Results, Plots, saving
% Calculation steps-----------------------------

%% 1: this is a 1 qubit/spin example under dissipaiton of variable rates:

Switch_Figure = 1; % 1 - show and save figures; 0 - no figures, no saves
Switch_Random = 1; % 1 - random initial state; 0 - user defined initial state

seed = 1;   % Random seed
rng(seed);

NoQ = 5; % Number of Qubits

%% 2: Qubit initialization:
% We can start from a random state if the switch is 1 or from some predefined state. Change the
% starting state at the beggining and set Switch_Random = 0 to try that out.

for qubitIndex = 1:NoQ
    Random_state = rand();
    Qubits(qubitIndex, :) = [Random_state sqrt(1 - Random_state^2)];
end

%% 3: Creating the quantum system:

% we can initialize the quantum system by giving the starting density matrix or the pure states
% "wave function".

%First creating the product state parts:
for qubitIndex = 1:NoQ
    QubitSystems(qubitIndex) = NQubitStateInit(1, ket2dm(Qubits(qubitIndex, :)), 'm');
end

%Then combining them into a 7 qubit system. Note that one can initialize the 7 qubit system from the
%start, with carefully ordering the basis states!

QuantumSystem = QubitSystems(1);
for qubitIndex = 2:NoQ
    QuantumSystem = QStateCombine(QuantumSystem, QubitSystems(qubitIndex));
end
Starting_QuantumSystem = QuantumSystem;     % saving the initial starting quatum system.

%% 4: Define the dissipative gates used:

%The sigma_x,y,z dissipation gamma rates for the hadamard gate
H_rates = 0.1 * [0.1 0.1 0.1];
% same thing for the cnot, but in this case there are 6 different Pauli operators {x1, x2, y1, y2, ...}:
cn_rates = 0.1 * [0.2 0.2 0.2 0.2 0.2 0.2];

%Dissipative quantum gates:
H   = DissipativeQuantumGate_Init('h');
CN  = DissipativeQuantumGate_Init('CNot');

%% 5: Time-evolution:

%Notice that each gate has a duration (Hadamard for example pi/2). this is the "time interval" the
%gate needs to act. So without dissipation, it takes that gate pi/2 "time" to perform a perfect
%hadamard operaton.

QuantumSystem = QStateActGate(H, Starting_QuantumSystem, 1, NoQ, H_rates);
for i = 2:NoQ
    QuantumSystem = QStateActGate(CN, QuantumSystem, [i (i - 1)], NoQ, cn_rates);
end

% calculate the evolution without the dissipation:
Perfect_QuantumSystem = QStateActGate(H, Starting_QuantumSystem, 1, NoQ, [0 0 0]);
for i = 2:NoQ
    Perfect_QuantumSystem = QStateActGate(CN, Perfect_QuantumSystem, [i (i - 1)], NoQ, [0 0 0 0 0 0]);
end


%% 6.1: Measureing fidelity:

Fidelity_Diss_Perf = Fidelity(QuantumSystem, Perfect_QuantumSystem);

%% 6.2: Changing the rates and measuring entropy:
%Ramping up the rates by the same factor:
Mult_factor = linspace(0, 2, 50);
for factorIndex = 1:50
    QuantumSystem = QStateActGate(H, Starting_QuantumSystem, 1, NoQ, Mult_factor(factorIndex) * H_rates);
    for i = 2:NoQ
        QuantumSystem = QStateActGate(CN, QuantumSystem, [i (i - 1)], NoQ, Mult_factor(factorIndex) * cn_rates);
    end

    Fidelity_Diss_Perf(factorIndex) = Fidelity(Perfect_QuantumSystem, QuantumSystem);
    VonNeumannEntropy(factorIndex)  = QStateVonNeumannEntropy(QuantumSystem);
end

%% 7.1: Results and plots:
figure(1)
clf(figure(1))
hold on
title('Fidelity of the perfect and dissipative GHZ state preparation')
xlabel('Dissipation rate of Hadamard gate')
ylabel('Fidelity')
plot(Mult_factor * H_rates(1), Fidelity_Diss_Perf, 'r.-', 'LineWidth', 0.1)
xlim([min(Mult_factor * H_rates(1)) max(Mult_factor * H_rates(1))])
ylim([0 1])
box
axis square
yline(0.5, '--')
hold off

saveas(gcf, "Fidelity_N_qubit_GHZ.png")
save("Fidelity_data", "Fidelity_Diss_Perf")

%% 7.2: Results and plots:
figure(2)
clf(figure(2))
hold on
title('Von Neumann Entropy of the whole system')
xlabel('Dissipation rate of Hadamard gate')
ylabel('S_{VN}')
plot(Mult_factor * H_rates(1), VonNeumannEntropy, '.-')
xlim([min(Mult_factor * H_rates(1)) max(Mult_factor * H_rates(1))])
ylim([0 max(abs(VonNeumannEntropy))])
box
axis square
hold off

saveas(gcf, "SVN_N_qubit_GHZ.png")
save("Entropy_data", "VonNeumannEntropy")
%% 7.3: Tomography map -------------------------------------------

figure(3)
clf(figure(3))
hold on
Tomography_Map(Perfect_QuantumSystem, 10^-14)
title("Tomography map")
hold off

saveas(gcf, "Tomography_map_N_qubit.png")
