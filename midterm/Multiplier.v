`timescale 1ns/1ns
module Multiplier( clk, signal, dataA, dataB, dataOut, reset ) ;

input [31:0] dataA, dataB ;
input [5:0] signal ;
input clk, reset ;
output [63:0] dataOut ;
reg [63:0] multiplicand ; // 被乘數
reg [31:0] multiplier ;   // 乘數
reg [63:0] product ;      // 積

parameter MULTU = 6'b011001 ;

/*
每次posedge clk就代表要乘一次，總共要乘32次會得到最終答案
每次看整個被乘數和乘數第0位去進行計算，做完計算後要讓被乘數向左移，然後乘數向右移
*/
always @( posedge clk or reset )
begin
  if ( reset )
  begin 
    product = 64'b0 ;
	multiplicand = { 32'b0, dataA } ;
    multiplier = dataB ;
  end 
  else if ( signal == MULTU )
  begin
	if ( multiplier[0] == 1 )
	begin 
	  product = product + multiplicand ; // 把sum加進product
	end 
    multiplicand = { multiplicand[62:0], 1'b0 } ; // 左移(或說是乘與10)
    multiplier = { 1'b0, multiplier[31:1] } ;     // 右移
  end 
end

assign dataOut = product ;

endmodule