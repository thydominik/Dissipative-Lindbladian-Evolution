clc
clear all

%% Goal:
% Define a very simple circuit with a couple of gates and see how the dissipation rates/interval
% will effect the fidelity of the states (between the dissipative and perfect clculation)

%% Calculation steps-----------------------------
% 1. General parameters and switches
% 2. Define the starting states of the qubits
% 3. Create the quantum state environment
% 4. Define the gates used in the circuit
% 5. Define dissipators and their rates
% 6. Time-evolution
% 7. Measurements
% 8. Results, Plots, saving
% Calculation steps-----------------------------

%% 1: this is a 1 qubit/spin example under dissipaiton of variable rates:

Switch_Figure = 1; % 1 - show and save figures; 0 - no figures, no saves
Switch_Random = 1; % 1 - random initial state; 0 - user defined initial state

seed = 1;   % Random seed
rng(seed);

Starting_state = [1 0];

NoQ = 1; % Number of Qubits

%% 2: Qubit initialization:
% We can start from a random state if the switch is 1 or from some predefined state. Change the
% starting state at the beggining and set Switch_Random = 0 to try that out.

if Switch_Random == 1
    Starting_State(1) = rand(1);
    Starting_State(2) = sqrt(1 - Starting_State(1)^2);
elseif Switch_Random == 0
    Starting_state = Starting_state / norm(Starting_state);     

end

%% 3: Creating the quantum system:

% we can initialize the quantum system by giving the starting density matrix or the pure states
% "wave function".

Starting_QuantumSystem = NQubitStateInit(1, ket2dm(Starting_state), 'm');

%% 4: Define the gates used:

% Here we can define diffrent gates that we want to use in the circuit later on. There are
% predefined gates such as Hadamard ('h'), Pauli operators ('x', 'y', 'z'), Phase gate ('s') ect.
% For full list see the documentation, under Quantum gates.

Hadamard    = QGateInit('h');
X           = QGateInit('x');

%% 5: Define dissipators and their rates:

% I will define 3 pauli dissipators on the system, so in principle I can have 3 different
% dissipation rates. 

Gamma = [0 0 1];

Pauli_X_Diss = LocDissipatorInit(Pauli('X'));
Pauli_Y_Diss = LocDissipatorInit(Pauli('Y'));
Pauli_Z_Diss = LocDissipatorInit(Pauli('Z'));

%% 6: Time-evolution:

% In this time evolution the action of the gates will be instantenious and we will have a
% dissipation between and after them.

QuantumSystem = QStateActGate(Hadamard, Starting_QuantumSystem, 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_X_Diss, Gamma(1), 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_Y_Diss, Gamma(2), 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_Z_Diss, Gamma(3), 1, 1);
QuantumSystem = QStateActGate(X, QuantumSystem, 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_X_Diss, Gamma(1), 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_Y_Diss, Gamma(2), 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_Z_Diss, Gamma(3), 1, 1);

% calculate the evolution without the dissipation:
Perfect_QuantumSystem = QStateActGate(Hadamard, Starting_QuantumSystem, 1, 1);
Perfect_QuantumSystem = QStateActGate(X, Perfect_QuantumSystem, 1, 1);

%% 7.1: Measureing fidelity:

Fidelity_Diss_Perf = Fidelity(QuantumSystem, Perfect_QuantumSystem);

%% 7.2: Changing the rates:

Gamma = linspace(0, 1, 50);
for gammaIndex = 1:50
QuantumSystem = QStateActGate(Hadamard, Starting_QuantumSystem, 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_Z_Diss, Gamma(gammaIndex), 1, 1);
QuantumSystem = QStateActGate(X, QuantumSystem, 1, 1);
QuantumSystem = QStateActDissipator(QuantumSystem, Pauli_Z_Diss, Gamma(gammaIndex), 1, 1);

Fidelity_Diss_Perf(gammaIndex) = Fidelity(Perfect_QuantumSystem, QuantumSystem);
end

%% 8: Results and plots:
figure(1)
clf(figure(1))
hold on
title('\sigma_x dissipation in a q1 - H - X circuit')
xlabel('Dissipation rate for \sigma_x')
ylabel('Fidelity between the perfect and the dissipated evolution.')
plot(Gamma, Fidelity_Diss_Perf, 'r.-', 'LineWidth', 0.1)
xlim([0 1])
ylim([0 1])
box
axis square
yline(0.5, '--')
hold off

saveas(gcf, "Fidelity_1_qubit.png")
save("Fidelity_data", "Fidelity_Diss_Perf")

% -------------------------------------------

figure(2)
clf(figure(2))
hold on
title('Final and starting state on the Bloch sphere')
plotBlochSphere(100, 'sv', 'sv')
plotBlochVec(dv2dm(Perfect_QuantumSystem.DensityVector))
plotBlochVec(dv2dm(Starting_QuantumSystem.DensityVector), 'r')
hold off

saveas(gcf, "Bloch_sphere_1_qubit.png")

% -------------------------------------------

figure(3)
clf(figure(3))
hold on
Tomography_Map(QuantumSystem, 10^-14)
title("Tomography map")
hold off

saveas(gcf, "Tomography_map_1_qubit.png")
