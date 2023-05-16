`timescale 1ns/1ns
module TotalALU( clk, dataA, dataB, signal, Output );

input clk ;
input [31:0] dataA ;   // inputA
input [31:0] dataB ;   // inputB
input [5:0] signal ;   // control signal
output [31:0] Output ;    // output
wire rst ;
wire [5:0]  signaltoALU ;
wire [5:0]  signaltoSHT ;
wire [5:0]  signaltoMTP ;
wire [5:0]  signaltoMUX ;
wire [31:0] ALUOut, HiOut, LoOut, ShifterOut ;
wire [63:0] MTPAns ;
wire [31:0] dataOut ;

/*
因為主程式的clk一直在一上一下，而我們設定訊號在上的時候進入TotalALU()
先是進ALUControl()看說現在要執行的signal是什麼，如果是ALU或Shifter的就會在ALUControl()中直接給他
若是乘法器的訊號，會在ALUControl()中給6'b111111，而每次進入TotalALU()都會進入一次HiLo()把答案存起來
*/
ALUControl ALUControl( .clk(clk), .reset(rst), .signal(signal), .signaltoALU(signaltoALU), .signaltoSHT(signaltoSHT), .signaltoMTP(signaltoMTP), .signaltoMUX(signaltoMUX) );
ALU ALU( .signal(signaltoALU), .dataA(dataA), .dataB(dataB), .dataOut(ALUOut) );
Multiplier Multiplier( .clk(clk), .signal(signaltoMTP), .dataA(dataA), .dataB(dataB), .dataOut(MTPAns), .reset(rst) ) ;
HiLo HiLo( .clk(clk), .MTPAns(MTPAns), .HiOut(HiOut), .LoOut(LoOut), .reset(rst) );
Shifter Shifter( .signal(signaltoSHT), .dataA(dataA), .dataB(dataB), .dataOut(ShifterOut) );
MUX MUX( .signal(signaltoMUX), .ALUOut(ALUOut), .HiOut(HiOut), .LoOut(LoOut), .ShifterOut(ShifterOut), .dataOut(dataOut) );

assign Output = dataOut ;

endmodule