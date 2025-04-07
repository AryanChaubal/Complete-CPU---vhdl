# Complete-CPU---vhdl

A lightweight, modular 32-bit CPU built entirely in VHDL — complete with a datapath, control unit, instruction memory, and a custom reset sequence. Designed for simulation and potential FPGA deployment.

---

## 🚀 Overview

This project is a complete implementation of a simple RISC-style CPU architecture, created from the ground up using VHDL. It supports a basic instruction set, synchronous reset behavior, and instruction execution via a cleanly wired datapath and control logic.

Perfect for hardware experimentation, simulation, and running custom assembly programs.

---

## 🧩 Architecture Highlights

The CPU is built around a rich set of low-level hardware components, each designed for flexibility and reusability.

### 🔁 Registers & State Control

- `register32`: 32-bit general-purpose register with load, clear, and clock control  
- `pc`: Program Counter with increment, load, and clear support  
- **Instruction Register**: 32-bit IR to hold the currently executing instruction  
- **Status Flags**:
  - `Z`: Zero flag
  - `C`: Carry-out flag

---

### 🧠 ALU & Arithmetic Modules

- `alu`: Performs core arithmetic/logic operations (ADD, SUB, AND, OR, etc.)
- `LZE`: Logical Zero Extender (extends immediate fields to 32 bits)
- `UZE`: Unsigned Zero Extender
- `RED`: Reduces 32-bit values to 8-bit addresses for memory indexing

---

### 📥 Multiplexers

- `mux2to1`: 2-input MUX used for:
  - Register A input (bus vs. LZE)
  - Register B input (bus vs. LZE)
  - Register selection (A vs. B)
  - IM_MUX1 (Reg_A vs. UZE)
- `mux4to1`: 4-input MUX used for:
  - IM_MUX2: Choose between register, LZE, fixed values
  - Final data bus selection: DATA_IN, memory, ALU output, or default zero

---

### 💾 Memory Module

- `data_mem`: 256-word RAM
  - `EN` and `WEN` controlled
  - Input address via `RED` (reduced from IR)
  - Data lines fully exposed for easy debugging

---

### 🔗 Signal Buses

- `DATA_BUS`: Core bus for inter-module data transfer  
- `ADDR_OUT`: Instruction address output  
- `DATA_IN`: External data input  
- `MEM_IN`, `MEM_OUT`: Interfaces for memory write and read  
- `MEM_ADDR`: 8-bit address line derived from instruction reduction

---

## 💻 Features

- 32-bit architecture
- Synchronous reset with multi-cycle hold
- Modular VHDL code structure
- Instruction memory with customizable programs
- Supports arithmetic, load, and branch operations
- Easy to simulate and verify using waveform tools

---

## 🧪 Simulation & Testing

The design is fully simulated using timing waveforms. You can observe:
- Proper reset behavior
- Instruction fetch and decode
- Correct ALU operation
- Branch and jump execution

Use your favorite VHDL simulation environment (ModelSim, Quartus, GHDL, etc.) to test and visualize CPU execution.
