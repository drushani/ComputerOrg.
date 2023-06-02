module Forward(rst, rs, rt, wn1, wn2, WB1, WB2, f_rs, f_rt) ;

input rst ;
input [4:0] rs, rt, wn1, wn2 ;
input [1:0] WB1, WB2 ;
output reg [1:0] f_rs, f_rt ;

always @( rs or rt or rst ) begin 
	if (rst) begin 
		f_rs <= 2'b0 ;
		f_rt <= 2'b0 ;
	end 
	else begin
		if (WB1[0] == 0) begin 
			if (wn1 == rs) f_rs <= 2'b01 ;
			else f_rs <= 2'b0 ;
			if (wn1 == rt ) f_rt <= 2'b01 ;
			else f_rt <= 2'b0 ;
		end 
		else if (WB1[0] == 1) begin 
			if (wn1 == rs) f_rs <= 2'b01 ;
			else f_rs <= 2'b0 ;
			if (wn1 == rt) f_rt <= 2'b01 ;
			else f_rt <= 2'b0 ;
		end 
		if (WB2 == 2'b0 ) begin 
		
		end 
		else if (WB2[0] == 0) begin 
			if (wn2 == rs) f_rs <= 2'b10 ;
			else f_rs <= 2'b0 ;
			if (wn2 == rt)	f_rt <= 2'b10 ;	
			else f_rt <= 2'b0 ;		
		end 
		else if (WB2[0] == 1 ) begin 
			if (wn2 == rs) f_rs <= 2'b10 ;
			else f_rs <= 2'b0 ;
			if (wn2 == rt) f_rt <= 2'b10 ;	
			else f_rt <= 2'b0 ;
		end 
	end 
end 

endmodule 