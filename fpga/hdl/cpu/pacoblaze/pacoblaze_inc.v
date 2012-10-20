/*
	Copyright (c) 2004, 2006 Pablo Bleyer Kocik.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:

	1. Redistributions of source code must retain the above copyright notice, this
	list of conditions and the following disclaimer.

	2. Redistributions in binary form must reproduce the above copyright notice,
	this list of conditions and the following disclaimer in the documentation
	and/or other materials provided with the distribution.

	3. The name of the author may not be used to endorse or promote products
	derived from this software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
	WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
	MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
	EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
	PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
	IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.
*/

/** @file
	PacoBlaze definitions include file.
*/

`define operand_width 8 ///< Operand width

/** Instruction memory data, address width */
`define code_width 18
`define code_depth 10 // 1024 instructions
`define code_size (1<<`code_depth) ///< Instruction memory size

`define port_width `operand_width ///< Port IO data width
`define port_depth `operand_width ///< Port id (address) width
`define port_size (1<<`port_depth) ///< Port size

`define stack_width `code_depth ///< Call/return stack width
/** Call/return stack depth */
`define stack_depth 5
`define stack_size (1<<`stack_depth) ///< Call/return stack size

`define register_width `operand_width ///< Register file width
/** Register file depth */
`define register_depth 4
`define register_size (1<<`register_depth) ///< Register file size

`define scratch_width `operand_width ///< Scratchpad ram width
`define scratch_depth 6 ///< Scratchpad ram depth
`define scratch_size (1<<`scratch_depth) ///< Scratchpad ram size

`define operation_width 5


`define reset_vector 0 ///< Reset vector
`define interrupt_vector (`code_size-1) ///< Interrupt vector


/** Operation string names */
`define os_load "load"
`define os_add "add"
`define os_addcy "addcy"
`define os_and "and"
`define os_or "or"
`define os_rs "rs"
	`define os_sr0 "sr0"
	`define os_sr1 "sr1"
	`define os_srx "srx"
	`define os_sra "sra"
	`define os_rr "rr"
	`define os_sl0 "sl0"
	`define os_sl1 "sl1"
	`define os_slx "slx"
	`define os_sla "sla"
	`define os_rl "rl"
`define os_sub "sub"
`define os_subcy "subcy"
`define os_xor "xor"
`define os_jump "jump"
`define os_call "call"
`define os_return "return"
`define os_returni "returni"
`define os_interrupt "interrupt"
`define os_input "input"
`define os_output "output"
`define os_invalid "(n/a)"
// PB3
`define os_compare "compare"
`define os_test "test"
`define os_fetch "fetch"
`define os_store "store"
// PB3M
`define os_mul "mul"
`define os_addw "addw"
`define os_addwcy "addwcy"
`define os_subw "subw"
`define os_subwcy "subwcy"

// flags
`define os_z "z "
`define os_nz "nz"
`define os_c "c "
`define os_nc "nc"
// interrupt
`define os_enable "enable "
`define os_disable "disable"


/** Conditional flags */
`define flag_z 2'b00 // zero set
`define flag_nz 2'b01 // zero not set
`define flag_c 2'b10 // carry set
`define flag_nc 2'b11 // carry not set

/** Rotate/shift operations */
`define opcode_rsc 2'b11 // shift constant
`define opcode_rsa 2'b00 // shift all (through carry)
`define opcode_rr 2'b10
`define opcode_slx 2'b10
`define opcode_rl 2'b01
`define opcode_srx 2'b01

`define opcode_add 5'h0c
`define opcode_addcy 5'h0d
`define opcode_and 5'h05
`define opcode_compare 5'h0a
`define opcode_or 5'h06
`define opcode_rs 5'h10
`define opcode_sub 5'h0e
`define opcode_subcy 5'h0f
`define opcode_test 5'h09
`define opcode_xor 5'h07

`define opcode_call 5'h18
`define opcode_interrupt 5'h1e
`define opcode_fetch 5'h03
`define opcode_input 5'h02
`define opcode_jump 5'h1a
`define opcode_load 5'h00
`define opcode_output 5'h16
`define opcode_return 5'h15
`define opcode_returni 5'h1c
`define opcode_store 5'h17

