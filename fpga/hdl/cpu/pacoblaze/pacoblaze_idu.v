/*
	Copyright (C) 2004, 2006 Pablo Bleyer Kocik.

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
	PacoBlaze Instruction Decode Unit.
*/

`define operation_set(x) operation = (x)
`define operation(x) (x)

module pacoblaze_idu(
	instruction,
	operation,
	shift_operation, shift_direction, shift_constant,
	operand_selection,
	x_address, y_address,
	implied_value, port_address,
	scratch_address,
	code_address,
	conditional, condition_flags,
	interrupt_enable
);
input [`code_width-1:0] instruction; ///< Instruction
output reg [`operation_width-1:0] operation; ///< Main operation
output [2:0] shift_operation; ///< Rotate/shift operation
output shift_direction; ///< Rotate/shift left(0)/right(1)
output shift_constant; ///< Shift constant value
output operand_selection; ///< Operand selection (k/p/s:0, y:1)
output [`register_depth-1:0] x_address, y_address; ///< Operation x source/target, y source
output [`operand_width-1:0] implied_value; ///< Operand constant source
output [`port_depth-1:0] port_address; ///< Port address
output [`scratch_depth-1:0] scratch_address; ///< Scratchpad address
output [`code_depth-1:0] code_address; ///< Program address
output conditional; ///< Conditional operation (unconditional(0)/conditional(1))
output [1:0] condition_flags; ///< Condition flags on zero and carry
output interrupt_enable; ///< Interrupt disable(0)/enable(1)

wire [4:0] instruction_0 = instruction[17:13];

assign x_address = instruction[11:8];
assign y_address = instruction[7:4];
assign operand_selection = instruction[12];
assign code_address = instruction[9:0];
assign interrupt_enable = instruction[0];
assign scratch_address = instruction[5:0];

assign shift_direction = instruction[3];
assign shift_operation = instruction[2:1];
assign shift_constant = instruction[0];

assign conditional = instruction[12];
assign condition_flags = instruction[11:10];

assign implied_value = instruction[7:0];
assign port_address = instruction[7:0];


always @(instruction_0)
begin
	operation = 'h0; // default

	// synthesis parallel_case full_case
	case (instruction_0)

		`opcode_load: `operation_set(`op_load);
		`opcode_add: `operation_set(`op_add);
		`opcode_addcy: `operation_set(`op_addcy);
		`opcode_and: `operation_set(`op_and);
		`opcode_or: `operation_set(`op_or);
		`opcode_rs: `operation_set(`op_rs);
		`opcode_sub: `operation_set(`op_sub);
		`opcode_subcy: `operation_set(`op_subcy);
		`opcode_xor: `operation_set(`op_xor);

		`opcode_jump: `operation_set(`op_jump);
		`opcode_call: `operation_set(`op_call);
		`opcode_return: `operation_set(`op_return);
		`opcode_returni: `operation_set(`op_returni);
		`opcode_interrupt: `operation_set(`op_interrupt);
		`opcode_input: `operation_set(`op_input);
		`opcode_output: `operation_set(`op_output);

		// PB3
		`opcode_compare: `operation_set(`op_compare);
		`opcode_test: `operation_set(`op_test);
		`opcode_fetch: `operation_set(`op_fetch);
		`opcode_store: `operation_set(`op_store);

		// default: `operation_set(0);
	endcase

end



endmodule
