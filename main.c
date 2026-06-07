/* Yay main */
#include "main.h"

int main(void)
{
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN; // drive bus high

    /* PC13 Configuration [23:20]
     * 0010 (CNF = 00 for PUSH-PULL, MODE = 10 for 2MHz)
     */
    GPIOC->CRH &= ~(0xF << 20); // clear [23:20]
    GPIOC->CRH |= (0x2 << 20);

    // ADD LATER WHEN I GET BUTTON:
    // uint32_t gpioc_input = GPIOC->IDR;
    // GPIOC->ODR |= (1 << LED_PIN);
    // uint8_t button = 0;
    // while(1)
    // {
    //     if (gpioc_input & (1 << 13))
    //     {

    //     } else
    //     {

    //     }
    // }

    // No button: LED BLINKING
    while (1)
    {
        GPIOC->ODR &= ~(1 << LED_PIN); // LED on, PIN 13 = 0
        for (int i = 0; i < 500000; i++)
        {
            __asm__("nop"); // no operation, wait
        }
        GPIOC->ODR |= (1 << LED_PIN);
        for (int i = 0; i < 500000; i++)
        {
            __asm__("nop"); // no operation, wait
        }
    }

    return 0;
}