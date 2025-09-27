#  Advanced Digital Design Project – 6-bit Comparator (Signed/Unsigned)

## 📌 Overview
This project was developed as part of the **Advanced Digital Design (ENCS3310)** course at **Birzeit University**.  
The aim was to design a **6-bit comparator** in **Verilog (structural design)** that can compare two binary numbers (A and B).  
The comparator determines if A is **equal**, **greater**, or **smaller** than B.  
A selection input (S) allows switching between **signed** and **unsigned** comparisons.  

The circuit was built using **basic gates with fixed delays**, with added **registers** to make the design synchronous and allow clocked operation.  
We also calculated the **maximum latency** and **maximum clock frequency** supported by the circuit.  

---

## 📂 Project Structure
digital-comparator/  
├── Comparator.v      — Structural Verilog design of the 6-bit comparator  
├── block.bde         — Block diagram file (schematic)  
├── Report.pdf        — Full project report with design details, theory, and results  
└── README.md         — Project documentation  

---

## ⚙️ Features
- **Unsigned Comparator**: Compares two 6-bit unsigned numbers using AND, OR, XOR, and NOT gates.  
- **Signed Comparator**: Compares signed numbers using **subtraction** (2’s complement) and logical gates.  
- **Selection Input (S)**:  
  - `S=0` → Unsigned comparison  
  - `S=1` → Signed comparison  
- **Synchronous Operation**:  
  - Registers added at inputs and outputs using D flip-flops.  
  - Controlled by a clock signal for reliable timing.  
- **Error Detection**: Testbench detects incorrect outputs by comparing actual results with expected values.  
- **Latency & Clock Frequency**:  
  - Maximum latency = **110 ns**  
  - Maximum supported clock frequency ≈ **9.09 MHz**

---

## 📊 Simulation & Results
- **Testbench** checked **all possible combinations** of inputs (6-bit A, 6-bit B, and 1-bit S).  
- Outputs: **Equal (EQ), Greater (GT), Less Than (LT)**.  
- Simulation waveforms confirmed correctness of signed/unsigned operations.  
- An **intentional error** (replacing an AND with NAND) was injected and successfully detected.  

### Example Behavior:
Input A = `001011` (decimal 11)  
Input B = `001001` (decimal 9)  
- Unsigned comparison → GT = 1, EQ = 0, LT = 0  
- Signed comparison   → GT = 1, EQ = 0, LT = 0  

---

## 🚀 How to Run
1. Open `Comparator.v` in a Verilog simulator (ModelSim, Xilinx ISE, or Vivado).  
2. Add `block.bde` if schematic/block representation is supported.  
3. Run the simulation using the provided **testbench**.  
4. Check waveforms to verify outputs: **EQ, GT, LT**.  

---

## 📈 Future Work
- Extend design to **8-bit or 16-bit inputs** using Verilog parameters.  
- Optimize design with **advanced gates** for reduced delay and improved performance.  
- Integrate into larger **digital systems** (sorting networks, ALUs).  

---

## 👩‍🎓 Author
**Rawand Radi**  
Faculty of Engineering & Technology – Birzeit University  
Course: Advanced Digital Design (ENCS3310)  
Instructor: Elias Khalil  
Date: 23 Dec 2024
