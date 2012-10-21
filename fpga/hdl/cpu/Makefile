KCASM=java -Dkcpsm=3 -Dbram=18 -Dmodule=cpu_rom -jar ./KCAsm.jar

all:
	$(KCASM) cpu.psm cpu.rmh
	<cpu_rom.v grep -v 'synthesis translate' >cpu_rom_tmp.v
	mv cpu_rom_tmp.v cpu_rom.v
