function [Q1_Clifford_Gates, Q2_Clifford_Gates, Q1_labels, Q2_labels] = CliffordGates()
% This function generates all 1 and 2 qubit clifford gates
% There are 24 1-qubit and 11520 2-qubit Clifford gates, so the generation is fairly fast.
% example for all 1 qubit clifford gates and their labels: [Q1_G, ~, Q1_L, ~] = CliffordGates()

[Q1_Clifford_Gates, Q1_labels] = Generate_All_1_Qubit_Clifford_Gates();
[Q2_Clifford_Gates, Q2_labels] = Generate_All_2_Qubit_Clifford_Gates();
end