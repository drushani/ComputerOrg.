module MEM_WB( clk, rst, W_in, RD_in, ADDR_in, WN_in, 
                         W_out, RD_out, ADDR_out, WN_out) ;
						 
input clk, rst ;
input [1:0] W_in;
input [31:0] RD_in, ADDR_in ;
input [4:0] WN_in ;
output reg [1:0] W_out;
output reg [31:0] RD_out, ADDR_out ;
output reg [4:0] WN_out ;

always@(posedge clk or rst ) begin
  if (rst) begin
    W_out <= 2'b0 ;
	RD_out <= 32'b0 ;
	ADDR_out <= 32'b0 ;
	WN_out <= 5'b0 ;
  end 
  else begin 
    W_out <= W_in ;
	RD_out <= RD_in;
	ADDR_out <= ADDR_in ;
	WN_out <= WN_in ;
  end 
end 

endmodule 