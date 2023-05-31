module mux3_1( sel, a, b, c, cout) ;

input [1:0] sel;
input [31:0] a, b, c;
output [31:0] cout ;

assign cout = (sel == 2'b0) ? a :
              (sel == 2'b01)? b :
			  (sel == 2'b10)? c : 32'bx;
			  
endmodule 