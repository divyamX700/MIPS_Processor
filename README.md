# MIPS Processor Implementation

This project features a comprehensive Verilog implementation of a MIPS (Microprocessor without Interlocked Pipeline Stages) processor, supporting a subset of the MIPS instruction set architecture. The implementation is designed for educational purposes, simulation, and understanding of computer architecture fundamentals.

MIPS is a Reduced Instruction Set Computer (RISC) architecture that has been widely used in academic settings and embedded systems due to its simplicity and well-defined instruction set. This implementation provides a complete single-cycle MIPS processor with support for arithmetic, logical, memory access, and control flow instructions.

## Architecture Overview

The MIPS processor follows the classic RISC design principles with a Harvard architecture featuring separate instruction and data memories. The processor implements a single-cycle datapath where each instruction is executed in one clock cycle, making it easier to understand and debug compared to pipelined implementations.

### Key Components

**Control Unit**: Generates control signals based on the instruction opcode and function fields to coordinate datapath operations. The control unit determines register destinations, ALU operations, memory access patterns, and branching conditions.

**Arithmetic Logic Unit (ALU)**: Performs arithmetic and logical operations including addition, subtraction, AND, OR, XOR, NOR, and set-less-than operations. The ALU also generates flag signals for conditional branching.

**Register File**: Contains 32 general-purpose registers, each 32 bits wide, following the MIPS register convention. Register $0 is hardwired to zero, and other registers serve specific purposes like stack pointer ($sp) and return address (\$ra).

**Memory System**: Consists of separate instruction and data memories implementing the Harvard architecture. The instruction memory stores the program code while data memory handles load and store operations.

**Program Counter (PC)**: Manages the instruction fetch sequence and supports branching and jumping operations. The PC is updated each clock cycle to point to the next instruction to be executed.

## Instruction Set Architecture (ISA)

The processor supports three main instruction formats as defined by the MIPS specification:

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

The processor implements a single-cycle datapath where all instruction execution occurs within one clock cycle. The datapath includes:

### Control Signals

The control unit generates the following signals based on instruction decoding:

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

The ALU control unit determines the specific operation to be performed based on the instruction type and function code:

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

#### On macOS (with Homebrew):

```bash
brew install icarus-verilog
brew install --cask gtkwave
```


#### On Windows:

Download and install Icarus Verilog from the official website, or use WSL with Ubuntu instructions.

### Getting Started

1. **Clone the Repository**:

```bash
git clone https://github.com/lvl1ralts/MIPS_Processor.git
cd MIPS_Processor
```

2. **Compile the Design**:

```bash
chmod +x simulation/compile.sh
./simulation/compile.sh
```

3. **Run Simulation**:

```bash
chmod +x simulation/run_sim.sh
./simulation/run_sim.sh
```

4. **View Waveforms**:

```bash
gtkwave simulation/waveforms/mips_processor.vcd
```


## Usage Examples

### Basic Arithmetic Program

```assembly
# Test program: Calculate factorial of 4
addi $t0, $zero, 4    # Load 4 into $t0
addi $t1, $zero, 1    # Initialize result to 1
addi $t2, $zero, 1    # Initialize counter to 1

loop:
    slt $t3, $t2, $t0     # Check if counter < n
    beq $t3, $zero, done  # Branch if counter >= n
    add $t1, $t1, $t1     # result = result + result (simplified)
    addi $t2, $t2, 1      # counter = counter + 1
    j loop                # Jump back to loop

done:
    sw $t1, 0($zero)      # Store result in memory
```


### Memory Operations

```assembly
# Test program: Array manipulation
addi $t0, $zero, 10   # Array base address
addi $t1, $zero, 5    # First value
addi $t2, $zero, 15   # Second value

sw $t1, 0($t0)        # Store first value
sw $t2, 4($t0)        # Store second value
lw $t3, 0($t0)        # Load first value
lw $t4, 4($t0)        # Load second value
add $t5, $t3, $t4     # Add both values
```


## Testing and Verification

The project includes comprehensive test benches for verifying processor functionality:

### Unit Tests

- **ALU Test**: Verifies all arithmetic and logical operations
- **Control Unit Test**: Validates control signal generation
- **Register File Test**: Tests read/write operations
- **Memory Test**: Verifies instruction and data memory operations


### Integration Tests

- **Instruction Execution**: Tests complete instruction execution cycles
- **Branch and Jump**: Validates control flow operations
- **Data Hazard Handling**: Tests register dependencies
- **Memory Access**: Verifies load/store operations


### Performance Analysis

The single-cycle implementation provides predictable timing characteristics:

- **Clock Period**: Determined by the longest instruction path
- **CPI (Cycles Per Instruction)**: Always 1 for single-cycle design
- **Memory Access Time**: Impacts overall performance
- **Critical Path**: Typically through ALU and memory operations


## Design Features

### Educational Focus

This implementation emphasizes clarity and understanding over performance:

- Well-commented Verilog code with clear module boundaries
- Structural design approach for easy comprehension
- Complete datapath visibility for debugging
- Support for step-by-step execution tracing


### Modular Architecture

Each component is implemented as a separate module:

- **Hierarchical Design**: Top-down modular approach
- **Reusable Components**: Standard building blocks
- **Clear Interfaces**: Well-defined module ports
- **Testable Units**: Individual module verification


### Extensibility

The design supports future enhancements:

- **Pipeline Implementation**: Framework for multi-cycle design
- **Cache Integration**: Memory hierarchy support
- **Instruction Set Extensions**: Additional MIPS instructions
- **Performance Monitoring**: Instruction and cycle counting


## Simulation and Debugging

### Waveform Analysis

The testbench generates detailed waveforms showing:

- **Instruction Fetch**: PC progression and instruction memory access
- **Decode Phase**: Control signal generation and register reads
- **Execute Phase**: ALU operations and memory access
- **Write Back**: Register file updates and memory writes


### Debug Features

- **Register Dump**: Complete register file state display
- **Memory Contents**: Instruction and data memory visualization
- **Control Signals**: Real-time control signal monitoring
- **PC Tracking**: Program counter progression analysis

