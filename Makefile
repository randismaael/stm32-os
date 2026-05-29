CC = arm-none-eabi-gcc

# flags
CFLAGS = -mcpu=cortex-m3 -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc

# output file
TARGET = main.elf 
SRCS = core.S vtable.S 
OBJS = $(SRCS:.S=.o)
OBJS := $(OBJS:.c=.o)

all: $(TARGET)

#link all .o files to .elf
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -T./linker.ld $^ -o $@

# convert all files to .o
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)