# STM32 Bare Metal OS

A bare metal operating system built from scratch on the STM32F103C8T6 (Blue Pill) without HAL or any abstraction libraries. Written in ARM assembly and C.

## Learning
- Bare metal ARM programming
- GDB debugging over SWD
- ARM ([Cortex-M3](https://www.st.com/resource/en/reference_manual/rm0008-stm32f101xx-stm32f102xx-stm32f103xx-stm32f105xx-and-stm32f107xx-advanced-armbased-32bit-mcus-stmicroelectronics.pdf#page=49.32)) memory map and boot sequence 

## Resources
- [Vivonomicon bare metal STM32 series](https://vivonomicon.com/2018/04/20/bare-metal-stm32-programming-part-1-hello-arm/)
- [RM0008 — STM32F103 reference manual](https://www.st.com/resource/en/reference_manual/rm0008-stmicroelectronics.pdf)
- [STM32F103C8 datasheet](https://www.st.com/resource/en/datasheet/stm32f103c8.pdf)
- [csrohit — linker script tutorial](https://medium.com/@csrohit/writing-linker-script-for-stm32-arm-cortex-m3-%EF%B8%8F-fdc2acaaddcc)
- [CMSIS header files](https://github.com/modm-io/cmsis-header-stm32/tree/master)

## Hardware
- STM32F103C8T6 (Blue Pill) - Cortex-M3, 64K flash, 20K RAM
- ST-Link V2 — SWD flashing and debugging
- CP2102 USB-UART — serial output

## Toolchain
- `arm-none-eabi-gcc` / `arm-none-eabi-as` — compiler and assembler
- `arm-none-eabi-gdb` — debugger
- `st-util` — GDB server over ST-Link
- STM32CubeProgrammer — flashing

## Project Structure
```
.
├── core.S      # reset handler — copies .data, zeroes .bss, calls main
├── vtable.S    # vector table — interrupt handlers, weak aliases to default
├── linker.ld   # memory map — FLASH/SRAM regions, section placement
├── main.c      # application entry point
└── Makefile    # build system
```

## Build
```bash
make
make clean
```

## Debug
```bash
# Terminal 1
st-util

# Terminal 2
arm-none-eabi-gdb main.elf
(gdb) target remote :4242
(gdb) monitor reset halt
(gdb) load
(gdb) continue
```

## Progress & Demo
### Part 1 — Vector table, reset handler, linker script
Boot sequence verified via GDB: `val` incrementing in real time, read directly from RAM over SWD:
![GDB val counting](media/gdb_val_counting.png)

### Part 2 — GPIO
Bare metal GPIO: Onboard LED blinking at ~1Hz via direct GPIO register access, no HAL
![LED blink](media/led_blinking.gif)

### Part 3 — SysTick Timer
Replaced NOP delay loop with interrupt-driven SysTick timer for precise 1ms ticks. Demonstrated with SOS morse code blink pattern:
![SOS blink](media/SOS_blinking.gif)