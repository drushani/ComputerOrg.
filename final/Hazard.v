module Hazard(clk, rst, rs, rt, rt2, memread, en_out1, en_out2, en_out3) ;

input clk, rst, memread;
input [4:0] rs, rt, rt2;
output reg en_out1, en_out2, en_out3;

always@(posedge clk) begin 
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
end 

endmodule 