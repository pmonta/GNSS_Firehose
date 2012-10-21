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
	PacoBlaze Arithmetic-Logic Unit.
*/

`define operation(x) (x)
`define operation_is_alu(x) (operation == (x))

module pacoblaze_alu(
	operation,
	shift_operation, shift_direction, shift_constant,
	result, operand_a, operand_b,
	carry_in, zero_out, carry_out
);
input [`operation_width-1:0] operation; ///< Main operation
input [2:0] shift_operation; ///< Rotate/shift operation
input shift_direction; ///< Rotate/shift left(0)/right(1)
input shift_constant; ///< Shift constant (0 or 1)
output reg [`operand_width-1:0] result; ///< ALU result
input [`operand_width-1:0] operand_a, operand_b; ///< ALU operands
input carry_in; ///< Carry in
output zero_out; ///< Zero out
output reg carry_out; ///< Carry out

/** Adder/substracter second operand. */
wire [`operand_width-1:0] addsub_b =
	(`operation_is_alu(`op_sub)
	|| `operation_is_alu(`op_subcy)
	|| `operation_is_alu(`op_compare)
	) ? ~operand_b :
	operand_b;

/** Adder/substracter carry. */
wire addsub_carry =
	(`operation_is_alu(`op_addcy)
	) ? carry_in :
	(`operation_is_alu(`op_sub)
	|| `operation_is_alu(`op_compare)
	) ? 1 : // ~b => b'
	(`operation_is_alu(`op_subcy)
	) ? ~carry_in : // ~b - c => b' - c
	0;

/** Adder/substracter with carry. */
wire [1+`operand_width-1:0] addsub_result = operand_a + addsub_b + addsub_carry;

/** Shift bit value. */
// synthesis parallel_case full_case
wire shift_bit =
	(shift_operation == `opcode_rr) ? operand_a[0] : // == `opcode_slx
	(shift_operation == `opcode_rl) ? operand_a[7] : // == `opcode_srx
	(shift_operation == `opcode_rsa) ? carry_in :
	shift_constant; // == `opcode_rsc

assign zero_out =
	~|result;


// always @*
always @(operation,
	shift_operation, shift_direction, shift_constant, shift_bit,
	result, operand_a, operand_b, carry_in, carry_out,
	addsub_result, addsub_carry
	) begin: on_alu
	/* Defaults */
	carry_out = 0;

	// synthesis parallel_case full_case
	case (operation)

		`operation(`op_add),
		`operation(`op_addcy):
			{carry_out, result} = addsub_result;

		`operation(`op_compare),
		`operation(`op_sub),
		`operation(`op_subcy): begin
			{carry_out, result} = {~addsub_result[8], addsub_result[7:0]};
		end

		`operation(`op_and):
			result = operand_a & operand_b;

		`operation(`op_or):
			result = operand_a | operand_b;

		`operation(`op_test):
			begin result = operand_a & operand_b; carry_out = ^result; end

		`operation(`op_xor):
			result = operand_a ^ operand_b;

		`operation(`op_rs):
			if (shift_direction) // shift right
				{result, carry_out} = {shift_bit, operand_a};
			else // shift left
				{carry_out, result} = {operand_a, shift_bit};

		default:
			result = operand_b;

	endcase

end



endmodule
