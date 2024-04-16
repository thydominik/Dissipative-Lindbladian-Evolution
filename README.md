# Dissipative-Lindbladian-Exact-Time-Evolution

A Matlab repository that contains the basic elements for exact Lindbladian time-evolution on qubits/two-level systems.

## Introduction
This MATLAB package provides a robust implementation for exact time evolution using the Lindbladian formalism [1]. It offers a versatile toolset for simulating the dynamics of open quantum systems, accounting for both unitary evolution and dissipative processes. Dissipation can be implemented as discrete quantum gates, jump operators with arbitrary dissipation rates or as dissipative gates, where we treat the gate and jump operator as a Hamiltonian. 

The main body of the code is located in the _core_ folder of the repository. In order to use the package call pathimport.m, which will add all relevant subfolders from the _core_ to the Matlab path.
```
pathimport
```
After this the example folders contains 3 slightly different examples on using the code. These scripts contain a step-by-step solution to three slightly different problems. 

## Circuit elements
This subfolder contains the main building blocks for a quantum circuit and measurements.
### Quantum gates
The two functions in this folder are creating predefined or user-defined quantum gates.
```
QGateInit.m
QGateSystemInit.m
```
The full list of predefined gates is the following: 
One-qubit gates:
- $\sigma_x$ as 'x' or 'X'
- $\sigma_y$ as 'y' or 'Y'
- $\sigma_z$ as 'z' or 'Z'
- Identity as 'e' or 1
- Hadamard as 'h' or 'H'
- T gate as 't' or 'T'
- sqrt(Z) or Phase gate or S as 's' or 'S'
- A completely costumizable gate with 3 parameters (U) as 'u' or 'U'
- Parametrized phase gate as 'p' or 'P'
Two-qubit gates:
- SWAP as 'swap' or 'SWAP'
- CNOT as 'cnot' or 'CNOT'
- Controlled rotation gate with 1 parameter as 'cr' or 'cR' or 'cphase'

Additionally if the _gate input_ is not a string, but a matrix (the Hilbert space operator), the user can define their own gate. It is important to give the Hilbert space operator and not the Liouvillian space operator, because there is a specific basis choice in the code.

The function will give back a _quantum gate_ object that stores all the necessary information about that gate. The action of that gate is handled elsewhere (see: [quantum_state](https://github.com/thydominik/Dissipative-Lindbladian-Evolution/main/README.md#quantum_state))
This object then can be sued to act on the quantum system separately. Another way of state evolution is to define a gate that acts on all qubits at the same time. This gate structre can be initialized with the second _QGateSystemInit.m_ function, although it is not recommended. This takes us to the _Operators_.

### Operators


```
OneQubitOp.m
OpPrep.m
Pauli.m
SpinOp.m
CliffordGates.m
```
### Measurement

### Dissipator gates
    
## quantum_state
asdasdasdasf df
### quantum_state_common_functions
### quantum_state_methods
### qubits

## time_evolution

## Plot

## test-scipts

## Mentions

## References:
[1] Breuer, Heinz-Peter; Petruccione, F. (2002). The Theory of Open Quantum Systems. Oxford University Press. ISBN 978-0-1985-2063-4.
 Weinberg, Steven (2014). "Quantum Mechanics Without State Vectors". Phys. Rev. A. 90 (4): 042102
