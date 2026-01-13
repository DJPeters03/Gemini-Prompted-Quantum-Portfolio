# Quantum Algorithms in Q#

This folder contains **three foundational quantum algorithms**, each implemented in **pure Q#**.  
These files are intentionally written in a way that **cannot be replicated classically**, highlighting true quantum advantage and core quantum-mechanical principles.

Together, they represent a progression from **algorithmic speedup**, to **quantum simulation**, to **cryptographic disruption**.

---

## 📁 Files Overview

### 1. `ShorsGemini.qs`
**Quantum Factoring (Shor’s Algorithm)**

This file implements a version of **Shor’s Algorithm**, the landmark quantum algorithm that factors large integers exponentially faster than classical methods.

#### Concepts Demonstrated
- Quantum Period Finding
- Quantum Fourier Transform (QFT)
- Interference-based computation
- Exponential speedup over classical factoring

#### Why It Matters
Shor’s Algorithm proves that widely-used cryptographic systems (like RSA) are vulnerable to quantum computers. This file represents **the most famous proof of quantum advantage**.

#### Key Takeaway
> Quantum computers don’t “guess” factors — they exploit wave interference to reveal hidden structure.

---

### 2. `GroversSearch.qs`
**Amplitude Amplification (Grover’s Algorithm)**

This file implements **Grover’s Search Algorithm**, which searches an unsorted space of size `N` in **O(√N)** time instead of O(N).

#### Concepts Demonstrated
- Oracle-based computation
- Amplitude amplification
- Quantum state rotation
- Measurement probability control

#### Why It Matters
Grover’s Algorithm shows that **any brute-force search problem** gains a quadratic speedup on a quantum computer.

#### Key Takeaway
> Quantum algorithms don’t check answers faster — they make the *right answer louder*.

---

### 3. `HamiltonSimulation.qs`
**Quantum System Evolution (Hamiltonian Simulation)**

This file simulates the **time evolution of a quantum system** under a given Hamiltonian, using unitary operators.

#### Concepts Demonstrated
- Hamiltonians as generators of time evolution
- Unitary dynamics
- Quantum simulation of physical systems
- Foundation of quantum chemistry and materials science

#### Why It Matters
Simulating quantum systems is **infeasible classically**, but natural for quantum hardware. This is the backbone of:
- Quantum chemistry
- Drug discovery
- Materials science
- Condensed matter physics

#### Key Takeaway
> Quantum computers don’t approximate quantum systems — they *are* quantum systems.

---

## 🧠 Conceptual Progression

| File | Core Idea | Quantum Advantage |
|----|----|----|
| `GroversSearch.qs` | Faster search | Quadratic speedup |
| `HamiltonSimulation.qs` | Physical simulation | Exponential classical savings |
| `ShorsGemini.qs` | Cryptographic breaking | Exponential speedup |

---

## 🛠️ Why Q#

All implementations are written in **Q#**, not JavaScript or Python, because:
- These algorithms require **true qubit semantics**
- Superposition, entanglement, and unitaries must be native
- Measurement and collapse are first-class concepts

This folder represents **non-negotiable quantum code**.

---

## 🎯 Intended Audience
- Computer scientists exploring quantum algorithms
- Recruiters evaluating quantum programming literacy
- Students transitioning from classical to quantum thinking

---

## 📌 Summary

These three files together demonstrate:
- **What quantum computers do better**
- **Why quantum programming is fundamentally different**
- **How quantum mechanics becomes computation**

This is not theoretical quantum — this is **executable quantum logic**.

