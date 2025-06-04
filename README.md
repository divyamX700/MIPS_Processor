# MIPS Processor Implementation

This project features a comprehensive Verilog implementation of a MIPS (Microprocessor without Interlocked Pipeline Stages) processor, supporting a subset of the MIPS instruction set architecture. The implementation is designed for educational purposes, simulation, and understanding of computer architecture fundamentals[^2][^4].

MIPS is a Reduced Instruction Set Computer (RISC) architecture that has been widely used in academic settings and embedded systems due to its simplicity and well-defined instruction set[^3][^4]. This implementation provides a complete single-cycle MIPS processor with support for arithmetic, logical, memory access, and control flow instructions.

## Architecture Overview

The MIPS processor follows the classic RISC design principles with a Harvard architecture featuring separate instruction and data memories[^8][^9]. The processor implements a single-cycle datapath where each instruction is executed in one clock cycle, making it easier to understand and debug compared to pipelined implementations[^1][^2].

### Key Components

**Control Unit**: Generates control signals based on the instruction opcode and function fields to coordinate datapath operations[^1][^8]. The control unit determines register destinations, ALU operations, memory access patterns, and branching conditions.

**Arithmetic Logic Unit (ALU)**: Performs arithmetic and logical operations including addition, subtraction, AND, OR, XOR, NOR, and set-less-than operations[^5][^8]. The ALU also generates flag signals for conditional branching.

**Register File**: Contains 32 general-purpose registers, each 32 bits wide, following the MIPS register convention[^5][^17]. Register $0 is hardwired to zero, and other registers serve specific purposes like stack pointer ($sp) and return address (\$ra).

**Memory System**: Consists of separate instruction and data memories implementing the Harvard architecture[^8][^9]. The instruction memory stores the program code while data memory handles load and store operations.

**Program Counter (PC)**: Manages the instruction fetch sequence and supports branching and jumping operations[^4]. The PC is updated each clock cycle to point to the next instruction to be executed.
