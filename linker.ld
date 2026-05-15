/* SRAM starts at 0x20000000, 20 kB 
Flash memory starts at 0x08000000, 64 1kB pages */
_estack = 0x20005000;

MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000 , LENGTH = 64K
    RAM (rxw) : ORIGIN = 0x20000000, LENGTH = 20K
}

