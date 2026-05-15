// declare chip and language
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

// global mem locations
.global vtable
.global reset_handler

/* 
 * vector table
 * includes only RAM and reset handler
 */
 .type vtable, %object
 vtable: 
    .word _estack
    .word reset_handler
.size vtable, .-vtable

// reset handler
.type reset_handler, %function
reset_handler:
    // stack moves towards lower address, HW design choice
    // stack pointer = end of sram
    LDR r0, =_estack
    MOV sp, r0

    //testing
    LDR r7, =0xDEADBEEF
    main_loop:
        ADDS r0, r0, #1
        B   main_loop
.size reset_handler, .-reset_handler
