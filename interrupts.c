#include <stdint.h>
#include "main.h"
#include "interrupts.h"
/*
 * Interrupt timer
 * Volatile: reads from HW on every cycle
 */
volatile uint32_t ticks = 0;

void SysTick_handler(void)
{
    ticks++;
}

void USART1_interrupt_handler(void)
{
    
}