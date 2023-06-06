module add32_incr(en_reg, a, b, result);
	input en_reg ;
	input [31:0] a, b;
	output [31:0] result;

	assign result = en_reg ? (a + b) : a ;
endmodule