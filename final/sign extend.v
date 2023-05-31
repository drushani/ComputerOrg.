/*
	Input Port
		1. immed_in: 讀入欲做sign extend資料
	Output Port
		1. ext_immed_out: 輸出已完成sign extend資料
*/
module sign_extend( immed_in, ext_immed );
	input[15:0] immed_in;
	output[31:0] ext_immed;
	assign ext_immed = { {16{immed_in[15]}}, immed_in };
endmodule
