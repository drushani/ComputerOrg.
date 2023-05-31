/*
    每次posedge clk就代表要乘一次，總共要乘32次會得到最終答案
    每次看整個被乘數和乘數第0位去進行計算，做完計算後要讓被乘數向左移，然後乘數向右移
*/
module multiplier( clk, rst, signal, dataA, dataB, dataOut ) ;

input [31:0] dataA, dataB ;
input [2:0] signal ; 
input clk, rst ;
output reg [63:0] dataOut ;
reg [63:0] multiplicand ; // 被乘數
reg [31:0] multiplier ;   // 乘數
reg [63:0] product ;      // 積
reg [6:0] counter ;

parameter mul = 3'b100; 

always @( posedge clk or rst )
begin
  if ( rst ) begin 
    product <= 64'b0 ;
	multiplicand <= { 32'b0, dataA } ;
    multiplier <= dataB ;
	counter <= 7'b0 ;
  end 
  else if ( (signal == mul )&& (counter != 32)) begin
	if ( multiplier[0] == 1 ) product = product + multiplicand ; // 把sum加進product 
    multiplicand = { multiplicand[62:0], 1'b0 } ; // 左移(或說是乘與10)
    multiplier = { 1'b0, multiplier[31:1] } ;     // 右移
	counter = counter+1; 
	if ( counter == 32) assign dataOut = product ;
  end 
end

endmodule