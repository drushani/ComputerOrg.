module HiLo( clk, op, MulAns, HiOut, LoOut, rst  );
input clk, rst ;
input [5:0] op ;
input [63:0] MulAns ;
output [31:0] HiOut ;
output [31:0] LoOut ;
reg [63:0] HiLo ;

parameter MULTU = 6'd1 ;
parameter MADDU = 6'd28;

always@( MulAns or rst )
begin
	if ( rst )
	begin
		HiLo = 64'b0 ;
	end
	else if (op == MULTU) 
	begin 
		HiLo = MulAns ;	
	end 
	HiLo = HiLo + MulAns ;
end

assign HiOut = HiLo[63:32] ;
assign LoOut = HiLo[31:0] ;


endmodule