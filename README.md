# RISC-V CPU (RV32I)

A RISC-V processor built from scratch in SystemVerilog, designed incrementally: single-cycle RV32I first, then a 5-stage pipeline, caches, and custom AI/matrix instructions.

> **Status: work in progress.** See the roadmap below for what is actually done.

## Goals

1. Single-cycle RV32I core (base integer ISA only, no M extension)
2. 5-stage pipeline (IF, ID, EX, MEM, WB) with forwarding and hazard handling
3. L1 instruction and data caches
4. Interrupt support and UART for debugging
5. Custom instructions for matrix/AI operations

## Roadmap

- [ ] ISA study: instruction formats and encodings
- [ ] ALU (add/sub, logic ops, SLT/SLTU, barrel shifter)
- [ ] Register file
- [ ] Immediate generator
- [ ] Control unit
- [ ] Instruction and data memory
- [ ] Single-cycle datapath and top-level core
- [ ] Verification with assembly test programs
- [ ] Pipelined core
- [ ] Cache
- [ ] Interrupts and UART
- [ ] Custom AI instructions

Tick items as they pass their testbench, not before.

## Repository layout

```
rtl/core/       core modules (alu, shifter, register_file, control_unit, immediate_gen, datapath, riscv_core)
rtl/memory/     instruction and data memory
tb/             testbenches, at least one per module
tests/asm/      assembly test programs, one per instruction type
tests/expected/ expected register/memory state for each test
scripts/        helper scripts for assembling and simulation
docs/           design notes, datapath diagrams, design_decisions.md
```

## Design decisions (summary)

Full reasoning lives in `docs/design_decisions.md`.

- SUB reuses the adder via operand inversion and carry-in (no separate subtractor)
- No SUBI (use ADDI with a negative immediate) and no MUL (M extension, out of scope)
- No GT/LE comparators; the ISA only needs EQ, signed LT, unsigned LT
- Shifter: 5-stage logarithmic barrel shifter
- I-type instructions reuse the R-type ALU path; a mux selects rs2 or the sign-extended immediate

## Tools

- HDL: SystemVerilog
- Simulation/synthesis: Xilinx Vivado
- Test programs: assembled with RARS or a RISC-V GNU toolchain

## How to simulate

1. Open Vivado and create a project outside this repo's tracked folders (or in a `vivado_project/` folder, which is gitignored).
2. Add sources from `rtl/` and `tb/` with **"Copy sources into project" unchecked**.
3. Set the testbench you want as the simulation top and run behavioral simulation.

## References

- RISC-V Unprivileged ISA Specification
- Harris and Harris, *Digital Design and Computer Architecture: RISC-V Edition*
- Patterson and Hennessy, *Computer Organization and Design: RISC-V Edition*

## License

MIT (see `LICENSE`)
