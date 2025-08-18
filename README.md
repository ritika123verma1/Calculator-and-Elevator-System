# 4-bit Scientific Calculator (Verilog)

## Overview
This project implements a **4-bit Scientific Calculator** in Verilog.  
The calculator accepts two **4-bit inputs** (`0–15`) and produces an **8-bit result** to prevent overflow during multiplication or squaring.  
It was designed to practice **arithmetic logic implementation** and was verified entirely through simulation using testbenches.

---

## Features
The calculator supports the following operations via a 3-bit opcode:
- **Addition (ADD)**
- **Subtraction (SUB)**
- **Multiplication (MUL)**
- **Division (DIV)** – with divide-by-zero detection
- **Modulus (MOD)** – with divide-by-zero detection
- **Square (SQRE)**
- **Square Root (SQRT)** – with integer approximation

Error handling is implemented through an `error_flag` signal to indicate invalid inputs or operations.

---

## Testing & Verification
The design was **verified through simulation only** (no hardware).  
- **Functional Tests** – Checked all valid arithmetic operations  
- **Edge Cases** – Division by zero, subtraction leading to negatives, square root of zero  
- Simulation results were observed in **GTKWave** and through console outputs.  

---

## Design Challenges
- Managing **overflow** while keeping the design minimal  
- Error detection for divide-by-zero and invalid square root inputs  
- Ensuring correct handling of subtraction for negative results  

---

## Learning Outcomes
- Improved understanding of **arithmetic logic design** in Verilog  
- Gained experience in **parameterized coding** and error handling  
- Learned to create **self-checking Verilog testbenches**


---

