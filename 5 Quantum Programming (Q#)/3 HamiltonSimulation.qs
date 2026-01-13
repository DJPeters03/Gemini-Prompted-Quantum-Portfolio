namespace HamiltonianSimulator {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation Main() : Unit {
        // --- Simulation Parameters ---
        let nQubits = 4;           // 4-site spin chain
        let time = 1.0;            // Total simulation time
        let dt = 0.1;              // Time step size (smaller = more accurate)
        let steps = Round(time / dt);
        
        // Physics Parameters
        let J = 1.0; // Coupling strength (ferromagnetic)
        let h = 1.5; // Transverse field strength (strong field)

        Message($"--- Hamiltonian Simulator: Ising Model ---");
        Message($"Qubits: {nQubits}, J: {J}, h: {h}, Time: {time}");
        Message("Simulating dynamics...\n");

        // We run the simulation multiple times to get an average measurement (Magnetization)
        let samples = 100;
        mutable totalMagnetization = 0.0;

        for _ in 1 .. samples {
            let mag = RunSimulation(nQubits, steps, dt, J, h);
            set totalMagnetization += mag;
        }

        let averageMag = totalMagnetization / IntAsDouble(samples);
        Message($"Average Magnetization <Z> after t={time}: {averageMag}");
        Message("(If <Z> < 1.0, the transverse field 'h' has successfully flipped spins)");
    }

    /// # Summary
    /// Evolves the state |00..0> under H for time 'steps * dt' and measures magnetization.
    operation RunSimulation(nQubits : Int, steps : Int, dt : Double, J : Double, h : Double) : Double {
        use qubits = Qubit[nQubits];

        // 1. Initialize State: |00...0> (All spins UP)
        // No gates needed, qubits start in |0>.

        // 2. Time Evolution (Trotter Loop)
        for _ in 1 .. steps {
            ApplyTrotterStep(qubits, dt, J, h);
        }

        // 3. Measure Magnetization
        // We calculate the average Z value of the chain.
        // Up (|0>) = +1, Down (|1>) = -1.
        mutable sumZ = 0.0;
        
        for q in qubits {
            let result = M(q);
            if (result == Zero) {
                set sumZ += 1.0;
            } else {
                set sumZ += -1.0;
            }
        }

        ResetAll(qubits);

        // Return average magnetization per site
        return sumZ / IntAsDouble(nQubits);
    }

    /// # Summary
    /// Performs one discrete time step of evolution: e^{-i H dt}
    /// Using First-Order Trotter: e^{-i(A+B)t} approx e^{-iAt} e^{-iBt}
    operation ApplyTrotterStep(qubits : Qubit[], dt : Double, J : Double, h : Double) : Unit {
        let n = Length(qubits);

        // A. Apply the Interaction Term: -J * sum(Z_i Z_{i+1})
        // We use the Exp gate: Exp([Paulis], theta, qubits) applies e^{-i theta P}
        // Here P = Z Z, and coefficient is -J. So theta = -J * dt.
        for i in 0 .. n - 2 {
            // Evolves e^{-i (-J) Z_i Z_{i+1} dt}
            Exp([PauliZ, PauliZ], -1.0 * J * dt, [qubits[i], qubits[i + 1]]);
        }
        
        // Periodic Boundary Condition (Optional: Connect last to first)
        // Exp([PauliZ, PauliZ], -1.0 * J * dt, [qubits[n-1], qubits[0]]);

        // B. Apply the Transverse Field Term: -h * sum(X_i)
        // Evolves e^{-i (-h) X_i dt}
        for i in 0 .. n - 1 {
            Exp([PauliX], -1.0 * h * dt, [qubits[i]]);
        }
    }
}