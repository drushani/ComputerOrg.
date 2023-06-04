module ID_EX(clk, rst, W_in, M_in, E_in, rd1_in, rd2_in, funct_in, shamt_in, immed_in, 
                       rs_in, rt_in, rd_in, b_offset_in, branch_in ,
                       W_out, M_out, E_out, rd1_out, rd2_out, funct_out, shamt_out, immed_out, 
					   rs_out, rt_out, rd_out, b_offset_out, branch_out) ;

input clk, rst, branch_in ;
input [1:0] W_in, M_in ;
input [3:0] E_in ;
input [31:0] rd1_in, rd2_in, b_offset_in ;
input [5:0] funct_in ;
input [4:0] shamt_in ;
input [31:0] immed_in ;
input [4:0] rs_in, rt_in, rd_in ; 

output reg branch_out;
output reg [1:0] W_out, M_out ;
output reg [3:0] E_out ;
output reg [31:0] rd1_out, rd2_out, b_offset_out ;
output reg [5:0] funct_out ;
output reg [4:0] shamt_out ;
output reg [31:0] immed_out ;
output reg [4:0] rs_out, rt_out, rd_out ; 

always @(posedge clk) begin 
  if (rst) begin 
    W_out <= 2'bx ;
	M_out <= 2'bx ;
	E_out <= 4'bx ;
    rd1_out <= 32'bx ;
	rd2_out <= 32'bx ;
    funct_out <= 6'bx ;
    shamt_out <= 5'bx ;
	immed_out <= 16'bx ;
	rs_out <= 5'bx ;
	rt_out <= 5'bx ;
	rd_out <= 5'bx ;
	b_offset_out <= 32'bx;
	branch_out <= 1'bx;
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
	rs_out <= rs_in;
	rt_out <= rt_in ;
	rd_out <= rd_in ;
	b_offset_out <= b_offset_in ;
	branch_out <= branch_in;
  end 
end 

endmodule 