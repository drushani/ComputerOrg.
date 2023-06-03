module Hazard(clk, rst, rs, rt, rt2, PCSrc, memread, en_out1, en_out2, en_out3) ;

input clk, rst, memread, PCSrc;
input [4:0] rs, rt, rt2;
output reg en_out1, en_out2, en_out3;

always@(memread or rst or PCSrc) begin 
	if (rst) begin 
		en_out1 <= 1'b1 ;
		en_out2 <= 1'b1 ;
		en_out3 <= 1'b1 ;
	end 
	else if (memread) begin 
		if (rs == rt2 || rt == rt2) begin 
			en_out1 <= 1'b0 ;
			en_out2 <= 1'b0 ;
			en_out3 <= 1'b0 ;
		end 
	end 
	else if (PCSrc) begin 
		en_out1 <= 1'b0 ;
		en_out2 <= 1'b0 ;
	end 
end 

endmodule 