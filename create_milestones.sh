#!/bin/bash
# Script to create GitHub milestones for Dissipative-Lindbladian-Evolution project
# Prerequisites: GitHub CLI (gh) must be installed and authenticated
# Run: chmod +x create_milestones.sh && ./create_milestones.sh

REPO="thydominik/Dissipative-Lindbladian-Evolution"

echo "Creating milestones for $REPO..."
echo ""

# Julia Implementation Milestones

echo "Creating Julia Milestone 4: Dissipation Mechanisms..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Julia] Dissipation Mechanisms" \
  -f description="Implement all dissipation mechanisms including local dissipators, dissipator gates, dissipative quantum gates, state-dissipator interactions, and time evolution with dissipation. Includes comprehensive tests." \
  -f due_on="2026-03-12T23:59:59Z" \
  -f state="open"

echo "Creating Julia Milestone 5: Measurements & Analysis..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Julia] Measurements & Analysis" \
  -f description="Implement fidelity calculations, Von Neumann entropy, hard measurements (projective), measurement statistics, and comprehensive tests for all measurement operations." \
  -f due_on="2026-03-26T23:59:59Z" \
  -f state="open"

echo "Creating Julia Milestone 6: Visualization & Documentation..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Julia] Visualization & Documentation" \
  -f description="Bloch sphere plotting (Plots.jl/Makie.jl), tomography visualization, API documentation (Documenter.jl), 3-5 tutorial examples, and performance benchmarks vs MATLAB." \
  -f due_on="2026-04-09T23:59:59Z" \
  -f state="open"

echo ""
echo "Julia milestones created!"
echo ""

# Python Implementation Milestones

echo "Creating Python Milestone 1: Package Setup..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Python] Package Setup" \
  -f description="Create package structure (src/, tests/, docs/), setup pyproject.toml and setup.py, configure pytest and coverage, implement CI/CD pipeline (GitHub Actions), and basic NumPy/SciPy integration." \
  -f due_on="2026-04-23T23:59:59Z" \
  -f state="open"

echo "Creating Python Milestone 2: Core Classes & Utilities..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Python] Core Classes & Utilities" \
  -f description="Implement QuantumState class, QuantumGate class, Dissipator class, basis transformation utilities, tensor operations, matrix utilities (commutators, anticommutators), and unit tests." \
  -f due_on="2026-05-07T23:59:59Z" \
  -f state="open"

echo "Creating Python Milestone 3: Gate Library..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Python] Gate Library" \
  -f description="Implement single-qubit gates (all variants), two-qubit gates, parametrized gates, Clifford generators, random unitary generation, gate composition, and tests for all gates." \
  -f due_on="2026-05-28T23:59:59Z" \
  -f state="open"

echo "Creating Python Milestone 4: State Operations..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Python] State Operations" \
  -f description="State initialization methods, density matrix operations, state evolution (unitary), partial trace implementation, state combination, and tests for state manipulation." \
  -f due_on="2026-06-11T23:59:59Z" \
  -f state="open"

echo "Creating Python Milestone 5: Dissipation & Time Evolution..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Python] Dissipation & Time Evolution" \
  -f description="Lindblad master equation solver, dissipator actions on states, time evolution with dissipation, multiple dissipation channels, numerical integration options, and tests for dissipative evolution." \
  -f due_on="2026-07-02T23:59:59Z" \
  -f state="open"

echo "Creating Python Milestone 6: Measurements & Analysis..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Python] Measurements & Analysis" \
  -f description="Fidelity and trace distance, entropy calculations, projective measurements, expectation values, and tests for measurements." \
  -f due_on="2026-07-16T23:59:59Z" \
  -f state="open"

echo "Creating Python Milestone 7: Visualization & Examples..."
gh api repos/$REPO/milestones \
  -X POST \
  -f title="[Python] Visualization & Examples" \
  -f description="Bloch sphere (Matplotlib), density matrix visualization, tomography plots, 5+ Jupyter notebook examples, Sphinx documentation, and ReadTheDocs integration." \
  -f due_on="2026-07-30T23:59:59Z" \
  -f state="open"

echo ""
echo "Python milestones created!"
echo ""
echo "✅ All milestones created successfully!"
echo ""
echo "View milestones at: https://github.com/$REPO/milestones"
echo ""
echo "You can now delete this script: rm create_milestones.sh"