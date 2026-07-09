#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include <stdint.h>

extern volatile uint32_t ticks;

void SysTick_handler(void);
void USART1_interrupt_handler(void);

#endif