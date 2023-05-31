module alu_1bit( signal, dataA, dataB, invertB, cin, cout, dataOut, less, set ) ;

input [2:0] signal ;
input dataA, dataB, invertB, cin, less ;
output cout, dataOut, set ; 
wire newdataB, and_ans, or_ans ;

and( and_ans, dataA, dataB ) ; 
or( or_ans, dataA, dataB ) ; 

xor( newdataB, dataB, invertB ) ;
fa fa( .dataA(dataA), .dataB(newdataB), .cin(cin), .sum(set), .cout(cout) ) ;

mux4_1 mux4_1( .signal(signal), .and_ans(and_ans), .or_ans(or_ans), .set(set), .less(less), .dataOut(dataOut) ) ;
			 
endmodule