module alu( signal, dataA, dataB, dataOut, shamt, zero );

input [2:0] signal ;
input [31:0] dataA, dataB ;
input [4:0] shamt ;
output [31:0] dataOut ; 
output zero ;

wire invertB, cin, set ;
wire [31:0] srl_ans, temp, cout ;
assign cin = ( signal[2] ) ? 1 : 0 ;
assign invertB = ( signal[2] ) ? 1 : 0 ;

alu_1bit alu1( .signal(signal), .dataA(dataA[0]), .dataB(dataB[0]), .invertB(invertB), .cin(cin), .cout(cout[0]), .dataOut(temp[0]), .less(set), .set() ) ;
alu_1bit alu2( .signal(signal), .dataA(dataA[1]), .dataB(dataB[1]), .invertB(invertB), .cin(cout[0]), .cout(cout[1]), .dataOut(temp[1]), .less(1'b0), .set() ) ;
alu_1bit alu3( .signal(signal), .dataA(dataA[2]), .dataB(dataB[2]), .invertB(invertB), .cin(cout[1]), .cout(cout[2]), .dataOut(temp[2]), .less(1'b0), .set() ) ;
alu_1bit alu4( .signal(signal), .dataA(dataA[3]), .dataB(dataB[3]), .invertB(invertB), .cin(cout[2]), .cout(cout[3]), .dataOut(temp[3]), .less(1'b0), .set() ) ;
alu_1bit alu5( .signal(signal), .dataA(dataA[4]), .dataB(dataB[4]), .invertB(invertB), .cin(cout[3]), .cout(cout[4]), .dataOut(temp[4]), .less(1'b0), .set() ) ;
alu_1bit alu6( .signal(signal), .dataA(dataA[5]), .dataB(dataB[5]), .invertB(invertB), .cin(cout[4]), .cout(cout[5]), .dataOut(temp[5]), .less(1'b0), .set() ) ;
alu_1bit alu7( .signal(signal), .dataA(dataA[6]), .dataB(dataB[6]), .invertB(invertB), .cin(cout[5]), .cout(cout[6]), .dataOut(temp[6]), .less(1'b0), .set() ) ;
alu_1bit alu8( .signal(signal), .dataA(dataA[7]), .dataB(dataB[7]), .invertB(invertB), .cin(cout[6]), .cout(cout[7]), .dataOut(temp[7]), .less(1'b0), .set() ) ;
alu_1bit alu9( .signal(signal), .dataA(dataA[8]), .dataB(dataB[8]), .invertB(invertB), .cin(cout[7]), .cout(cout[8]), .dataOut(temp[8]), .less(1'b0), .set() ) ;
alu_1bit alu10( .signal(signal), .dataA(dataA[9]), .dataB(dataB[9]), .invertB(invertB), .cin(cout[8]), .cout(cout[9]), .dataOut(temp[9]), .less(1'b0), .set() ) ;
alu_1bit alu11( .signal(signal), .dataA(dataA[10]), .dataB(dataB[10]), .invertB(invertB), .cin(cout[9]), .cout(cout[10]), .dataOut(temp[10]), .less(1'b0), .set() ) ;
alu_1bit alu12( .signal(signal), .dataA(dataA[11]), .dataB(dataB[11]), .invertB(invertB), .cin(cout[10]), .cout(cout[11]), .dataOut(temp[11]), .less(1'b0), .set() ) ;
alu_1bit alu13( .signal(signal), .dataA(dataA[12]), .dataB(dataB[12]), .invertB(invertB), .cin(cout[11]), .cout(cout[12]), .dataOut(temp[12]), .less(1'b0), .set() ) ;
alu_1bit alu14( .signal(signal), .dataA(dataA[13]), .dataB(dataB[13]), .invertB(invertB), .cin(cout[12]), .cout(cout[13]), .dataOut(temp[13]), .less(1'b0), .set() ) ;
alu_1bit alu15( .signal(signal), .dataA(dataA[14]), .dataB(dataB[14]), .invertB(invertB), .cin(cout[13]), .cout(cout[14]), .dataOut(temp[14]), .less(1'b0), .set() ) ;
alu_1bit alu16( .signal(signal), .dataA(dataA[15]), .dataB(dataB[15]), .invertB(invertB), .cin(cout[14]), .cout(cout[15]), .dataOut(temp[15]), .less(1'b0), .set() ) ;
alu_1bit alu17( .signal(signal), .dataA(dataA[16]), .dataB(dataB[16]), .invertB(invertB), .cin(cout[15]), .cout(cout[16]), .dataOut(temp[16]), .less(1'b0), .set() ) ;
alu_1bit alu18( .signal(signal), .dataA(dataA[17]), .dataB(dataB[17]), .invertB(invertB), .cin(cout[16]), .cout(cout[17]), .dataOut(temp[17]), .less(1'b0), .set() ) ;
alu_1bit alu19( .signal(signal), .dataA(dataA[18]), .dataB(dataB[18]), .invertB(invertB), .cin(cout[17]), .cout(cout[18]), .dataOut(temp[18]), .less(1'b0), .set() ) ;
alu_1bit alu20( .signal(signal), .dataA(dataA[19]), .dataB(dataB[19]), .invertB(invertB), .cin(cout[18]), .cout(cout[19]), .dataOut(temp[19]), .less(1'b0), .set() ) ;
alu_1bit alu21( .signal(signal), .dataA(dataA[20]), .dataB(dataB[20]), .invertB(invertB), .cin(cout[19]), .cout(cout[20]), .dataOut(temp[20]), .less(1'b0), .set() ) ;
alu_1bit alu22( .signal(signal), .dataA(dataA[21]), .dataB(dataB[21]), .invertB(invertB), .cin(cout[20]), .cout(cout[21]), .dataOut(temp[21]), .less(1'b0), .set() ) ;
alu_1bit alu23( .signal(signal), .dataA(dataA[22]), .dataB(dataB[22]), .invertB(invertB), .cin(cout[21]), .cout(cout[22]), .dataOut(temp[22]), .less(1'b0), .set() ) ;
alu_1bit alu24( .signal(signal), .dataA(dataA[23]), .dataB(dataB[23]), .invertB(invertB), .cin(cout[22]), .cout(cout[23]), .dataOut(temp[23]), .less(1'b0), .set() ) ;
alu_1bit alu25( .signal(signal), .dataA(dataA[24]), .dataB(dataB[24]), .invertB(invertB), .cin(cout[23]), .cout(cout[24]), .dataOut(temp[24]), .less(1'b0), .set() ) ;
alu_1bit alu26( .signal(signal), .dataA(dataA[25]), .dataB(dataB[25]), .invertB(invertB), .cin(cout[24]), .cout(cout[25]), .dataOut(temp[25]), .less(1'b0), .set() ) ;
alu_1bit alu27( .signal(signal), .dataA(dataA[26]), .dataB(dataB[26]), .invertB(invertB), .cin(cout[25]), .cout(cout[26]), .dataOut(temp[26]), .less(1'b0), .set() ) ;
alu_1bit alu28( .signal(signal), .dataA(dataA[27]), .dataB(dataB[27]), .invertB(invertB), .cin(cout[26]), .cout(cout[27]), .dataOut(temp[27]), .less(1'b0), .set() ) ;
alu_1bit alu29( .signal(signal), .dataA(dataA[28]), .dataB(dataB[28]), .invertB(invertB), .cin(cout[27]), .cout(cout[28]), .dataOut(temp[28]), .less(1'b0), .set() ) ;
alu_1bit alu30( .signal(signal), .dataA(dataA[29]), .dataB(dataB[29]), .invertB(invertB), .cin(cout[28]), .cout(cout[29]), .dataOut(temp[29]), .less(1'b0), .set() ) ;
alu_1bit alu31( .signal(signal), .dataA(dataA[30]), .dataB(dataB[30]), .invertB(invertB), .cin(cout[29]), .cout(cout[30]), .dataOut(temp[30]), .less(1'b0), .set() ) ;
alu_1bit alu32( .signal(signal), .dataA(dataA[31]), .dataB(dataB[31]), .invertB(invertB), .cin(cout[30]), .cout(cout[31]), .dataOut(temp[31]), .less(1'b0), .set(set) ) ;

shifter shifter(.dataA(dataB), .dataB(shamt), .dataOut(srl_ans) ) ;

assign dataOut = (signal == 3'b011)? srl_ans : temp ;
assign zero = (temp == 0) ? 1:0;

endmodule