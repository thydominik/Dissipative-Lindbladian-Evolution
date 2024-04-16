function [SystemGate] = QGateSystemInit(GateArray, GateOrder)
%QGATESYSTEMINIT: Takes an array, that contains the qubit gates that are
%used for the whole system (identity gates included), and creates a system
%wide gate that acts on the whole system state.

% NOTE: Not recommended to use. Slow.

% INPUT ----------------------------------------------
% GateArray - [array; struct()] Contains all the gates that are used
% GateOrder - [array; int] Contains the order of the gates
% INPUT ----------------------------------------------

Effective_NoQ   = length(GateArray);
NoQ             = length(GateOrder);

if length(GateOrder) ~= length(GateArray)
    error('Number of gates and qubit order is not correct')
end

SystemGate.Type     = 'Quantum System Gate';
SystemGate.Info     = 'Series of 1,2 or 3 qubit gates';
SystemGate.QubitNum = Effective_NoQ;

for i = 1:Effective_NoQ
    index = find(GateOrder == i, 1);
    if i == 1
        SystemOperator = GateArray(index).Operator;
    else
        SystemOperator = kron(SystemOperator, GateArray(index).Operator);
    end
end

SystemGate.Operator = SystemOperator;
end

