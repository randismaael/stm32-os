/* Yay main */
#include "main.h"
#include "interrupts.h"
#include "drivers.h"

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
    clock_enable();
    LED_config();
    SysTick_config();
    uart_config();

    

    while (1)
    {
        char c = uart_receive();
        uart_transmit(c);
    }

    return 0;
}