TOOLCHAIN = /opt/riscv32i/bin

GCC = $(TOOLCHAIN)/riscv32-unknown-elf-gcc
SIZE = $(TOOLCHAIN)/riscv32-unknown-elf-size

firmware:
	$(GCC) -c start.S
	$(GCC) -nostdinc -fno-builtin -fwhole-program -Os -c firmware.c
	$(GCC) -ffreestanding -nostdlib -Wl,-Bstatic,-T,sections.lds start.o firmware.o -o firmware.elf 
	$(SIZE) firmware.elf

clean:
	rm -f *.o *.elf *~
