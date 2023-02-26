`include "Defines.vh"

module Core (
    /* output wire [] dbg_X*/
    `VGA_DBG_Core_Outputs
    input clk, rst,
    input [31:0] imem_o_data,
    input [31:0] dmem_o_data,
    input ext_int,
    output reg tim_int,
    output [31:0] imem_addr,
    output dmem_wen,
    output dmem_ren,
    output [31:0] dmem_addr,
    output [31:0] dmem_i_data,
    output INT
);
    reg [31:0] pc;
    wire [31:0] inst;

    /* Control Unit Signal */
    wire reg_wen; 
    wire is_imm; 
    wire mem_wen; //MemWrite
    wire mem_ren; //MemRead
    wire m2reg; 
    wire [2:0] immType; 
    wire is_branch;
    wire is_jal;
    wire is_jalr;
    wire is_auipc;//add upper imm20 to pc
    wire is_lui;
    wire do_branch; // 'taken' in class
    wire [2:0] cmp_ctrl;

    /* regFile*/
    wire [4:0] rs1, rs2, rd;
    wire [31:0] rs1_val, rs2_val;
    wire [31:0] reg_i_data;

    wire [31:0] imm; 

    wire [31:0] a_val, b_val;
    wire [3:0] alu_ctrl;
    wire [31:0] alu_res;
    wire cmp_res;

    wire [31:0] pc_branch;
    assign do_branch = is_branch & cmp_res | is_jal | is_jalr;
    wire [31:0] pc_jalOrJalr;
    assign pc_jalOrJalr = (is_jalr) ? alu_res : pc + imm;
    wire [31:0] pc_jOrAdd4;
    assign pc_jOrAdd4 = do_branch ? pc_jalOrJalr : pc + 4;
    wire [31:0] pc_exp;
    assign pc_branch = (INT | is_mret) ? pc_exp : pc_jOrAdd4; 
    /* Interrupt & Exception*/
    wire csr_wen;
    wire is_csr;
    wire is_ecall;
    wire is_mret;
    wire csr_src2;
    reg [11:0] csr_ind; //csr index
    wire [1:0] csr_ctrl;
    wire [31:0] csr_r_data;
    reg [31:0] csr_i_data;

    /* assign dbg_X = X; */
    `VGA_DBG_Core_Assignments
    reg [4:0] cnt;
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            tim_int <= 0;
            cnt <= 0;
        end
        else if (cnt < 31) cnt <= cnt + 1;
        else begin
			 cnt <= 0;
			 tim_int <= ~tim_int;
		end
	end
    wire illegal_op;
    wire is_pc_misalign;
    wire is_lw_misalign;
    wire is_sw_misalign;
    wire [31:0] EPCval;
    reg [31:0] CauseVal; //ecall的时候要修改mcause
    reg [31:0] tval;
    wire [31:0] csr_val2;
    wire INT;
    wire is_exp;


    assign is_exp = is_ecall | illegal_op | is_pc_misalign | is_lw_misalign | is_sw_misalign | tim_int | ext_int;
    assign is_sw_misalign = (mem_wen && dmem_addr[1:0] != 2'b00) ? 1 : 0;
    assign is_lw_misalign = (mem_ren && dmem_addr[1:0] != 2'b00) ? 1 : 0;
    assign is_pc_misalign = (pc[1:0] != 2'b00) ? 1 : 0;
    assign EPCval = pc;
    assign csr_val2 = (csr_src2) ? {27'b0, inst[19:15]} : rs1_val;
    always @* begin
        case(csr_ctrl)
            `CSR_CTRL_W: csr_i_data = csr_val2;
            `CSR_CTRL_S: csr_i_data = csr_r_data | csr_val2;
            `CSR_CTRL_C: csr_i_data = csr_r_data & ~csr_val2;
        endcase
        csr_ind = inst[31:20];
        if (is_ecall) CauseVal = `CSR_CAUSE_ECALL_FROM_M;
        else if (illegal_op) CauseVal = `CSR_CAUSE_ILLEGAL_INST;
        else if (is_pc_misalign) CauseVal = `CSR_CAUSE_INST_ADDR_MISALIGN;
        else if (is_lw_misalign) CauseVal = `CSR_CAUSE_LOAD_ADDR_MISALIGN;
        else if (is_sw_misalign) CauseVal = `CSR_CAUSE_STORE_ADDR_MISALIGN;
        else if (tim_int) CauseVal = `CSR_CAUSE_M_TIMER_INT;
        else if (ext_int) CauseVal = `CSR_CAUSE_M_EXTERNAL_INT;
        if (illegal_op) tval = inst;
        else if (is_pc_misalign) tval = pc;
        else if (is_lw_misalign | is_sw_misalign) tval = dmem_addr;
        else tval = 0;
    end

    CSR Control_Status_Reg(
        `VGA_DBG_Csr_Arguments
        .clk(~clk),
        .rst(rst),
        .wen(csr_wen),
        .ind(csr_ind),
        .i_data(csr_i_data),
        .o_data(csr_r_data),
        .EPCval(EPCval),
        .CauseVal(CauseVal),
        .tval(tval),
        .is_exp(is_exp),
        .is_mret(is_mret),
        .INT(INT),
        .pc_exp(pc_exp)
    );
    
    Controller control_unit(
        .inst(inst),
        .alu_ctrl(alu_ctrl),
        .reg_wen(reg_wen),
        .is_imm(is_imm),
        .mem_wen(mem_wen),
        .mem_ren(mem_ren),
        .m2reg(m2reg),
        .immType(immType),
        .is_branch(is_branch),
        .is_jal(is_jal),
        .is_lui(is_lui),
        .is_jalr(is_jalr),
        .is_auipc(is_auipc),
        .cmp_ctrl(cmp_ctrl),
        .is_csr(is_csr),
        .csr_src2(csr_src2),
        .csr_ctrl(csr_ctrl),
        .csr_wen(csr_wen),
        .is_ecall(is_ecall),
        .is_mret(is_mret),
        .illegal_op(illegal_op)
    );
    ImmGen imm_generator(
        .inst(inst),
        .immType(immType),
        .imm(imm)
    );

    assign imem_addr = pc;
    assign inst = imem_o_data;

    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
        end
        else begin
            pc <= pc_branch;
        end
    end

    /* DMem */
    assign dmem_addr = alu_res;
    assign dmem_i_data = rs2_val;
    assign dmem_wen = mem_wen & ~is_sw_misalign;
    assign dmem_ren = mem_ren & ~is_lw_misalign; //forget the output!

    assign a_val = rs1_val;
    assign b_val = is_imm ? imm : rs2_val;

    Alu alu(
        .a_val(a_val),
        .b_val(b_val),
        .ctrl(alu_ctrl),
        .result(alu_res)
    );

    Comparator comparator(
        .a_val(a_val),
        .b_val(b_val),
        .ctrl(cmp_ctrl),
        .result(cmp_res)
    );

    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = inst[11:7];
    wire [31:0] aluOrMem;
    assign aluOrMem = (m2reg) ? dmem_o_data : alu_res; 
    wire [31:0] AMorJal;
    assign AMorJal = (is_jal | is_jalr) ? pc + 4 : aluOrMem;
    wire [31:0] JalOrLui;
    assign JalOrLui = (is_lui) ? imm : AMorJal;
    wire [31:0] LuiOrPC;
    assign LuiOrPC = (is_auipc) ? pc + imm : JalOrLui;
    assign reg_i_data = (is_csr) ? csr_r_data : LuiOrPC;
    wire reg_wen_not_misalign;
    assign reg_wen_not_misalign = reg_wen & ~is_lw_misalign;
    RegFile reg_file(
        `VGA_DBG_RegFile_Arguments
        .clk(~clk),
        .rst(rst),
        .wen(reg_wen_not_misalign),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .i_data(reg_i_data),
        .rs1_val(rs1_val),
        .rs2_val(rs2_val)
    );
endmodule
