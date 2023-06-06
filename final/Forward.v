module Forward(rst, rs, rt, wn1, wn2, WB1, WB2, f_rs, f_rt) ;

input rst ;
input [4:0] rs, rt, wn1, wn2 ;
input [1:0] WB1, WB2 ;
output reg [1:0] f_rs, f_rt ;

always@(rs or rt or rst) begin 
	if (rst) begin 
		f_rs <= 2'b0 ;
		f_rt <= 2'b0 ;
	end 
	if (WB1[1] && WB2[1]) begin 
		if (wn1 == wn2) begin 
			if (rs == wn1) f_rs <= 2'b01 ;
			if (rt == wn1) f_rt <= 2'b01 ;
		end 
		else begin 
			if (rs == wn1) f_rs <= 2'b01 ;
			if (rt == wn1) f_rt <= 2'b01 ;
			if (rs == wn2) f_rs <= 2'b10 ;
			if (rt == wn2) f_rt <= 2'b10 ;
		end 
	end 
	else if (WB1[1] && !WB2[1]) begin 
		if (rs == wn1) f_rs <= 2'b01 ;
		if (rt == wn1) f_rt <= 2'b01 ;
	end 
	else if (!WB1[1] && WB2[1]) begin 
		if (rs == wn2) f_rs <= 2'b10 ;
		if (rt == wn2) f_rt <= 2'b10 ;
	end 
	else begin 
		f_rs <= 2'b00 ;
		f_rt <= 2'b00 ;
	end 
end 

endmodule 