module IF_ID(clk, rst, en_reg, pc_in, ins_in, pc_out, ins_out);

input clk, rst, en_reg;
input [31:0] pc_in, ins_in ;
output reg [31:0] pc_out, ins_out ;

always @(posedge clk) begin 
  if (rst) begin 
    pc_out <= 32'bx ;
	ins_out <= 32'bx ;
  end 
  else if (en_reg) begin 
	pc_out <= pc_in ;
	ins_out <= ins_in ;
  end 
  else begin 
	pc_out <= 32'b0 ;
	ins_out <= 32'b0;
  end 
end 

endmodule 