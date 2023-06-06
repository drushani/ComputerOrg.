/*
    每次posedge clk就代表要乘一次，總共要乘32次會得到最終答案
    每次看整個被乘數和乘數第0位去進行計算，做完計算後要讓被乘數向左移，然後乘數向右移
*/
module multiplier( clk, rst, signal, dataA, dataB, dataOut ) ;

input [31:0] dataA, dataB ;
input [2:0] signal ; 
input clk, rst ;
output  [63:0] dataOut ;
wire [63:0] multiplicand ; // 被乘數
wire [31:0] multiplier ;   // 乘數
reg [63:0] product ;      // 積

wire [63:0] temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10,
            temp11, temp12, temp13, temp14, temp15, temp16, temp17, temp18, temp19,
			temp20, temp21, temp22, temp23, temp24, temp25, temp26, temp27, temp28,
			temp29, temp30, temp31, temp32 ;
			
wire [63:0] ans1, ans2, ans3, ans4, ans5, ans6, ans7, ans8, ans9, ans10,
            ans11, ans12, ans13, ans14, ans15, ans16, ans17, ans18, ans19, 
			ans20, ans21, ans22, ans23, ans24, ans25, ans26, ans27, ans28,
			ans29, ans30, ans31, ans32;
			
parameter mul = 3'b100; 

// initial set 
assign multiplicand = { 32'b0, dataA } ;
assign multiplier = dataB ;

assign temp1 = multiplicand;
assign temp2 = {multiplicand[62:0], 1'b0};
assign temp3 = {multiplicand[61:0], 2'b0};
assign temp4 = {multiplicand[60:0], 3'b0};
assign temp5 = {multiplicand[59:0], 4'b0};
assign temp6 = {multiplicand[58:0], 5'b0};
assign temp7 = {multiplicand[57:0], 6'b0};
assign temp8 = {multiplicand[56:0], 7'b0};
assign temp9 = {multiplicand[55:0], 8'b0};
assign temp10 = {multiplicand[54:0], 9'b0};
assign temp11 = {multiplicand[53:0], 10'b0};
assign temp12 = {multiplicand[52:0], 11'b0};
assign temp13 = {multiplicand[51:0], 12'b0};
assign temp14 = {multiplicand[50:0], 13'b0};
assign temp15 = {multiplicand[49:0], 14'b0};
assign temp16 = {multiplicand[48:0], 15'b0};
assign temp17 = {multiplicand[47:0], 16'b0};
assign temp18 = {multiplicand[46:0], 17'b0};
assign temp19 = {multiplicand[45:0], 18'b0};
assign temp20 = {multiplicand[44:0], 19'b0};
assign temp21 = {multiplicand[43:0], 20'b0};
assign temp22 = {multiplicand[42:0], 21'b0};
assign temp23 = {multiplicand[41:0], 22'b0};
assign temp24 = {multiplicand[40:0], 23'b0};
assign temp25 = {multiplicand[39:0], 24'b0};
assign temp26 = {multiplicand[38:0], 25'b0};
assign temp27 = {multiplicand[37:0], 26'b0};
assign temp28 = {multiplicand[36:0], 27'b0};
assign temp29 = {multiplicand[35:0], 28'b0};
assign temp30 = {multiplicand[34:0], 29'b0};
assign temp31 = {multiplicand[33:0], 30'b0};
assign temp32 = {multiplicand[32:0], 31'b0};

// mul 32 bits 
multu_1bit mul1(.a(multiplier[0]), .b(temp1), .product(ans1));
multu_1bit mul2(.a(multiplier[1]), .b(temp2), .product(ans2));
multu_1bit mul3(.a(multiplier[2]), .b(temp3), .product(ans3));
multu_1bit mul4(.a(multiplier[3]), .b(temp4), .product(ans4));
multu_1bit mul5(.a(multiplier[4]), .b(temp5), .product(ans5));
multu_1bit mul6(.a(multiplier[5]), .b(temp6), .product(ans6));
multu_1bit mul7(.a(multiplier[6]), .b(temp7), .product(ans7));
multu_1bit mul8(.a(multiplier[7]), .b(temp8), .product(ans8));
multu_1bit mul9(.a(multiplier[8]), .b(temp9), .product(ans9));
multu_1bit mul10(.a(multiplier[9]), .b(temp10), .product(ans10));
multu_1bit mul11(.a(multiplier[10]), .b(temp11), .product(ans11));
multu_1bit mul12(.a(multiplier[11]), .b(temp12), .product(ans12));
multu_1bit mul13(.a(multiplier[12]), .b(temp13), .product(ans13));
multu_1bit mul14(.a(multiplier[13]), .b(temp14), .product(ans14));
multu_1bit mul15(.a(multiplier[14]), .b(temp15), .product(ans15));
multu_1bit mul16(.a(multiplier[15]), .b(temp16), .product(ans16));
multu_1bit mul17(.a(multiplier[16]), .b(temp17), .product(ans17));
multu_1bit mul18(.a(multiplier[17]), .b(temp18), .product(ans18));
multu_1bit mul19(.a(multiplier[18]), .b(temp19), .product(ans19));
multu_1bit mul20(.a(multiplier[19]), .b(temp20), .product(ans20));
multu_1bit mul21(.a(multiplier[20]), .b(temp21), .product(ans21));
multu_1bit mul22(.a(multiplier[21]), .b(temp22), .product(ans22));
multu_1bit mul23(.a(multiplier[22]), .b(temp23), .product(ans23));
multu_1bit mul24(.a(multiplier[23]), .b(temp24), .product(ans24));
multu_1bit mul25(.a(multiplier[24]), .b(temp25), .product(ans25));
multu_1bit mul26(.a(multiplier[25]), .b(temp26), .product(ans26));
multu_1bit mul27(.a(multiplier[26]), .b(temp27), .product(ans27));
multu_1bit mul28(.a(multiplier[27]), .b(temp28), .product(ans28));
multu_1bit mul29(.a(multiplier[28]), .b(temp29), .product(ans29));
multu_1bit mul30(.a(multiplier[29]), .b(temp30), .product(ans30));
multu_1bit mul31(.a(multiplier[30]), .b(temp31), .product(ans31));
multu_1bit mul32(.a(multiplier[31]), .b(temp32), .product(ans32));

always @( posedge clk or rst )
begin
	if (rst) product <= 64'b0 ;
	if (signal == mul) begin 
		product =  ans1 + ans2 + ans3 + ans4 + ans5 + ans6 + ans7 + ans8 +
		           ans9 + ans10+ ans11+ ans12+ ans13+ ans14+ ans15+ ans16+
				   ans17+ ans18+ ans19+ ans20+ ans21+ ans22+ ans23+ ans24+
				   ans25+ ans26+ ans27+ ans28+ ans29+ ans30+ ans31+ ans32;
	end 
end

assign dataOut = product ;

endmodule