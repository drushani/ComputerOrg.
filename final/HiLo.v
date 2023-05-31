`timescale 1ns/1ns
module HiLo( clk, MTPAns, HiOut, LoOut, rst );
input clk ;
input rst ;
input [63:0] MTPAns ;
output [31:0] HiOut ;
output [31:0] LoOut ;
reg [63:0] HiLo ;

always@( posedge clk or rst )
begin
  if ( rst )
  begin
    HiLo = 64'b0 ;
  end
  else
  begin
    HiLo = MTPAns ;
  end
end

assign HiOut = HiLo[63:32] ;
assign LoOut = HiLo[31:0] ;

endmodule