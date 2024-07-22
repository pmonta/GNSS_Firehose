	.section .init
	.global start
	.global main

start:
	lui sp,%hi(8192)
	addi sp,sp,%lo(8192)
	jal ra,main
	ebreak
