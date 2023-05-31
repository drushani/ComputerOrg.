`timescale 1ns/1ns
module FA( inputA, inputB, cin, sum, cout ) ;

input inputA, inputB, cin ;
output sum, cout ; 
wire w1, w2, w3, w4 ;

// sum
xor( w1, inputA, inputB ) ;
xor( sum, w1, cin ) ;

// cout 
or( w2, inputA, inputB ) ;
and( w3, w2, cin ) ;
and( w4, inputA, inputB ) ;
or( cout, w3, w4 ) ;

endmodule
