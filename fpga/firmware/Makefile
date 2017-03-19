TOOLCHAIN = /opt/riscv32i/bin

GCC = $(TOOLCHAIN)/riscv32-unknown-elf-gcc

test:
	$(GCC) -nostdinc -fno-builtin -c util.c
	$(GCC) -nostdinc -fno-builtin -c firmware.c
	$(GCC) -ffreestanding -nostdlib -Wl,-Bstatic,-T,support/sections.lds support/start.o firmware.o util.o -lgcc -o firmware.elf 

clean:
	rm -f *.o *.elf *~
