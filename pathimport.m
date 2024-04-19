function pathimport
%PATHIMPORT This function includes all the necessary functions paths. This only includes the core folder and it's subfolders


addpath("core\")

% Adding crcuit elements to the path
addpath("core\circuit_elements\dissipator_gates\")
addpath("core\circuit_elements\measurement\")
addpath("core\circuit_elements\operators\")
addpath("core\circuit_elements\quantum_gates\")

disp("Circuit Elements were added.")

% Adding common_functions to the path
addpath("core\common_functions\")

disp("Core Common Function were added.")

% Misc
% addpath("core\misc\")

% disp("Core Misc were added.")

% Adding plots to the path
addpath("core\plot\")

disp("Core plotting elements were added.")

% Adding quantum_states to the path
addpath("core\quatum_state\quantum_state_methods\")
addpath("core\quatum_state\qubits\")
addpath("core\quatum_state\quantum_state_common_functions\")

disp("Core Quantum State functions were added.")

% Adding tim_evolution to the path
addpath("core\time_evolution\")

disp("Core Time evolution were added.")

end

