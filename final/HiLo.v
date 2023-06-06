module HiLo( clk, op, MulAns, HiOut, LoOut, rst  );
input clk, rst ;
input [5:0] op ;
input [63:0] MulAns ;
output [31:0] HiOut ;
output [31:0] LoOut ;
reg [63:0] HiLo ;

parameter MULTU = 6'd25 ;
parameter MADDU = 6'd1  ;

always@( MulAns or rst )
begin
	if ( rst )
		HiLo = 64'b0 ;
	else if (op == MULTU) 
		HiLo = MulAns ;	
	else if (op == MADDU)
		HiLo = HiLo + MulAns ;
end

assign HiOut = HiLo[63:32] ;
assign LoOut = HiLo[31:0] ;


endmodule