`define op_load `opcode_load
`define op_add `opcode_add
`define op_addcy `opcode_addcy
`define op_and `opcode_and
`define op_or `opcode_or
`define op_rs `opcode_rs
`define op_sub `opcode_sub
`define op_subcy `opcode_subcy
`define op_xor `opcode_xor
`define op_jump `opcode_jump
`define op_call `opcode_call
`define op_return `opcode_return
`define op_returni `opcode_returni
`define op_interrupt `opcode_interrupt
`define op_input `opcode_input
`define op_output `opcode_output
`define op_compare `opcode_compare
`define op_test `opcode_test
`define op_fetch `opcode_fetch
`define op_store `opcode_store

/*
	PACOBLAZE3
	ADDK         01100 0 sX(4) constant(8)
	ADDR         01100 1 sX(4) sY(4) 0000
	ADDCYK       01101 0 sX(4) constant(8)
	ADDCYR       01101 1 sX(4) sY(4) 0000
	ANDK         00101 0 sX(4) constant(8)
	ANDR         00101 1 sX(4) sY(4) 0000
	CALL         11000 cnd(3) address(10)
	COMPARE      01010 0 sX(4) constant(8)
	COMPARE      01010 1 sX(4) sY(4) 0000
	INTERRUPTE/D 11110 000000000000 ed(1)
	FETCHK       00011 0 sX(4) 00 spad(6)
	FETCHR       00011 1 sX(4) sY(4) 0000
	INPUTK       00010 0 sX(4) pid(8)
	INPUTR       00010 1 sX(4) sY(4) 0000
	JUMP         11010 cnd(3) address(10)
	LOADK        00000 0 sX(4) constant(8)
	LOADR        00000 1 sX(4) sY(4) 0000
	ORK          00110 0 sX(4) constant(8)
	ORR          00110 1 sX(4) sY(4) 0000
	OUTPUTK      10110 0 sX(4) pid(8)
	OUTPUTR      10110 1 sX(4) sY(4) 0000
	RETURN       10101 0000000000000
	RETURNI      11100 000000000000 ie(1)
	RSR          10000 0 sX(4) 0000 1 sr(3)
	RSL          10000 0 sX(4) 0000 0 sr(3)

	SR0 sX100000 sX(4) 0000 1 11 0
	SR1 sX100000 sX(4) 0000 1 11 1
	SRX sX100000 sX(4) 0000 1 01 0
	SRA sX100000 sX(4) 0000 1 00 0
	RR  sX100000 sX(4) 0000 1 10 0

	SL0 sX100000 sX(4) 0000 0 11 0
	SL1 sX100000 sX(4) 0000 0 11 1
	SLX sX100000 sX(4) 0000 0 10 0
	SLA sX100000 sX(4) 0000 0 00 0
	RL  sX100000 sX(4) 0000 0 01 0

	STOREK       10111 0 sX(4) 00 spad(6)
	STORER       10111 1 sX(4) sY(4) 0000
	SUBK         01110 0 sX(4) constant(8)
	SUBR         01110 1 sX(4) sY(4) 0000
	SUBCYK       01111 0 sX(4) constant(8)
	SUBCYR       01111 1 sX(4) sY(4) 0000
	TESTK        01001 0 sX(4) constant(8)
	TESTR        01001 1 sX(4) sY(4) 0000
	XORK         00111 0 sX(4) constant(8)
	XORR         00111 1 sX(4) sY(4) 0000


	ADD sX,kk 0 1 1 0 0 0 x x x x k k k k k k k k
	ADD sX,sY 0 1 1 0 0 1 x x x x y y y y 0 0 0 0
	ADDCY sX,kk 0 1 1 0 1 0 x x x x k k k k k k k k
	ADDCY sX,sY 0 1 1 0 1 1 x x x x y y y y 0 0 0 0
	AND sX,kk 0 0 1 0 1 0 x x x x k k k k k k k k
	AND sX,sY 0 0 1 0 1 1 x x x x y y y y 0 0 0 0
	CALL 1 1 0 0 0 0 0 0 a a a a a a a a a a
	CALL C 1 1 0 0 0 1 1 0 a a a a a a a a a a
	CALL NC 1 1 0 0 0 1 1 1 a a a a a a a a a a
	CALL NZ 1 1 0 0 0 1 0 1 a a a a a a a a a a
	CALL Z 1 1 0 0 0 1 0 0 a a a a a a a a a a
	COMPARE sX,kk 0 1 0 1 0 0 x x x x k k k k k k k k
	COMPARE sX,sY 0 1 0 1 0 1 x x x x y y y y 0 0 0 0
	DISABLE INTERRUPT 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	ENABLE INTERRUPT 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1
	FETCH sX, ss 0 0 0 1 1 0 x x x x 0 0 s s s s s s
	FETCH sX,(sY) 0 0 0 1 1 1 x x x x y y y y 0 0 0 0
	INPUT sX,(sY) 0 0 0 1 0 1 x x x x y y y y 0 0 0 0
	INPUT sX,pp 0 0 0 1 0 0 x x x x p p p p p p p p
	JUMP 1 1 0 1 0 0 0 0 a a a a a a a a a a
	JUMP C 1 1 0 1 0 1 1 0 a a a a a a a a a a
	JUMP NC 1 1 0 1 0 1 1 1 a a a a a a a a a a
	JUMP NZ 1 1 0 1 0 1 0 1 a a a a a a a a a a
	JUMP Z 1 1 0 1 0 1 0 0 a a a a a a a a a a
	LOAD sX,kk 0 0 0 0 0 0 x x x x k k k k k k k k
	LOAD sX,sY 0 0 0 0 0 1 x x x x y y y y 0 0 0 0
	OR sX,kk 0 0 1 1 0 0 x x x x k k k k k k k k
	OR sX,sY 0 0 1 1 0 1 x x x x y y y y 0 0 0 0
	OUTPUT sX,(sY) 1 0 1 1 0 1 x x x x y y y y 0 0 0 0
	OUTPUT sX,pp 1 0 1 1 0 0 x x x x p p p p p p p p
	RETURN 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
	RETURN C 1 0 1 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0
	RETURN NC 1 0 1 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0
	RETURN NZ 1 0 1 0 1 1 0 1 0 0 0 0 0 0 0 0 0 0
	RETURN Z 1 0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0
	RETURNI DISABLE 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	RETURNI ENABLE 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
	RL sX 1 0 0 0 0 0 x x x x 0 0 0 0 0 0 1 0
	RR sX 1 0 0 0 0 0 x x x x 0 0 0 0 1 1 0 0
	SL0 sX 1 0 0 0 0 0 x x x x 0 0 0 0 0 1 1 0
	SL1 sX 1 0 0 0 0 0 x x x x 0 0 0 0 0 1 1 1
	SLA sX 1 0 0 0 0 0 x x x x 0 0 0 0 0 0 0 0
	SLX sX 1 0 0 0 0 0 x x x x 0 0 0 0 0 1 0 0
	SR0 sX 1 0 0 0 0 0 x x x x 0 0 0 0 1 1 1 0
	SR1 sX 1 0 0 0 0 0 x x x x 0 0 0 0 1 1 1 1
	SRA sX 1 0 0 0 0 0 x x x x 0 0 0 0 1 0 0 0
	SRX sX 1 0 0 0 0 0 x x x x 0 0 0 0 1 0 1 0
	STORE sX, ss 1 0 1 1 1 0 x x x x 0 0 s s s s s s
	STORE sX,(sY) 1 0 1 1 1 1 x x x x y y y y 0 0 0 0
	SUB sX,kk 0 1 1 1 0 0 x x x x k k k k k k k k
	SUB sX,sY 0 1 1 1 0 1 x x x x y y y y 0 0 0 0
	SUBCY sX,kk 0 1 1 1 1 0 x x x x k k k k k k k k
	SUBCY sX,sY 0 1 1 1 1 1 x x x x y y y y 0 0 0 0
	TEST sX,kk 0 1 0 0 1 0 x x x x k k k k k k k k
	TEST sX,sY 0 1 0 0 1 1 x x x x y y y y 0 0 0 0
	XOR sX,kk 0 0 1 1 1 0 x x x x k k k k k k k k
	XOR sX,sY 0 0 1 1 1 1 x x x x y y y y 0 0 0 0

	Unused opcodes
	01
	04
	08
	0b
	11
	12
	13
	14
	19
	1b
	1d
	1f

// PB1,2,3
`define ob_load (1<<0)
`define ob_add (1<<1)
`define ob_addcy (1<<2)
`define ob_and (1<<3)
`define ob_or (1<<4)
`define ob_rs (1<<5)
`define ob_sub (1<<6)
`define ob_subcy (1<<7)
`define ob_xor (1<<8)
`define ob_jump (1<<9)
`define ob_call (1<<10)
`define ob_return (1<<11)
`define ob_returni (1<<12)
`define ob_interrupt (1<<13)
`define ob_input (1<<14)
`define ob_output (1<<15)
// PB3
`define ob_compare (1<<16)
`define ob_test (1<<17)
`define ob_fetch (1<<18)
`define ob_store (1<<19)


*/
