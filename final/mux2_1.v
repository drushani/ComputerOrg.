module mux2_1( signal, a, b, cout ) ;

input a, b, signal ;
output cout ;

assign cout = signal? a:b ;

endmodule 