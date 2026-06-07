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
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN; // enable GPIOC clock

    /* PC13 Configuration [23:20]
     * 0010 (CNF = 00 for PUSH-PULL, MODE = 10 for 2MHz)
     */
    GPIOC->CRH &= ~(0xF << 20); // clear [23:20]
    GPIOC->CRH |= (0x2 << 20);

    /*
     * SysTick Configuration
     */
    // Program reload value
    SysTick->LOAD = 8000 - 1;
    // Clear current value
    SysTick->VAL = 0;
    // Program Control and Status register
    SysTick->CTRL = 0x7; // 111

    // No button: SOS Blinking

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