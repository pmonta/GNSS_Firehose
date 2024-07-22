TOOL_BASE = /opt/riscv32i/bin/riscv32
# To use stock Debian riscv toolchain instead:
# apt-get install gcc-riscv64-unknown-elf
# make TOOL_BASE=riscv64

GCC = $(TOOL_BASE)-unknown-elf-gcc
SIZE = $(TOOL_BASE)-unknown-elf-size

ARCHFLAGS = -march=rv32imc -mabi=ilp32
CFLAGS = -std=gnu99 -Wall -Wextra -Wshadow

firmware:
	$(GCC) $(ARCHFLAGS) -c start.S
	$(GCC) $(ARCHFLAGS) $(CFLAGS) -nostdinc -fno-builtin -fwhole-program -Os -c firmware.c
	$(GCC) $(ARCHFLAGS) -ffreestanding -nostdlib -Wl,-Bstatic,-T,sections.lds start.o firmware.o -o firmware.elf
	$(SIZE) firmware.elf

clean:
	rm -f *.o *.elf *~
