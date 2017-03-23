SECTIONS {
	.memory : {
		. = 0x00000000;
		*(.init);
		*(*);
		. = ALIGN(4);
		end = .;
	}
}
