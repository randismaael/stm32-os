/* Yay main */
#include "main.h"
#include "interrupts.h"

// SOS Pattern
#define DOT 200
#define DASH 600
#define GAP 200
#define WORD 1400

void delay_ms(uint32_t ms)
{
    uint32_t start = ticks;
    while ((ticks - start) < ms)
    {
        // wait and do nothing
    }
}

void blink(uint32_t on, uint32_t off)
{
    GPIOC->ODR &= ~(1 << LED_PIN); // LED on, PIN 13 = 0
    delay_ms(on);
    GPIOC->ODR |= (1 << LED_PIN);
    delay_ms(off);
}

int main(void)
{
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;   // enable GPIOC clock
    RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;   // enable GPIOA clock for USART1
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN; // enable USART1 clock

    /*
     * (GPIOC) PC13 [23:20] Configuration
     * 0010 (CNF = 00 for PUSH-PULL, MODE = 10 for 2MHz)
     * Page 171 in RM0008
     */
    GPIOC->CRH &= ~(0xF << 20); // clear [23:20]
    GPIOC->CRH |= (0x2 << 20);

    /*
     * (GPIOA) PA9 [7:4] and PA 10 [11:8] Configuration
     * A9(TX): 1011, A10(RX): 1000
     */
    GPIOA->CRH &= ~(0xFF << 4); // clear [11:4] to ensure they are all 0
    GPIOA->CRH |= (0x8B << 4);

    /*
     * SysTick Configuration
     */
    // Program reload value
    SysTick->LOAD = 8000 - 1;
    // Clear current value
    SysTick->VAL = 0;
    // Program Control and Status register
    SysTick->CTRL = 0x7; // 111

    /*
     * Configure UART
     */
    USART1->BRR = 9600;

    while (1)
    {
        // S
        blink(DOT, GAP);
        blink(DOT, GAP);
        blink(DOT, GAP);
        delay_ms(GAP);

        // O
        blink(DASH, GAP);
        blink(DASH, GAP);
        blink(DASH, GAP);
        delay_ms(GAP);

        // S
        blink(DOT, GAP);
        blink(DOT, GAP);
        blink(DOT, GAP);

        delay_ms(WORD);
    }

    return 0;
}