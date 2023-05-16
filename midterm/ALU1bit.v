`timescale 1ns/1ns
module ALU1bit( signal, inputA, inputB, invertB, cin, cout, dataOut, less, set ) ;

input [5:0] signal ;
input inputA, inputB, invertB, cin, less ;
output cout, dataOut, set ; // 最後一個set會拿來判斷是正是負，所以直接當作FA的sum 
                            // 因為如果A比B小，最後一個CarryOut會是0，而這時Sum會是1
							// 所以直接利用Sum就可以判斷了
wire AndSum, OrSum ;
wire newInputB ;

// AND
and( AndSum, inputA, inputB ) ; 

// OR
or( OrSum, inputA, inputB ) ; 

// 加減法
xor( newInputB, inputB, invertB ) ;
FA FA( .inputA(inputA), .inputB(newInputB), .cin(cin), .sum(set), .cout(cout) ) ;

// 多工器選擇區(利用三元運算子)
MUX_ALU MUX_ALU( .signal(signal), .OrSum(OrSum), .AndSum(AndSum), .AddSubSum(set), .Slt(less), .dataOut(dataOut) ) ;
			 
endmodule