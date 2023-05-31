module fa( dataA, dataB, cin, sum, cout ) ;

input dataA, dataB, cin ;
output sum, cout ;
wire w1, w2, w3, w4 ;

// sum
xor( w1, dataA, dataB ) ;
xor( sum, w1, cin ) ;

// cout 
or( w2, dataA, dataB ) ;
and( w3, w2, cin ) ;
and( w4, dataA, dataB ) ;
or( cout, w3, w4 ) ;

endmodule