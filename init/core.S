// Declare chip and language
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

// Global values
.global reset_handler

/*
 * Reset Handler
 * Stack moves towards lower address, HW design choice
 * Stack pointer = end of sram
 * '_estack' is defined in the linker script
 */ 
.section .text, "ax", %progbits
.type reset_handler, %function
reset_handler:
    LDR r0, =_estack
    MOV sp, r0

    // Copy data from flash to RAM data init section
    MOVS r0, #0
    // Load start/end addresses
    LDR r1,=_sdata
    LDR r2,=_edata
    LDR r3,=_la_data // Flash data
    B copy_la_data_loop // Check condition

    copy_la_data:
        LDR r4, [r3, r0]
        STR r4, [r1, r0]
        ADDS r0, r0, #4

    copy_la_data_loop:
        ADDS r4, r0, r1 // Curr RAM postion = r1 + r0
        CMP r4, r2 // Compare with end of .data
        BCC copy_la_data 

    // Zero out uninitialized values
    MOVS r0, #0
    LDR r1, =_sbss
    LDR r2, =_ebss
    B reset_bss_loop

    reset_bss:
        STR r0, [r1] // Load value at r1(_sbss) address
        ADDS r1, r1, #4

    reset_bss_loop:
        CMP r1, r2
        BCC reset_bss

    B main
.size reset_handler, .-reset_handler