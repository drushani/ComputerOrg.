`timescale 1ns/1ns
module MUX( signal, ALUOut, HiOut, LoOut, ShifterOut, dataOut );
input [31:0] ALUOut ;
input [31:0] HiOut ;
input [31:0] LoOut ;
input [31:0] ShifterOut ;
input [5:0] signal ;
output [31:0] dataOut ;

parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;
parameter SRL = 6'b000010;
parameter MFHI= 6'b010000;
parameter MFLO= 6'b010010;

assign dataOut = ( signal[5] ) ? ALUOut :
                 ( signal[4] ) ? ( ( signal[1] ) ? LoOut : HiOut ) : ShifterOut ; 

endmodule