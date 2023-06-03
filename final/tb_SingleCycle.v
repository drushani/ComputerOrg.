
module tb_Pipelined();
	reg clk, rst;
	
	// ���ͮɯߡA�g���G10ns
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		
		
		/*
			���O��ưO����A�ɦW"instr_mem.txt, data_mem.txt"�i�ۦ�ק�
			�C�@�欰1 Byte��ơA�H��ӤQ���i��Ʀr���
			�B��Little Endian�s�X
		*/
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// �]�w�Ȧs����l�ȡA�C�@�欰�@���Ȧs�����
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;

	end
	
	always @( posedge clk ) begin
		$display( "%d, PC:", $time, CPU.pc );
		if ( CPU.opcode == 6'd0 ) begin
			$display( "%d, wd: %d", $time, CPU.rfile_wd );
			if ( CPU.funct == 6'd32 ) $display( "%d, ADD\n", $time );
			else if ( CPU.funct == 6'd34 ) $display( "%d, SUB\n", $time );
			else if ( CPU.funct == 6'd36 ) $display( "%d, AND\n", $time );
			else if ( CPU.funct == 6'd37 ) $display( "%d, OR\n", $time );
			else if ( CPU.funct == 6'd0 ) begin
				if ( CPU.rs == 5'd0 && CPU.rt == 5'd0 && CPU.rd == 5'd0 && CPU.shamt == 5'd0 )
					$display( "%d, NOP\n", $time );
				else
					$display( "%d, SRL\n", $time );
			end
			else if ( CPU.funct == 6'd42 ) $display( "%d, SLT\n", $time );
			else if ( CPU.funct == 6'd25 ) $display( "%d, MULTU\n", $time );
			else if ( CPU.funct == 6'd1  ) $display( "%d, MADDU\n", $time );
			else if ( CPU.funct == 6'd10 ) $display( "%d, MFHI\n", $time );
			else if ( CPU.funct == 6'd12 ) $display( "%d, MFLO\n", $time );
		end
		else if ( CPU.opcode == 6'd9 ) $display( "%d, ADDIU\n", $time );
		else if ( CPU.opcode == 6'd35 ) $display( "%d, LW\n", $time );
		else if ( CPU.opcode == 6'd43 ) $display( "%d, SW\n", $time );
		else if ( CPU.opcode == 6'd4 ) $display( "%d, BEQ\n", $time );
		else if ( CPU.opcode == 6'd5 ) $display( "%d, BNE\n", $time );
		else if ( CPU.opcode == 6'd2 ) $display( "%d, J\n", $time );
	end
	
	mips_pipelined CPU( clk, rst );
	
endmodule