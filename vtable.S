.syntax unified /* use ARM/Thumb unified syntax */
.cpu cortex-m3 /* target CPU */
.fpu softvfp /* no hardware FPU, use software */
.thumb /* use Thumb ISA */

/*
 * For linker use
 */
.global vtable
.global default_interrupt_handler

/* 
 * Vector Table 
 * "a" — allocate (put in memory)
 * "x" — executable (contains code)
 * "w" — writable
 * %progbits — section contains actual data/code
 */
.type vtable, %object
vtable:
    .word _estack
    .word reset_handler
    .word NMI_handler
    .word hard_fault
    .word memory_management
    .word bus_fault_handler
    .word usage_fault_handler
    .word 0
    .word 0
    .word 0
    .word 0
    .word SVC_handler
    .word debug_monitor_handler
    .word 0
    .word PSV_handler
    .word SysTick_handler
    .word window_watchdog_interrupt_handler
    .word PVD_interrupt_handler
    .word tamper_interrupt_handler
    .word RTC_interrupt_handler
    .word flash_interrupt_handler
    .word RCC_interrupt_handler
    .word EXTI0_interrupt_handler
    .word EXTI1_interrupt_handler
    .word EXTI2_interrupt_handler
    .word EXTI3_interrupt_handler
    .word EXTI4_interrupt_handler
    .word DMA1C1_interrupt_handler
    .word DMA1C2_interrupt_handler
    .word DMA1C3_interrupt_handler
    .word DMA1C4_interrupt_handler
    .word DMA1C5_interrupt_handler
    .word DMA1C6_interrupt_handler
    .word DMA1C7_interrupt_handler
    .word ADC_interrupt_handler
    .word CAN_USBHP_interrupt_handler
    .word CAN_USBLP_interrupt_handler
    .word CAN_RX1_interrupt_handler
    .word CAN_SCE_interrupt_handler
    .word EXTI9_interrupt_handler
    .word TIM1_BRK_interrupt_handler
    .word TIM1_UP_interrupt_handler
    .word TIM1_TRG_interrupt_handler
    .word TIM1_CC_interrupt_handler
    .word I2C1EV_interrupt_handler
    .word I2C1ER_interrupt_handler
    .word I2C2EV_interrupt_handler
    .word I2C2ER_interrupt_handler
    .word SPI1_interrupt_handler
    .word SPI2_interrupt_handler
    .word USART1_interrupt_handler
    .word USART2_interrupt_handler
    .word USART3_interrupt_handler
    .word EXTI15_interrupt_handler
    .word RTCAlarm_interrupt_handler
    .word USB_wakeup_interrupt_handler

    .weak NMI_handler
    .thumb_set NMI_handler, default_interrupt_handler
    .weak hard_fault
    .thumb_set hard_fault, default_interrupt_handler
    .weak memory_management
    .thumb_set memory_management, default_interrupt_handler
    .weak bus_fault_handler
    .thumb_set bus_fault_handler, default_interrupt_handler
    .weak usage_fault_handler
    .thumb_set usage_fault_handler, default_interrupt_handler
    .weak SVC_handler
    .thumb_set SVC_handler, default_interrupt_handler
    .weak debug_monitor_handler
    .thumb_set debug_monitor_handler, default_interrupt_handler
    .weak PSV_handler
    .thumb_set PSV_handler, default_interrupt_handler
    .weak SysTick_handler
    .thumb_set SysTick_handler, default_interrupt_handler
    .weak window_watchdog_interrupt_handler
    .thumb_set window_watchdog_interrupt_handler, default_interrupt_handler
    .weak PVD_interrupt_handler
    .thumb_set PVD_interrupt_handler, default_interrupt_handler
    .weak tamper_interrupt_handler
    .thumb_set tampter_interrupt_handler, default_interrupt_handler
    .weak RTC_interrupt_handler
    .thumb_set RTC_interrupt_handler, default_interrupt_handler
    .weak flash_interrupt_handler
    .thumb_set flash_interrupt_handler, default_interrupt_handler
    .weak RCC_interrupt_handler
    .thumb_set RCC_interrupt_handler, default_interrupt_handler
    .weak EXTI0_interrupt_handler
    .thumb_set EXTI0_interrupt_handler, default_interrupt_handler
    .weak EXTI1_interrupt_handler
    .thumb_set EXTI1_interrupt_handler, default_interrupt_handler
    .weak EXTI2_interrupt_handler
    .thumb_set EXTI2_interrupt_handler, default_interrupt_handler
    .weak EXTI3_interrupt_handler
    .thumb_set EXTI3_interrupt_handler, default_interrupt_handler
    .weak EXTI4_interrupt_handler
    .thumb_set EXTI4_interrupt_handler, default_interrupt_handler
    .weak DMA1C1_interrupt_handler
    .thumb_set DMA1C1_interrupt_handler, default_interrupt_handler
    .weak DMA1C2_interrupt_handler
    .thumb_set DMA1C2_interrupt_handler, default_interrupt_handler
    .weak DMA1C3_interrupt_handler
    .thumb_set DMA1C3_interrupt_handler, default_interrupt_handler
    .weak DMA1C4_interrupt_handler
    .thumb_set DMA1C4_interrupt_handler, default_interrupt_handler
    .weak DMA1C5_interrupt_handler
    .thumb_set DMA1C5_interrupt_handler, default_interrupt_handler
    .weak DMA1C6_interrupt_handler
    .thumb_set DMA1C6_interrupt_handler, default_interrupt_handler
    .weak DMA1C7_interrupt_handler
    .thumb_set DMA1C7_interrupt_handler, default_interrupt_handler
    .weak ADC_interrupt_handler
    .thumb_set ADC_interrupt_handler, default_interrupt_handler
    .weak CAN_USBHP_interrupt_handler
    .thumb_set CAN_USBHP_interrupt_handler, default_interrupt_handler
    .weak CAN_USBLP_interrupt_handler
    .thumb_set CAN_USBLP_interrupt_handler, default_interrupt_handler
    .weak CAN_RX1_interrupt_handler
    .thumb_set CAN_RX1_interrupt_handler, default_interrupt_handler
    .weak CAN_SCE_interrupt_handler
    .thumb_set CAN_SCE_interrupt_handler, default_interrupt_handler
    .weak EXTI9_interrupt_handler
    .thumb_set EXTI9_interrupt_handler, default_interrupt_handler
    .weak TIM1_BRK_interrupt_handler
    .thumb_set TIM1_BRK_interrupt_handler, default_interrupt_handler
    .weak TIM1_UP_interrupt_handler
    .thumb_set TIM1_UP_interrupt_handler, default_interrupt_handler
    .weak TIM1_TRG_interrupt_handler
    .thumb_set TIM1_TRG_interrupt_handler, default_interrupt_handler
    .weak TIM1_CC_interrupt_handler
    .thumb_set TIM1_CC_interrupt_handler, default_interrupt_handler
    .weak I2C1EV_interrupt_handler
    .thumb_set I2C1EV_interrupt_handler, default_interrupt_handler
    .weak I2C1ER_interrupt_handler
    .thumb_set I2C1ER_interrupt_handler, default_interrupt_handler
    .weak I2C2EV_interrupt_handler
    .thumb_set I2C2EV_interrupt_handler, default_interrupt_handler
    .weak I2C2ER_interrupt_handler
    .thumb_set I2C2ER_interrupt_hanlder, default_interrupt_handler
    .weak SPI1_interrupt_handler
    .thumb_set SPI1_interrupt_handler, default_interrupt_handler
    .weak SPI2_interrupt_handler
    .thumb_set SPI2_interrupt_handler, default_interrupt_handler
    .weak USART1_interrupt_handler
    .thumb_set USART1_interrupt_handler, default_interrupt_handler
    .weak USART2_interrupt_handler
    .thumb_set USART2_interrupt_handler, default_interrupt_handler
    .weak USART3_interrupt_handler
    .thumb_set USART3_interrupt_handler, default_interrupt_handler
    .weak EXTI15_interrupt_handler
    .thumb_set EXTI15_interrupt_handler, default_interrupt_handler
    .weak RTCAlarm_interrupt_handler
    .thumb_set RTCAlarm_interrupt_handler, default_interrupt_handler
    .weak USB_wakeup_interrupt_handler
    .thumb_set USB_wakeup_interrupt_handler, default_interrupt_handler
.size vtable, .-vtable

/*
 * Default interrupt handler in the case an unexpected interrupt occurs.
 */
default_interrupt_handler:
    default_interrupt_loop:
    B default_interrupt_loop
.size default_interrupt_handler, .-default_interrupt_handler



