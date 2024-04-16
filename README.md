# Dissipative-Lindbladian-Exact-Time-Evolution

A Matlab repository that contains the basic elements for exact Lindbladian time-evolution on qubits/two-level systems.

## Introduction
This MATLAB package provides a robust implementation for exact time evolution using the Lindbladian formalism [1]. It offers a versatile toolset for simulating the dynamics of open quantum systems, accounting for both unitary evolution and dissipative processes. Dissipation can be implemented as discrete quantum gates, jump operators with arbitrary dissipation rates or as dissipative gates, where we treat the gate and jump operator as a Hamiltonian. 

The main body of the code is located in the _core_ folder of the repository. In order to use the package call
```
pathimport.m
```
function
## Circuit elements

### Quantum gates
List of predefined quantum gates
### Measurement
### Dissipators
    
## Quantum states

## Time evolution

## Examples

This repository contains three example scripts. These scripts contain a step-by-step solution to three slightly different problems. 

## References:
[1] Breuer, Heinz-Peter; Petruccione, F. (2002). The Theory of Open Quantum Systems. Oxford University Press. ISBN 978-0-1985-2063-4.
 Weinberg, Steven (2014). "Quantum Mechanics Without State Vectors". Phys. Rev. A. 90 (4): 042102
