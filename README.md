# Dissipative-Lindbladian-Exact-Time-Evolution

A Matlab repository that contains the basic elements for exact Lindbladian time-evolution on qubits/two-level systems.

## Introduction
This MATLAB package provides a robust implementation for exact time evolution using the Lindbladian formalism [1]. It offers a versatile toolset for simulating the dynamics of open quantum systems, accounting for both unitary evolution and dissipative processes. Dissipation can be implemented as discrete quantum gates, jump operators with arbitrary dissipation rates or as dissipative gates, where we treat the gate and jump operator as a Hamiltonian. 

The main body of the code is located in the _core_ folder of the repository. In order to use the package call pathimport.m, which will add all relevant subfolders from the _core_ to the Matlab path.

Please note that this code was made for research purposes.
```
pathimport
```
After this the example folder contains 3 slightly different examples on using the code. These scripts contain a step-by-step solution to three slightly different problems. 

## Circuit elements
This subfolder contains the main building blocks for a quantum circuit and measurements.
### Quantum gates
The two functions in this folder are creating predefined or user-defined quantum gates.
```
QGateInit.m
QGateSystemInit.m
```
One way to use the Lindblad master equation is to vectorise the density matrix:

$\hat\varrho \rightarrow |\varrho)$

There are several ways of doing the vectorization, but this code uses a binary number ordered basis order: The basis of the state in case of 2 qubits is the following:

$\left\lbrace\ket{00}, \ket{01}, \ket{10}, \ket{11}  \right\rbrace$

In the density vecor formalism this gives us a 1 by 16 vector in order as

$\left\lbrace \ket{00}\bra{00}, \ket{00}\bra{01}, \ket{00}\bra{10}, \ket{00}\bra{11}, \ket{01}\bra{00}, \ket{01}\bra{01}, \ket{01}\bra{10}, \ket{01}\bra{11}, \ket{10}\bra{00}, \ket{10}\bra{01}, \ket{10}\bra{10}, \ket{10}\bra{11}, \ket{11}\bra{00}, \ket{11}\bra{01}, \ket{11}\bra{10}, \ket{11}\bra{11} \right\rbrace$

This enables us to form the Liouvillian quantum gate for one qubit as a simple kronecker product of the gate with itself. The situation is not as simple in case of 2-qubit operators, where a basis transformaiton is needed (see: _BasisTransform.m_)

The full list of predefined gates is the following: 

One-qubit gates:
- $\sigma_x$ as 'x' or 'X'
- $\sigma_y$ as 'y' or 'Y'
- $\sigma_z$ as 'z' or 'Z'
- Identity as 'e' or '1'
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

The function will give back a _quantum gate_ object that stores all the necessary information about that gate. The action of that gate is handled elsewhere (see: [quantum_state](https://github.com/thydominik/Dissipative-Lindbladian-Evolution/blob/main/README.md#quantum_state))
This object then can be sued to act on the quantum system separately. Another way of state evolution is to define a gate that acts on all qubits at the same time. This gate structure can be initialized with the second function QGateSystemInit.m, although it is not recommended. This takes us to the _Operators_.

### Operators
```
OneQubitOp.m
OpPrep.m
Pauli.m
SpinOp.m
CliffordGates.m
RandomUnitary.m
```
_OneQubitOp.m_ and _OpPrep.m_- takes a gate input that acts on one specific cubit then gives back the N qubit operator that acts on the whole system.

_Pauli.m_ - as the name suggests, gives a Pauli operatorback. Possible to call it with numbers (1, 2, 3) or strings (capital or not) ('x', 'y', 'z')

_SpinOp.m_ - Similarly to _Pauli.m_, this function gives back a spin operator.

_CliffordGates.m_ - A function that generates all 1 and 2-qubit Clifford gates in Hilbert space. For running efficiency these are not made a _quantum gate_ by default.

_RandomUnitary.m_ - Gives back an N by N unitary matrix. Note that there is no restriction on the size of this matrix, but for example it is not possible to act on a 2 qubit system with a 3 by 3 unitary.

### Measurement
```
Fidelity.m
Hard_Measurement_1_qubit.m
```

_Fidelity.m_ - Takes two *comparable* quantum system object, rearranges the density vectors into density matricies and calculates the fidelity between them as 

$F(A, B) = \text{trace}\left(\sqrt{A \cdot B} \right)^2$

_Hard_Measurment_1_qubit.m_ - Takes a quantum system and performs a measurement on one qubit, then gives back the measured quantum state of N qubits.

### Dissipator gates
There are three different possibilities of applying dissipation to the system. One is to apply "logical" errors to the system in the form of Pauli operators/gates. This does not require the use of the Lindbladian formalism. The second way is to define dissipators/jump operators, rates and the time interval that these acting on the system. The third way is to incorporate the dissipation effect into the Hamiltonian. Considering the regular (faultless) quantum gate as a Hamiltonian, which act simultaniously with the dissipators. The action of the gate fixes the time interval of the operation while the rate of the dissipator remains a freely adjustable variable.
```
DissipativeQuantumGate_Init.m
DissipatorGateInit.m
LocDissipatorInit.m
```
_DissipativeQuantumGate_Init.m_ - Initializes a dissipative quantum gate with a possibility of a parameter. Dissipative gates have a time duration and all three pauli dissipators are put besides the quantum gate. The strength of such dissipations can be set with a function handle.

_DissipatorGateInit.m_ - Creates a dissipator gate with preset duration, qubitnumber and dissipation rates.

_LocDissipatorInit.m_ - Creates a local dissipator for N qubits. This N is defined by the size of the DissipatorIntup input.

## quantum_state
This folder contains the tools for building up _quantum system_ objects, that contains all or just part of the qubits. 
### qubits
```
NQubitStateInit.m
```
initialize an N qubit state as a structure from the density input provided. This is the most important part of the code, every gate, dissipator, mesurement acts on this object.

### quantum_state_methods
This folder contains the main methods that can be applied to the quantum system. The example files demonstrait how these work in detail.
```
QStateActDissipator.m
QStateActGate.m
QStateCombine.m
QStateGetNorm.m
QStateGetStateVec.m
QStatePartialTrace.m
QStateVonNeumannEntropy.m
```

## time_evolution
Time evolution folders contain two functions that evolves density matricies for comparison to the vectorized gate actions.
```
LidnbladEvol.m
dmUnitaryEvol.m
```

_LidnbladEvol.m_ - Creates the operator that when exponentialized gives the time evolution operator.

_dmUnitaryEvol.m_ - Gets a density matrix (rho) and an arbitrary operator in Hilbert space and evolve the density matrix.

## Plot
This folder contains very simple plotting functions that help visualize 1-qubit states on the bloch sphere or show the tomograaphy map of a general quantum state. The examples provided contain sample figures of these.

## References:
[1] Breuer, Heinz-Peter; Petruccione, F. (2002). The Theory of Open Quantum Systems. Oxford University Press. ISBN 978-0-1985-2063-4.
 Weinberg, Steven (2014). "Quantum Mechanics Without State Vectors". Phys. Rev. A. 90 (4): 042102
