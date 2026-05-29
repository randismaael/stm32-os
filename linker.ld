/* 
 * linker script describes how different sections 
 * of memory should be mapped in the output file (core.o)
 - Entry is where first executable function lives
*/
ENTRY(reset_handler) 
/* 
 * SRAM starts at 0x20000000, 20 kB 
 * Flash memory starts at 0x08000000, 64 1kB pages 
 */
_estack = 0x20005000;

/*
 * reserve space for stack and dynamic memory
 * generates error if there is <1KB RAM left over
 */
 _Min_Leftover_RAM = 0x400;

MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000 , LENGTH = 64K
    SRAM (rxw) : ORIGIN = 0x20000000, LENGTH = 20K
}

SECTIONS
{
    /* The vector table goes at the start of flash. */
    .isr_vector :
    {
        KEEP(*(.isr_vector));
        . = ALIGN(4);
    }> FLASH

    .text :
    {
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata.*)
        . = ALIGN(4);
        _etext = .;
    }> FLASH

    /* 
     * la_data saves address in flash bc reset_handler 
     * needs this to know where to copy from
     * runs in SRAM but stored in FLASH
     * sdata for start in RAM, edata for ends in RAM
    */
    _la_data = LOADADDR(.data);
    .data :
    {
        _sdata = .;
        *(.data)
        *(.data.*)
        . = ALIGN(4);
        _edata = .;
    }> SRAM AT> FLASH

    .bss :
    {
        _sbss = .;
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss.*)
        . = ALIGN(4);
        _ebss = .;
        __bss_end__ = _ebss;
        . = ALIGN(4);
        end = .;
        __end__ = .;
    }>SRAM

    /* 
     * in case there isn't enough RAM for program to run
     */
    .dynamic_allocations :
    {
        . = ALIGN(4);
        _ssystem_ram = .;
        . = . + _Min_Leftover_RAM;
        . = ALIGN(4);
        _esystem_ram = .;
    }
}