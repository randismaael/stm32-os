CC = arm-none-eabi-gcc
# convert
OC = arm-none-eabi-objcopy 
# print size
OS = arm-none-eabi-size 

# flags
CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -g --specs=nosys.specs -nostdlib -lgcc

# output file
TARGET = main
SRCS = init/core.S init/vtable.S main.c interrupts.c drivers.c
OBJS = $(SRCS:.S=.o)
OBJS := $(OBJS:.c=.o)

all: $(TARGET).elf $(TARGET).bin

#link all .o files to .elf
$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) -T./init/linker.ld $^ -o $@

$(TARGET).bin: $(TARGET).elf
	$(OC) -S -O binary $< $@
	$(OS) $<

# convert all files to .o
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: all clean
clean:
	rm -f $(OBJS) 
	rm -f $(TARGET).elf
	rm -f $(TARGET).bin