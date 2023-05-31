module  mux4_1( signal, and_ans, or_ans, set, less, dataOut );

input [2:0] signal ;
input and_ans, or_ans, set, less ;
output dataOut ;

// and: 000
// or : 001
// add: 010
// sub: 110
// slt: 111

assign dataOut = (signal == 3'b000) ? and_ans :
                 (signal == 3'b001) ? or_ans :
                 (signal == 3'b010 || signal == 3'b110) ? set :
				 (signal == 3'b111) ? less : 1'bx ;

endmodule