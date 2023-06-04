module mips_pipelined( clk, rst );

	input clk, rst;
	
	// instr bus
	wire[31:0] instr, instr_out;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct, funct_out;
    wire [4:0] rs, rs_out, rt, rt_out, rd, rd_out, shamt, shamt_out;
    wire [15:0] immed;
    wire [31:0] extend_immed, extend_immed_un, immed_result, extend_out, b_offset, b_offset_out;
    wire [25:0] jumpoffset;
	wire [63:0] mul_ans ;
	
	// datapath signals
	wire en_reg1, en_reg2, en_reg3 ;
	wire [1:0] f_rs, f_rt ;
	wire [4:0] rfile_wn, wn_out1, wn_out2;
	wire [31:0] rfile_rd1, rd1_out, rfile_rd2, rd2_out, RD2toWD, rfile_wd, alu_b, alu_out, ans,
	            ALUtoADDR, addr_out, b_tgt, pc, pc_incr, pc_add, pc_next, hi_out, lo_out, 
                jump_addr, branch_addr, dmem_rdata, dmem_rdata_out, alu_up, alu_down;

	// control signals
    wire RegWrite, Branch, Branch_out,  PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Jump, ExtendSel;
    wire [1:0] ALUOp, sel;
    wire [2:0] Operation;
	
	wire [1:0] WB_reg, WB_reg1, WB_reg2, WB_reg3 ; // RegWrite, MemtoReg
	wire [1:0] MEM_reg, MEM_reg1, MEM_reg2 ; // MemWrite, MemRead
	wire [3:0] EX_reg, EX_reg1 ; // ALUSrc, RegDst, ALUOp
	assign WB_reg = { RegWrite, MemtoReg } ;
	assign MEM_reg = { MemWrite, MemRead } ;
	assign EX_reg = { ALUSrc, RegDst, ALUOp } ;
	
    assign opcode = instr_out[31:26];    // R-type, I-type, J-type
    assign rs = instr_out[25:21];        // R-type, I-type
    assign rt = instr_out[20:16];        // R-type, I-type
    assign rd = instr_out[15:11];        // R-type
    assign shamt = instr_out[10:6];      // R-type
    assign funct = instr_out[5:0];       // R-type
    assign immed = instr_out[15:0];      // I-type
    assign jumpoffset = instr_out[25:0]; // J-type
	assign b_offset = extend_immed << 2; 
	assign jump_addr = { pc_add[31:28], jumpoffset <<2 };
	
	// -------------------------------------------Fetch--------------------------------------------------------
	
	reg32 PC(.rst(rst), .en_reg(en_reg1), .PCSrc(PCSrc), 
	         .b_tgt(b_tgt), .d_in(pc_next), .d_out(pc) );
	
	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) ); 
	
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) ); 
	
	IF_ID IF_ID( .clk(clk), .rst(rst), .en_reg(en_reg2), 
	             .pc_in(pc_incr), .ins_in(instr), .pc_out(pc_add), .ins_out(instr_out)) ; 
	
	// ------------------------------------------Decode---------------------------------------------------------
	
	Hazard Hazard0(.clk(clk), .rst(rst), .rs(rs), .rt(rt), .rt2(rt_out), .PCSrc(PCSrc), 
	               .memread(MEM_reg1[0]), .en_out1(en_reg1), .en_out2(en_reg2), .en_out3(en_reg3)) ;
	
	reg_file RegFile( .clk(clk), .RegWrite(WB_reg3[1]), .RN1(rs), .RN2(rt), 
	                  .WN(wn_out2), .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );
	
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) );
	
	unsign_extend UnsignExt( .immed_in_un(immed), .ext_immed_un(extend_immed_un)) ;
	
	ctl_mux2_1 #(32) EXTENDMUX( .sel(ExtendSel), .a(extend_immed), .b(extend_immed_un), .y(immed_result) ) ;

    control_pipelined CTL(.clk(clk), .rst(rst), .en_reg(en_reg3), .opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), 
	                      .MemtoReg(MemtoReg),  .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), 
						  .Branch(Branch), .Jump(Jump), .ALUOp(ALUOp), .ExtendSel(ExtendSel));

	ctl_mux2_1 #(32) JMUX( .sel(Jump), .a(pc_add), .b(jump_addr), .y(pc_next) );
		
	ID_EX ID_EX(.clk(clk), .rst(rst), 
	            .W_in(WB_reg), .M_in(MEM_reg), .E_in(EX_reg), .rd1_in(rfile_rd1), .rd2_in(rfile_rd2), 
	            .funct_in(funct), .shamt_in(shamt), .immed_in(immed_result), 
				.rs_in(rs), .rt_in(rt), .rd_in(rd),
				.b_offset_in(b_offset) , .branch_in(Branch), 
				.W_out(WB_reg1), .M_out(MEM_reg1), .E_out(EX_reg1), .rd1_out(rd1_out), .rd2_out(rd2_out), 
				.funct_out(funct_out), .shamt_out(shamt_out), .immed_out(extend_out), 
				.rs_out(rs_out), .rt_out(rt_out), .rd_out(rd_out),
				.b_offset_out(b_offset_out), .branch_out(Branch_out)) ;
	
	// -------------------------------------------Execute-------------------------------------------------------

	branch_ornot branch_ornot0(.rs(rs_out), .rt(rt_out), .branch(Branch_out), .PCSrc(PCSrc)) ;
	
	add32 BRADD( .a(pc_add), .b(b_offset_out), .result(b_tgt) ); 
	
	Forward Forward0(.rst(rst), .rs(rs_out), .rt(rt_out), .wn1(wn_out1), .wn2(wn_out2), 
	                     .WB1(WB_reg2), .WB2(WB_reg3), .f_rs(f_rs), .f_rt(f_rt)) ;
			
	mux3_1 F_RS(.sel(f_rs), .a(rd1_out), .b(ALUtoADDR), .c(rfile_wd), .cout(alu_up)) ;
				
    ctl_mux2_1 #(32) ALUMUX( .sel(EX_reg1[3]), .a(rd2_out), .b(extend_out), .y(alu_b) );
	
	mux3_1 F_RT(.sel(f_rt), .a(alu_b), .b(ALUtoADDR), .c(rfile_wd), .cout(alu_down)) ;
	
	alu_ctl ALUCTL( .ALUOp(EX_reg1[1:0]), .Funct(funct_out), .ALUOperation(Operation), .sel(sel) );

	alu ALU( .signal(Operation), .dataA(alu_up), .dataB(alu_down), 
	         .dataOut(alu_out), .shamt(shamt_out)); 
	
	multiplier multiplier( .clk(clk), .rst(rst), .signal(Operation), .dataA(rd1_out), .dataB(rd2_out), 
	                       .dataOut(mul_ans) ) ;
	
	HiLo HiLo( .clk(clk), .op(funct_out), .MulAns(mul_ans), .HiOut(hi_out), .LoOut(lo_out), .rst(rst) ) ;
	
	mux3_1 MUL_ALU_ans(.sel(sel), .a(alu_out), .b(hi_out), .c(lo_out), .cout(ans)) ;
	
	ctl_mux2_1 #(5) RFMUX( .sel(EX_reg1[2]), .a(rt_out), .b(rd_out), .y(rfile_wn) );

	
	EX_MEM EX_MEM(.clk(clk), .rst(rst), 
	              .W_in(WB_reg1), .M_in(MEM_reg1), .ALU_in(ans), .RD2_in(rd2_out), .WN_in(rfile_wn),
				  .W_out(WB_reg2), .M_out(MEM_reg2), .ALU_out(ALUtoADDR), .RD2_out(RD2toWD), .WN_out(wn_out1)) ;

 	// --------------------------------------------Memory-------------------------------------------------------   

	memory DatMem( .clk(clk), .MemRead(MEM_reg2[0]), .MemWrite(MEM_reg2[1]), .wd(RD2toWD), 
				   .addr(ALUtoADDR), .rd(dmem_rdata) );	   
				   
	MEM_WB MEM_WB( .clk(clk), .rst(rst),.W_in(WB_reg2), .RD_in(dmem_rdata), 
	                             .ADDR_in(ALUtoADDR), .WN_in(wn_out1), 
                                 .W_out(WB_reg3), .RD_out(dmem_rdata_out), 
								 .ADDR_out(addr_out), .WN_out(wn_out2)) ;
				   
 	// --------------------------------------------WriteBack-----------------------------------------------------   


    ctl_mux2_1 #(32) WRMUX( .sel(WB_reg3[0]), .a(addr_out), .b(dmem_rdata_out), .y(rfile_wd) );


endmodule
