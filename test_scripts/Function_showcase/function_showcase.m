clc
clear all

%% Preparing two random states

State_1(1) = rand();
State_1(2) = sqrt(1 - State_1(1)^2)

State_2(1) = rand();
State_2(2) = sqrt(1 - State_2(1)^2)

%% Putting them together in a quantum system object
QuantumSystem = NQubitStateInit(1, ket2dm(State_1), 'm', 'This is my lovely qubit!')
QuantumSystem = QStateCombine(QuantumSystem, NQubitStateInit(1, ket2dm(State_2), 'm'), 'These are my two favourite qubits!');

%% Do some minimal operatons on them
P = QGateInit('s')

%% APply the gate
TimeEvolved_QuantumSystem = QStateActGate(P, QuantumSystem, 2, 2)

%% Trace out first qubit:
Qubit_1 = QStatePartialTrace(TimeEvolved_QuantumSystem, 1)
Qubit_2 = QStatePartialTrace(TimeEvolved_QuantumSystem, 2)

%% Measure the second qubit:
QuantumSystem = Hard_Measurement_1_qubit(QuantumSystem, 2);
QuantumSystem.DensityVector

%% Now measure the first:
QuantumSystem = Hard_Measurement_1_qubit(QuantumSystem, 1);
dv2dm(QuantumSystem.DensityVector)

%% Get the 2 qubit basis to understand the order of elements in the density matrix above:
Basis = NQubitBasis(2)

