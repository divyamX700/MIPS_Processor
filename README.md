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

## Instruction Set Architecture (ISA)

The processor supports three main instruction formats as defined by the MIPS specification[^4][^5][^10]:

### R-Type Instructions

Format: `opcode (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6)`

- **ADD**: `add $rd, $rs, $rt` - Addition with overflow detection
- **SUB**: `sub $rd, $rs, $rt` - Subtraction with overflow detection
- **AND**: `and $rd, $rs, $rt` - Bitwise AND operation
- **OR**: `or $rd, $rs, $rt` - Bitwise OR operation
- **XOR**: `xor $rd, $rs, $rt` - Bitwise XOR operation
- **NOR**: `nor $rd, $rs, $rt` - Bitwise NOR operation
- **SLT**: `slt $rd, $rs, $rt` - Set less than comparison
- **SLL**: `sll $rd, $rt, shamt` - Shift left logical
- **SRL**: `srl $rd, $rt, shamt` - Shift right logical
- **SRA**: `sra $rd, $rt, shamt` - Shift right arithmetic
- **JR**: `jr $rs` - Jump register

### I-Type Instructions

Format: `opcode (6) | rs (5) | rt (5) | immediate (16)`

- **LW**: `lw $rt, offset($rs)` - Load word from memory
- **SW**: `sw $rt, offset($rs)` - Store word to memory
- **BEQ**: `beq $rs, $rt, label` - Branch if equal
- **BNE**: `bne $rs, $rt, label` - Branch if not equal
- **ADDI**: `addi $rt, $rs, immediate` - Add immediate
- **SLTI**: `slti $rt, $rs, immediate` - Set less than immediate
- **ANDI**: `andi $rt, $rs, immediate` - AND immediate
- **ORI**: `ori $rt, $rs, immediate` - OR immediate
- **XORI**: `xori $rt, $rs, immediate` - XOR immediate
- **LUI**: `lui $rt, immediate` - Load upper immediate

### J-Type Instructions

Format: `opcode (6) | address (26)`

- **J**: `j address` - Unconditional jump
- **JAL**: `jal address` - Jump and link (for function calls)

## Datapath Design

The processor implements a single-cycle datapath where all instruction execution occurs within one clock cycle[^1][^24]. The datapath includes:

### Control Signals

The control unit generates the following signals based on instruction decoding[^1][^8]:

- **RegDst**: Selects destination register (rd vs rt)
- **RegWrite**: Enables writing to register file
- **ALUSrc**: Selects ALU input source (register vs immediate)
- **MemRead**: Enables data memory read
- **MemWrite**: Enables data memory write
- **MemToReg**: Selects register write data source
- **Branch**: Enables conditional branching
- **Jump**: Enables unconditional jumping
- **ALUOp**: Determines ALU operation type

### ALU Control

The ALU control unit determines the specific operation to be performed based on the instruction type and function code[^31][^32]:

- Generates 4-bit ALU control signals
- Supports arithmetic operations (ADD, SUB)
- Supports logical operations (AND, OR, XOR, NOR)
- Supports comparison operations (SLT)
- Handles shift operations (SLL, SRL, SRA)

## Project Structure

```
MIPS_Processor/
├── src/
│   ├── alu.v                 # Arithmetic Logic Unit
│   ├── alu_control.v         # ALU Control Unit
│   ├── control_unit.v        # Main Control Unit
│   ├── data_memory.v         # Data Memory Module
│   ├── instruction_memory.v  # Instruction Memory Module
│   ├── register_file.v       # 32-Register File
│   ├── program_counter.v     # Program Counter
│   ├── mips_processor.v      # Top-level Processor Module
│   └── sign_extend.v         # Sign Extension Unit
├── testbench/
│   ├── tb_mips_processor.v   # Main Testbench
│   ├── tb_alu.v              # ALU Testbench
│   └── test_programs/        # Assembly Test Programs
├── docs/
│   ├── datapath_diagram.png  # Processor Datapath
│   ├── control_signals.md    # Control Signal Documentation
│   └── instruction_set.md    # Supported Instructions
├── simulation/
│   ├── compile.sh            # Compilation Script
│   ├── run_sim.sh           # Simulation Script
│   └── waveforms/           # Generated Waveforms
└── README.md
```

## Setup and Installation

### Prerequisites

Ensure you have a Verilog simulator installed. The recommended tools are:

- **Icarus Verilog**: For compilation and simulation
- **GTKWave**: For waveform viewing and analysis
- **ModelSim**: Alternative professional simulator (optional)

### Installation Instructions

#### On Ubuntu/Debian:

```bash
sudo apt update
sudo apt install iverilog gtkwave
```
