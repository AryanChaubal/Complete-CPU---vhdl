# Complete-CPU---vhdl

A lightweight, modular 32-bit CPU built entirely in VHDL — complete with a datapath, control unit, instruction memory, and a custom reset sequence. Designed for simulation and potential FPGA deployment.

---

## 🚀 Overview

This project is a complete implementation of a simple RISC-style CPU architecture, created from the ground up using VHDL. It supports a basic instruction set, synchronous reset behavior, and instruction execution via a cleanly wired datapath and control logic.

Perfect for hardware experimentation, simulation, and running custom assembly programs.

---

## 🧩 Components

### ✅ Reset Circuit
A synchronous reset module ensures stable startup by holding the CPU in an initialization state for a fixed number of clock cycles. This allows system signals to stabilize before instruction execution begins.

### ✅ Datapath
Handles the movement and processing of data across registers, the ALU, and memory interfaces. Fully modular and easy to expand.

### ✅ Control Unit
Finite State Machine (FSM)-based controller that manages CPU operation cycle-by-cycle based on opcode decoding.

### ✅ Instruction Memory
Instruction memory is configured via a `.mif` file (Memory Initialization File), which allows easy testing of different programs in simulation.

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
