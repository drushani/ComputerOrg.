module multu_1bit(a, b, product) ;

input a;
input [63:0] b;
output [63:0] product ;

assign product = a ? b : 32'b0 ;

endmodule 