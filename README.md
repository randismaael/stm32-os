# STM32 Bare Metal OS

A bare metal operating system built from scratch on the STM32F103C8T6 (Blue Pill) without HAL or any abstraction libraries. Written in ARM assembly and C. Initialization follows the Vivonomicon bare metal STM32 series.

## Learning
- Bare metal ARM programming
- GDB debugging over SWD
- ARM Cortex-M3 memory map and boot sequence

## Hardware
- STM32F103C8T6 (Blue Pill) — Cortex-M3, 64K flash, 20K RAM
- ST-Link V2 — SWD flashing and debugging
- CP2102 USB-UART — serial output

## Toolchain
- `arm-none-eabi-gcc` / `arm-none-eabi-as` — compiler and assembler
- `arm-none-eabi-gdb` — debugger
- `st-util` — GDB server over ST-Link
- STM32CubeProgrammer — flashing

## Build
```bash
arm-none-eabi-as -mcpu=cortex-m3 -mthumb core.S -o core.o
arm-none-eabi-gcc core.o -mcpu=cortex-m3 -mthumb --specs=nosys.specs -nostdlib -lgcc -T./linker.ld -o main.elf
```

## Debug
```bash
# Terminal 1
st-util

# Terminal 2
arm-none-eabi-gdb main.elf
(gdb) target extended-remote :4242
(gdb) load
(gdb) continue
```

## Progress
- [x] Part 1 — Vector table and reset handler in assembly