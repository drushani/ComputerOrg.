`timescale 1ns/1ns
module ALUControl( clk, reset, signal, signaltoALU, signaltoSHT, signaltoMTP, signaltoMUX ) ;

input clk ;
input [5:0] signal ;
output [5:0] signaltoALU, signaltoSHT, signaltoMTP, signaltoMUX;
output reset ;
reg [6:0] counter ;
reg [5:0] temp ; // 用來暫存訊號
reg rst ;

parameter MULTU = 6'b011001 ;

// signal一旦改變才會進入always裡面
always @( signal )
begin
  if ( signal == MULTU )
  begin
    counter = 0 ; // initial
	rst = 1 ;
  end
end

/*
一旦clk出現上升一次，代表有訊號輸入一次
如果訊號是乘法器的，輸入32次之後就要把結果輸入HiLo裡面
如果是Add, Sub, And, Or, Slt等訊號就不會進入if()條件句
所以signaltoALU就會是其中一種的訊號
或是Srl，就會是signaltoSHT的一種訊號
*/
always @( posedge clk )
begin
  temp = signal ;
  if ( signal == MULTU )
  begin
	if ( counter != 0 )
	  rst = 0 ;
  
    counter = counter + 1 ;
	if ( counter >= 32 )
	begin
	  temp = 6'b111111 ; // 不再有訊號去做運算
	end
  end
end

/*
指令除了要給執行的地方以外，也要給多工器看
這樣才可以知道最終要輸出的結果是什麼
*/
assign signaltoALU = temp ;
assign signaltoMTP = temp ;
assign signaltoSHT = temp ;
assign signaltoMUX = temp ;

assign reset = rst ;

endmodule