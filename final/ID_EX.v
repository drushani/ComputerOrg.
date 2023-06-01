module ID_EX(clk, rst, W_in, M_in, E_in, rd1_in, rd2_in, funct_in, shamt_in, immed_in, rt_in, rd_in, 
                       W_out, M_out, E_out, rd1_out, rd2_out, funct_out, shamt_out, immed_out, rt_out, rd_out) ;

input clk, rst ;
input [1:0] W_in, M_in ;
input [3:0] E_in ;
input [31:0] rd1_in, rd2_in ;
input [5:0] funct_in ;
input [4:0] shamt_in ;
input [31:0] immed_in ;
input [4:0] rt_in, rd_in ; 

output reg [1:0] W_out, M_out ;
output reg [3:0] E_out ;
output reg [31:0] rd1_out, rd2_out ;
output reg [5:0] funct_out ;
output reg [4:0] shamt_out ;
output reg [31:0] immed_out ;
output reg [4:0] rt_out, rd_out ; // writeback要用的

always @(posedge clk) begin 
  if (rst) begin 
    W_out <= 2'b0 ;
	M_out <= 2'b0 ;
	E_out <= 4'b0 ;
    rd1_out <= 32'b0 ;
	rd2_out <= 32'b0 ;
    funct_out <= 6'b0 ;
    shamt_out <= 5'b0 ;
	immed_out <= 16'b0 ;
	rt_out <= 5'b0 ;
	rd_out <= 5'b0 ;
  end 
  else begin 
    W_out <= W_in ;
	M_out <= M_in ;
	E_out <= E_in ;
    rd1_out <= rd1_in ;
	rd2_out <= rd2_in ;
    funct_out <= funct_in ;
    shamt_out <= shamt_in ;
	immed_out <= immed_in ;
	rt_out <= rt_in ;
	rd_out <= rd_in ;
  end 
end 

endmodule 