
module mips_pipelined( clk, rst );

	input clk, rst;
	
	// break out important fields from instruction
	wire[31:0] instr, instr_out;
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed, immed_in_un;
    wire [31:0] extend_immed, extend_immed_un, immed_result, b_offset;
    wire [25:0] jumpoffset;
	
	// datapath signals
	wire [4:0] rfile_wn, wn_out1, wn_out2;
	wire [31:0] pc, pc_incr, pc_add, rfile_rd1, rfile_rd2, rfile_wd, rd1_out, rd2_out, 
	            funct_out, shamt_out, immed_out, rt_out, rd_out, 
                alu_b, b_tgt, alu_out, mul_ans, hi_out, lo_out, ans, ALUtoADDR, RD2toWD,
				pc_next, jump_addr, branch_addr, dmem_rdata, dmem_rdata_out, addr_out;

	// control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero, Jump, ExtendSel;
    wire [1:0] ALUOp, sel;
    wire [2:0] Operation;
	
	wire [1:0] WB_reg, WB_reg1, WB_reg2, WB_reg3 ; // RegWrite, MemtoReg
	wire [1:0] MEM_reg, MEM_reg1, MEM_reg2 ; // MemWrite, MemRead
	wire [3:0] EX_reg, EX_reg1 ; // ALUSrc, RegDst, ALUOp
	assign WB_reg = { RegWrite, MemtoReg } ;
	assign MEM_reg = { MemWrite, MemRead } ;
	assign EX_reg = { ALUSrc, RegDst, ALUOp } ;
	
    assign opcode = instr[31:26];    // R-type, I-type, J-type
    assign rs = instr[25:21];        // R-type, I-type
    assign rt = instr[20:16];        // R-type, I-type
    assign rd = instr[15:11];        // R-type
    assign shamt = instr[10:6];      // R-type
    assign funct = instr[5:0];       // R-type
    assign immed = instr[15:0];      // I-type
    assign jumpoffset = instr[25:0]; // J-type
	assign b_offset = extend_immed << 2; 
	assign jump_addr = { pc_incr[31:28], jumpoffset <<2 };
	
	// -------------------------------------------Fetch--------------------------------------------------------
	
	// fetch instr 
	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) ); // 取出指令
	
	// pc+4
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) ); 
	
	// Pipelined Register
	IF_ID IF_ID( .clk(clk), .rst(rst), .pc_in(pc_incr), .ins_in(instr), .pc_out(pc_add), .ins_out(instr_out)) ; 
	
	// ------------------------------------------Decode---------------------------------------------------------
	
	// Register File 
	reg_file RegFile( .clk(clk), .RegWrite(WB_reg3[1]), .RN1(rs), .RN2(rt), 
	                  .WN(rfile_wn), .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );
	
	// Extend 
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) );
	unsign_extend UnsignExt( .immed_in_un(immed_in_un), .ext_immed_un(extend_immed_un)) ;
	ctl_mux2_1 #(32) EXTENDMUX( .signal(ExtendSel), .a(extend_immed), .b(extend_immed_un), .cout(immed_result) ) ;

    // Control
    control_single CTL(.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp), .ExtendSel(ExtendSel));
					   
    // Pipelined Register 
	ID_EX ID_EX(.clk(clk), .rst(rst), 
	            .W_in(WB_reg), .M_in(MEM_reg), .E_in(EX_reg), .rd1_in(rfile_rd1), .rd2_in(rfile_rd2), 
	            .func_in(funct), .shamt_in(shamt), .immed_in(immed_result), 
				.rt_in(rt), .rd_in(rd),
				.W_out(WB_reg1), .M_out(MEM_reg1), .E_out(EX_reg1), .rd1_out(rd1_out), .rd2_out(rd2_out), 
				.func_out(funct_out), .shamt_out(shamt_out), .immed_out(immed_out), 
				.rt_out(rt_out), .rd_out(rd_out)) ;
	
	// -------------------------------------------Execute-------------------------------------------------------

    // ADD
    add32 BRADD( .a(pc_add), .b(b_offset), .result(b_tgt) ); 

    // MUX(ALUSrc)
    ctl_mux2_1 #(32) ALUMUX( .signal(EX_reg1[3]), .a(immed_out), .b(rd2_out), .cout(alu_b) );
	
	// Op->ctl
	alu_ctl ALUCTL( .ALUOp(EX_reg[1:0]), .Funct(funct_out), .ALUOperation(Operation), .sel(sel) );

    // alu 
	alu ALU( .signal(Operation), .dataA(rd1_out), .dataB(alu_b), 
	         .dataOut(alu_out), .shamt(shamt_out), .zero(Zero) ); 
	
	// multipiler 
	multipiler multipiler( .clk(clk), .rst(rst), .signal(Operation), .dataA(rd1_out), .dataB(rd2_out), 
	                       .dataOut(mul_ans) ) ;
	
	// HiLo 
	HiLo HiLo( .clk(clk), .MTPAns(mul_ans), .HiOut(hi_out), .LoOut(lo_out), .rst(rst) ) ;
	
	// MUX(alu_ans or mul_ans)
	mux3_1 MUL_ALU_ans(.sel(sel), .a(alu_out), .b(hi_out), .c(lo_out), .cout(ans)) ;
	
    // MUX(RegDst)
	ctl_mux2_1 #(5) RFMUX( .sel(EX_reg1[2]), .a(rt_out), .b(rd_out), .y(rfile_wn) );
	
	// Pipelined Register
	EX_MEM EX_MEM(.clk(clk), .rst(rst), 
	              .W_in(WB_reg1), .M_in(MEM_reg1), .ALU_in(ans), .RD2_in(rd2_out), .WN_in(rfile_wn),
				  .W_out(WB_reg2), .M_out(MEM_reg2), .ALU_out(ALUtoADDR), .RD2_out(RD2toWD), .WN_out(wn_out1)) ;

 	// --------------------------------------------Memory-------------------------------------------------------   

	// MUX(PCSrc) *如果beq成立,PCSrc就會是1
	and BR_AND(PCSrc, Branch, Zero);

	// 決定是下一道指令還是branch
    ctl_mux2_1 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(b_tgt), .y(branch_addr) );

	// 決定完上面,在看下面。看是branch_addr還是jump_addr
	ctl_mux2_1 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );

    // Data Memory
	memory DatMem( .clk(clk), .MemRead(MEM_reg2[0]), .MemWrite(MEM_reg2[1]), .wd(RD2toWD), 
				   .addr(ALUtoADDR), .rd(dmem_rdata) );	   
				   
	// Pipelined Register
	MEM_WB( .clk(clk), .rst(rst),.W_in(WB_reg2), .RD_in(dmem_rdata), 
	                             .ADDR_in(ALUtoADDR), .WN_in(wn_out1), 
                                 .W_out(WB_reg3), .RD_out(dmem_rdata_out), 
								 .ADDR_out(addr_out), .WN_out(wn_out2)) ;
				   
 	// --------------------------------------------WriteBack-----------------------------------------------------   

    // next instr
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) );

    // write back
    ctl_mux2_1 #(32) WRMUX( .sel(WB_reg3[0]), .a(addr_out), .b(dmem_rdata_out), .y(wn_out2) );


endmodule
