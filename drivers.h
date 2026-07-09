#ifndef DRIVERS_H
#define DRIVERS_H

#include "main.h"

void clock_enable(void);
void LED_config(void);
void SysTick_config(void);
void uart_config(void);
void uart_transmit(char c);
void uart_print(const char *str);
char uart_receive(void);

#endif