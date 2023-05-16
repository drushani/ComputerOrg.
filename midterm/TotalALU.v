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
�]���D�{����clk�@���b�@�W�@�U�A�ӧڭ̳]�w�T���b�W���ɭԶi�JTotalALU()
���O�iALUControl()�ݻ��{�b�n���檺signal�O����A�p�G�OALU��Shifter���N�|�bALUControl()���������L
�Y�O���k�����T���A�|�bALUControl()����6'b111111�A�ӨC���i�JTotalALU()���|�i�J�@��HiLo()�⵪�צs�_��
*/
ALUControl ALUControl( .clk(clk), .reset(rst), .signal(signal), .signaltoALU(signaltoALU), .signaltoSHT(signaltoSHT), .signaltoMTP(signaltoMTP), .signaltoMUX(signaltoMUX) );
ALU ALU( .signal(signaltoALU), .dataA(dataA), .dataB(dataB), .dataOut(ALUOut) );
Multiplier Multiplier( .clk(clk), .signal(signaltoMTP), .dataA(dataA), .dataB(dataB), .dataOut(MTPAns), .reset(rst) ) ;
HiLo HiLo( .clk(clk), .MTPAns(MTPAns), .HiOut(HiOut), .LoOut(LoOut), .reset(rst) );
Shifter Shifter( .signal(signaltoSHT), .dataA(dataA), .dataB(dataB), .dataOut(ShifterOut) );
MUX MUX( .signal(signaltoMUX), .ALUOut(ALUOut), .HiOut(HiOut), .LoOut(LoOut), .ShifterOut(ShifterOut), .dataOut(dataOut) );

assign Output = dataOut ;

endmodule