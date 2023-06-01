module unsign_extend(immed_in_un, ext_immed_un ) ;
	input[15:0] immed_in_un;
	output[31:0] ext_immed_un;
	assign ext_immed_un = { 16'b0, immed_in_un };
endmodule