Quantum Computing — From States to Systems

This folder is where quantum mechanics becomes programmable.

Up to this point, quantum theory explained how nature behaves.
Here, those same rules are turned into controllable systems: qubits, qudits, registers, gates, measurements, and algorithms.

Core theme:
A quantum computer is not magic.
It is controlled interference.

⸻

What This Folder Represents

This section demonstrates three critical ideas:
	1.	A quantum state is a vector
	2.	Operations are unitary transformations
	3.	Measurement converts probability into classical information

Every file here is designed to be interactive, visual, and state-faithful — no fake shortcuts.

⸻

File Order & Conceptual Flow

1. QuantumSphere.html

The Single Qubit

This file introduces the Bloch sphere representation.

You can:
	•	Apply gates (X, Y, Z, H, S, T)
	•	Rotate the quantum state in 3D
	•	Watch probabilities update in real time

Key takeaway:

A qubit is not 0 or 1 — it is a direction in Hilbert space.

￼

⸻

2. TwoQubitSpheres.html

Entanglement Begins

This simulation expands from one qubit to two qubits.

You see:
	•	Individual Bloch vectors collapse when entangled
	•	Joint probabilities emerge instead
	•	Multi-qubit gates (CNOT, SWAP) create non-classical correlations

Key takeaway:

Entangled qubits do not have independent states.

￼

⸻

3. QuditPlayground.html

Beyond Binary

This file generalizes qubits to qudits (d-dimensional systems).

You can:
	•	Switch dimensionality (qutrits, ququarts, etc.)
	•	Apply generalized X, Z, and Fourier gates
	•	Observe phase and probability evolution per level

Key takeaway:

Quantum computing is not limited to base-2.

￼

⸻

4. CollapsingQubits.html

Measurement at Scale

This simulation shows a large quantum register undergoing collapse.

You see:
	•	100 qubits in superposition
	•	Measurement producing a classical bitstring
	•	Statistical distributions emerging across runs

Key takeaway:

Measurement is where quantum advantage becomes classical data.

￼

⸻

5. QubitCalculator.html

Amplitude Mathematics

This tool focuses on normalization and probability.

You can:
	•	Input amplitudes α and β
	•	Enforce |α|² + |β|² = 1
	•	Visually see probability redistribution

Key takeaway:

Quantum states must conserve total probability.

￼

⸻

6. QuantumSearchTool.html

Quantum Advantage in Action

This visualization compares classical vs quantum search.

You see:
	•	Brute force search scaling linearly
	•	Grover-style amplitude amplification
	•	Probability concentrating on the target

Key takeaway:

Quantum speedup comes from interference, not guessing.

￼

⸻

7. QuantumEnvironment.html

Many-Body Quantum Systems

This file introduces emergent behavior.

You see:
	•	Qubits moving freely
	•	Dynamic entanglement networks
	•	Global collapse freezing the system

Key takeaway:

Quantum systems are environments, not isolated points.

￼

⸻

8. TenQuditsWithTenDimensions.html

High-Dimensional Quantum State Spaces

This visualization pushes beyond standard models.

You see:
	•	10 qudits, each with 10 internal dimensions
	•	Phase, magnitude, and normalization preserved
	•	Complex internal evolution visualized geometrically

Key takeaway:

Quantum complexity grows exponentially — visually and mathematically.

￼

⸻

9. QuantumSearchSimulator.html

Algorithms, Not Just Gates

This file simulates Grover’s Algorithm step by step.

You see:
	•	Oracle phase inversion
	•	Diffusion (inversion about the mean)
	•	Probability amplification over iterations

Key takeaway:

Quantum algorithms shape probability landscapes.
⸻

10. CHSHBellTest.html

This is the most important proof in the entire portfolio.
	•	Implements the CHSH Bell inequality
	•	Compares:
	•	Quantum entanglement
	•	Classical hidden-variable models
	•	Random noise
	•	Computes the Bell parameter S

Results:
	•	Classical: |S| ≤ 2
	•	Quantum: |S| → 2√2 ≈ 2.828

This proves entanglement cannot be reproduced classically.

Without this file, quantum advantage has no justification.







⸻

How This Folder Connects Backward

From Quantum Theory, we had:
	•	Wave functions
	•	Superposition
	•	Collapse

This folder answers:

“What happens when we control those rules?”

⸻

How This Folder Connects Forward

This section sets the stage for:
	•	Quantum AI agents
	•	Reinforcement learning in quantum state spaces
	•	Hybrid classical-quantum systems
	•	Decision-making under superposition

➡️ The next folder turns quantum systems into learning agents.