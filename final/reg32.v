/*
	Input Port
		1. clk
		2. rst: 重置訊號
		3. en_reg: 控制暫存器是否可寫入
		4. d_in: 欲寫入的暫存器資料
	Output Port
		1. d_out: 所讀取的暫存器資料
*/
module reg32 ( rst, en_reg, PCSrc, b_tgt, d_in, d_out );
    input rst, en_reg, PCSrc;
    input[31:0]	d_in, b_tgt;
    output reg [31:0] d_out;
   
    always@(rst or d_in or en_reg or PCSrc) begin
        if ( rst )
			d_out = 32'b0;
		else if ( PCSrc )
			d_out = b_tgt-32'd4;
        else if ( en_reg )
			d_out = d_in;
		else 
			d_out = d_out-32'd4 ;
		$display("%b", d_out) ;
    end

endmodule
	
