`timescale 1ns/1ns
module ALU( signal, dataA, dataB, dataOut );

input [5:0] signal ;
input [31:0] dataA, dataB ;
output [31:0] dataOut ; // ¿é¥X

wire invertB, cin ;
wire [31:0] cout ; // carry
wire set ; // §PÂ_sltªº­È

parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;

assign cin = ( signal[1] ) ? 1 : 0 ;
assign invertB = ( signal[1] ) ? 1 : 0 ;

// 32bits ALU
ALU1bit alu1( .signal(signal), .inputA(dataA[0]), .inputB(dataB[0]), .invertB(invertB), .cin(cin), .cout(cout[0]), .dataOut(dataOut[0]), .less(set), .set() ) ;
ALU1bit alu2( .signal(signal), .inputA(dataA[1]), .inputB(dataB[1]), .invertB(invertB), .cin(cout[0]), .cout(cout[1]), .dataOut(dataOut[1]), .less(1'b0), .set() ) ;
ALU1bit alu3( .signal(signal), .inputA(dataA[2]), .inputB(dataB[2]), .invertB(invertB), .cin(cout[1]), .cout(cout[2]), .dataOut(dataOut[2]), .less(1'b0), .set() ) ;
ALU1bit alu4( .signal(signal), .inputA(dataA[3]), .inputB(dataB[3]), .invertB(invertB), .cin(cout[2]), .cout(cout[3]), .dataOut(dataOut[3]), .less(1'b0), .set() ) ;
ALU1bit alu5( .signal(signal), .inputA(dataA[4]), .inputB(dataB[4]), .invertB(invertB), .cin(cout[3]), .cout(cout[4]), .dataOut(dataOut[4]), .less(1'b0), .set() ) ;
ALU1bit alu6( .signal(signal), .inputA(dataA[5]), .inputB(dataB[5]), .invertB(invertB), .cin(cout[4]), .cout(cout[5]), .dataOut(dataOut[5]), .less(1'b0), .set() ) ;
ALU1bit alu7( .signal(signal), .inputA(dataA[6]), .inputB(dataB[6]), .invertB(invertB), .cin(cout[5]), .cout(cout[6]), .dataOut(dataOut[6]), .less(1'b0), .set() ) ;
ALU1bit alu8( .signal(signal), .inputA(dataA[7]), .inputB(dataB[7]), .invertB(invertB), .cin(cout[6]), .cout(cout[7]), .dataOut(dataOut[7]), .less(1'b0), .set() ) ;
ALU1bit alu9( .signal(signal), .inputA(dataA[8]), .inputB(dataB[8]), .invertB(invertB), .cin(cout[7]), .cout(cout[8]), .dataOut(dataOut[8]), .less(1'b0), .set() ) ;
ALU1bit alu10( .signal(signal), .inputA(dataA[9]), .inputB(dataB[9]), .invertB(invertB), .cin(cout[8]), .cout(cout[9]), .dataOut(dataOut[9]), .less(1'b0), .set() ) ;
ALU1bit alu11( .signal(signal), .inputA(dataA[10]), .inputB(dataB[10]), .invertB(invertB), .cin(cout[9]), .cout(cout[10]), .dataOut(dataOut[10]), .less(1'b0), .set() ) ;
ALU1bit alu12( .signal(signal), .inputA(dataA[11]), .inputB(dataB[11]), .invertB(invertB), .cin(cout[10]), .cout(cout[11]), .dataOut(dataOut[11]), .less(1'b0), .set() ) ;
ALU1bit alu13( .signal(signal), .inputA(dataA[12]), .inputB(dataB[12]), .invertB(invertB), .cin(cout[11]), .cout(cout[12]), .dataOut(dataOut[12]), .less(1'b0), .set() ) ;
ALU1bit alu14( .signal(signal), .inputA(dataA[13]), .inputB(dataB[13]), .invertB(invertB), .cin(cout[12]), .cout(cout[13]), .dataOut(dataOut[13]), .less(1'b0), .set() ) ;
ALU1bit alu15( .signal(signal), .inputA(dataA[14]), .inputB(dataB[14]), .invertB(invertB), .cin(cout[13]), .cout(cout[14]), .dataOut(dataOut[14]), .less(1'b0), .set() ) ;
ALU1bit alu16( .signal(signal), .inputA(dataA[15]), .inputB(dataB[15]), .invertB(invertB), .cin(cout[14]), .cout(cout[15]), .dataOut(dataOut[15]), .less(1'b0), .set() ) ;
ALU1bit alu17( .signal(signal), .inputA(dataA[16]), .inputB(dataB[16]), .invertB(invertB), .cin(cout[15]), .cout(cout[16]), .dataOut(dataOut[16]), .less(1'b0), .set() ) ;
ALU1bit alu18( .signal(signal), .inputA(dataA[17]), .inputB(dataB[17]), .invertB(invertB), .cin(cout[16]), .cout(cout[17]), .dataOut(dataOut[17]), .less(1'b0), .set() ) ;
ALU1bit alu19( .signal(signal), .inputA(dataA[18]), .inputB(dataB[18]), .invertB(invertB), .cin(cout[17]), .cout(cout[18]), .dataOut(dataOut[18]), .less(1'b0), .set() ) ;
ALU1bit alu20( .signal(signal), .inputA(dataA[19]), .inputB(dataB[19]), .invertB(invertB), .cin(cout[18]), .cout(cout[19]), .dataOut(dataOut[19]), .less(1'b0), .set() ) ;
ALU1bit alu21( .signal(signal), .inputA(dataA[20]), .inputB(dataB[20]), .invertB(invertB), .cin(cout[19]), .cout(cout[20]), .dataOut(dataOut[20]), .less(1'b0), .set() ) ;
ALU1bit alu22( .signal(signal), .inputA(dataA[21]), .inputB(dataB[21]), .invertB(invertB), .cin(cout[20]), .cout(cout[21]), .dataOut(dataOut[21]), .less(1'b0), .set() ) ;
ALU1bit alu23( .signal(signal), .inputA(dataA[22]), .inputB(dataB[22]), .invertB(invertB), .cin(cout[21]), .cout(cout[22]), .dataOut(dataOut[22]), .less(1'b0), .set() ) ;
ALU1bit alu24( .signal(signal), .inputA(dataA[23]), .inputB(dataB[23]), .invertB(invertB), .cin(cout[22]), .cout(cout[23]), .dataOut(dataOut[23]), .less(1'b0), .set() ) ;
ALU1bit alu25( .signal(signal), .inputA(dataA[24]), .inputB(dataB[24]), .invertB(invertB), .cin(cout[23]), .cout(cout[24]), .dataOut(dataOut[24]), .less(1'b0), .set() ) ;
ALU1bit alu26( .signal(signal), .inputA(dataA[25]), .inputB(dataB[25]), .invertB(invertB), .cin(cout[24]), .cout(cout[25]), .dataOut(dataOut[25]), .less(1'b0), .set() ) ;
ALU1bit alu27( .signal(signal), .inputA(dataA[26]), .inputB(dataB[26]), .invertB(invertB), .cin(cout[25]), .cout(cout[26]), .dataOut(dataOut[26]), .less(1'b0), .set() ) ;
ALU1bit alu28( .signal(signal), .inputA(dataA[27]), .inputB(dataB[27]), .invertB(invertB), .cin(cout[26]), .cout(cout[27]), .dataOut(dataOut[27]), .less(1'b0), .set() ) ;
ALU1bit alu29( .signal(signal), .inputA(dataA[28]), .inputB(dataB[28]), .invertB(invertB), .cin(cout[27]), .cout(cout[28]), .dataOut(dataOut[28]), .less(1'b0), .set() ) ;
ALU1bit alu30( .signal(signal), .inputA(dataA[29]), .inputB(dataB[29]), .invertB(invertB), .cin(cout[28]), .cout(cout[29]), .dataOut(dataOut[29]), .less(1'b0), .set() ) ;
ALU1bit alu31( .signal(signal), .inputA(dataA[30]), .inputB(dataB[30]), .invertB(invertB), .cin(cout[29]), .cout(cout[30]), .dataOut(dataOut[30]), .less(1'b0), .set() ) ;
ALU1bit alu32( .signal(signal), .inputA(dataA[31]), .inputB(dataB[31]), .invertB(invertB), .cin(cout[30]), .cout(cout[31]), .dataOut(dataOut[31]), .less(1'b0), .set(set) ) ;

endmodule