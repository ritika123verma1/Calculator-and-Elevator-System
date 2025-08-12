# Calculator-and-Elevator-System


## Overview
This project integrates **two independent digital systems**—a **three-floor Elevator Controller** and a **4-bit Scientific Calculator**—into a single Verilog-based design. 
The aim was to practice **Finite State Machine (FSM) design**, arithmetic logic implementation, and functional verification through simulation.  
The complete project was **tested entirely using Verilog testbenches** in a simulation environment and i tried to check each possible case of  it , without any physical hardware deployment.

---

##  Elevator Controller
The elevator system is designed as a **5-state Finite State Machine (FSM)** with the following states:
- `IDLE` – Elevator is stationary at the current floor  
- `MOVING_UP` – Elevator moves towards a higher floor  
- `MOVING_DOWN` – Elevator moves towards a lower floor  
- `DOOR_OPEN` – Doors open for passengers  
- `DOOR_CLOSED` – Doors close before movement or after boarding/alighting  
- `EMERGENCY_STOP` – Immediate stop in case of faults or safety triggers( i thought about that but not used in the code)

The controller uses **floor navigation logic** to move between floors, **door LED indication** for visual feedback, and a **state debug LED** for simulation observation.

---

## Scientific Calculator
The calculator module accepts two **4-bit inputs** (`0–15`) and produces an **8-bit result** to prevent overflow during multiplication or squaring. It supports the following operations via a 3-bit opcode:
- Addition (`ADD`)
- Subtraction (`SUB`)
- Multiplication (`MUL`)
- Division (`DIV`) – with divide-by-zero detection
- Modulus (`MOD`) – with divide-by-zero detection
- Square (`SQRE`)
- Square Root (`SQRT`) – with integer approximation

Error handling is implemented through an `error_flag` signal to indicate invalid inputs or operations.

---

##  Testing & Verification
No hardware implementation was performed .  
The design was **verified entirely through simulation** using self-checking Verilog testbenches:
- **Functional Tests** – Standard operation checks for all valid inputs  
- **Edge Cases** – Division by zero, subtraction leading to negatives, square root of zero  
- **State Transitions** – Verifying correct FSM behavior in the elevator controller  

Simulation outputs were observed in the console and verified using waveform viewers such as GTKWave.

---

##  Design Challenges
- Mapping real-world elevator behavior into a **clear FSM structure** but there were many more states that could have been used like bell ring etc.but could used only a few.
- Managing **overflow control** in the calculator while keeping the design minimal
- the verification of valid inputs means number should be positive during squareroot operation and all.
- Implementing **error detection logic** without affecting normal operations
- Synchronizing operations with button press simulation in the testbench

---

##  Learning Outcomes
Through this project, we gained experience in:
- **Finite State Machine design** for real-world systems
- **Parameterized Verilog coding** for readability and scalability
- **Arithmetic logic implementation** with error handling
- **Testbench creation** for complete functional coverage without hardware
- **Simulation waveform analysis** for debugging

---

