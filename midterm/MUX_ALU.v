`timescale 1ns/1ns
module  MUX_ALU( signal, OrSum, AndSum, AddSubSum, Slt, dataOut );

input [5:0] signal ;
input OrSum, AndSum, AddSubSum, Slt ;
output dataOut ;

parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;

assign dataOut = ( signal[2] ) ? ( ( signal[0] ) ? OrSum : AndSum ) : ( ( signal[3] ) ? Slt : AddSubSum ) ;

endmodule