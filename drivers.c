#include <stdint.h>
#include "drivers.h"
#include "main.h"

/*
 * Enable Clocks
 */
void clock_enable(void)
{
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;   // enable GPIOC clock
    RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;   // enable GPIOA clock for USART1
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN; // enable USART1 clock
}

/*
 * Pin configuration
 */
void LED_config(void)
{
    /*
     * (GPIOC) PC13 [23:20] Configuration
     * 0010 (CNF = 00 for PUSH-PULL, MODE = 10 for 2MHz)
     * Page 171 in RM0008
     */
    GPIOC->CRH &= ~(0xF << 20); // clear [23:20]
    GPIOC->CRH |= (0x2 << 20);
}

void SysTick_config(void)
{
    /*
     * SysTick Configuration
     */
    // Program reload value
    SysTick->LOAD = 8000 - 1;
    // Clear current value
    SysTick->VAL = 0;
    // Program Control and Status register
    SysTick->CTRL = 0x7; // 111
}

/*
 * UART register configuration
 */
void uart_config(void)
{
    /*
     * (GPIOA) PA9 [7:4] and PA 10 [11:8] Configuration
     * A9(TX): 1011, A10(RX): 1000
     */
    GPIOA->CRH &= ~(0xFF << 4); // clear [11:4] to ensure they are all 0
    GPIOA->CRH |= (0x8B << 4);

    /* Ensure every bit is 0 to avoid unexpected enable */
    USART1->CR1 = 0; // M = 0, 1 Start, 8 Data
    USART1->CR2 = 0;
    USART1->CR3 = 0;

    /*
     * Baud Rate
     * ARM Cortex 3 is 8MHz
     * USARTDIV = PCLK2 / (16 x baud rate) = 52.083
     */
    USART1->BRR = 0x341;

    /* Enable Transmitter, Receiver, and UART */
    USART1->CR1 |= USART_CR1_TE;
    USART1->CR1 |= USART_CR1_RE;
    USART1->CR1 |= USART_CR1_UE;
}

/*
 * UART Data Transmission
 * DR [8:0] = Data Value
 * char = 8 bits
 */
void uart_transmit(char c)
{
    /*Poll until TXE = 1*/
    while (!(USART1->SR & USART_SR_TXE))
    {
    }
    /* set data register to the character to be transmitted, hardware sends to PA9*/
    USART1->DR = c;
}

/*
 * UART String Transmission 
 * Standard C convention separates character transmission and full string transmission
 */
void uart_print(const char *str)
{
    while (*str)
    {
        uart_transmit(*str++); /*send char and advance*/
    }
}

/*
 * UART Character Receiver
 * Return 8 bit character
 */
char uart_receive(void)
{
    // Poll until a character is received
    while (!(USART1->SR & USART_SR_RXNE)){}
    char c = USART1->DR;
}