module EX_MEM(clk, rst, W_in, M_in, ALU_in, RD2_in, WN_in, 
                        W_out, M_out, ALU_out, RD2_out, WN_out) ;

input clk, rst ;
input [1:0] W_in, M_in ;
input [31:0] ALU_in, RD2_in ;
input [4:0] WN_in ;
output reg [1:0] W_out, M_out ;
output reg [31:0] ALU_out, RD2_out ;
output reg [4:0] WN_out ;

always @(posedge clk or rst ) begin 
  if (rst) begin 
    W_out <= 2'b0;
	M_out <= 2'b0 ;
	ALU_out <= 32'b0 ;
	RD2_out <= 32'b0 ;
	WN_out <= 5'b0 ;
  end 
  else begin 
    W_out <= W_in ;
	M_out <= M_in ;
	ALU_out <= ALU_in ;
	RD2_out <= RD2_in ;
	WN_out <= WN_in ;
  end 
end 

endmodule 