`include "Defines.vh"

module Core (
    /* output wire [] dbg_X*/
    `VGA_DBG_Core_Outputs
    input clk, rst,
    input [31:0] imem_o_data,
    input [31:0] dmem_o_data,
    output [31:0] imem_addr,
    output dmem_wen,
    output dmem_ren,
    output [31:0] dmem_addr,
    output [31:0] dmem_i_data
);
    reg [31:0] pc;
    wire [31:0] inst;

    /** IF/ID */
    reg [31:0] IfId_pc;
    reg [31:0] IfId_inst;
    reg IfId_valid; 
    
    /** ID/EX */
    // alu_ctrl和cmp_ctrl的位数不对
    reg [31:0] IdEx_pc;
    reg [31:0] IdEx_inst;
    reg IdEx_valid;
    reg [4:0] IdEx_rd;
    reg [4:0] IdEx_rs1;
    reg [4:0] IdEx_rs2;
    reg [31:0] IdEx_rs1_val;
    reg [31:0] IdEx_rs2_val;
    reg IdEx_reg_wen;
    reg [31:0] IdEx_imm;
    reg IdEx_mem_wen;
    reg IdEx_mem_ren;
    reg IdEx_is_branch;
    reg IdEx_is_jal;
    reg IdEx_is_jalr;
    reg IdEx_is_auipc;
    reg IdEx_is_lui;
    reg [3:0] IdEx_alu_ctrl;
    reg [2:0] IdEx_cmp_ctrl;
    reg IdEx_is_imm;

    /** EX/MEM */
    reg [31:0] ExMa_pc;
    reg [31:0] ExMa_inst;
    reg ExMa_valid;
    reg [4:0] ExMa_rd;
    reg ExMa_reg_wen;
    reg [31:0] ExMa_mem_w_data;
    reg [31:0] ExMa_alu_res;
    reg ExMa_mem_wen;
    reg ExMa_mem_ren;
    reg ExMa_is_jal;
    reg ExMa_is_jalr;
    reg ExMa_is_lui;
    reg ExMa_is_auipc;
    reg [31:0] ExMa_imm;
    reg ExMa_branch_taken;
    reg [31:0] ExMa_rs2_val;
    
    /** MEM/WB */
    reg [31:0] MaWb_pc;
    reg [31:0] MaWb_inst;
    reg MaWb_valid;
    reg [4:0] MaWb_rd;
    reg MaWb_reg_wen;
    reg [31:0] MaWb_reg_w_data;

    wire stall;
    wire data_hazard;
    wire control_hazard;
    assign stall = data_hazard | control_hazard;
    assign data_hazard = (IdEx_reg_wen | ExMa_reg_wen) 
    && ( ((is_aluRR || is_aluRI || mem_ren || is_jalr || mem_wen || is_branch) && ((IdEx_rd != 0 && IdEx_rd == rs1) || (ExMa_rd != 0 && ExMa_rd == rs1)) ) 
    || ( (is_aluRR || mem_wen || is_branch) && ((IdEx_rd != 0 && IdEx_rd == rs2) || (ExMa_rd != 0 && ExMa_rd == rs2)) ) );
    assign control_hazard = (IdEx_is_branch & cmp_res) | ExMa_branch_taken | IdEx_is_jal | ExMa_is_jal | IdEx_is_jalr | ExMa_is_jalr;

    assign imem_addr = pc;
    assign inst = imem_o_data;

    /** PC Latch */
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
        end
        else begin
            if (~data_hazard) pc <= pc_branch; // 如果发生data_hazard则保持不变, control_hazard可以改变
        end
    end

    /** IF/ID Latch */
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            IfId_pc <= 0;
            IfId_inst <= `NOP_INST;
            IfId_valid <= 0;
        end
        else begin
            IfId_valid <= ~control_hazard; // 只有control_hazard会清空ID
            if (control_hazard) begin
                IfId_pc <= 0;
                IfId_inst <= `NOP_INST;
            end
            else if (~stall) begin
                IfId_pc <= pc;
                IfId_inst <= inst;
            end
            // 如果是data hazard则保持不变
        end
    end

    /** ID/EX Latch */
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            IdEx_pc <= 0;
            IdEx_inst <= `NOP_INST;
            IdEx_valid <= 0;
            IdEx_rd <= 0;
            IdEx_rs1 <= 0;
            IdEx_rs2 <= 0;
            IdEx_rs1_val <= 0;
            IdEx_rs2_val <= 0;
            IdEx_reg_wen <= 0;
            IdEx_imm <= 0;
            IdEx_mem_wen <= 0;
            IdEx_mem_ren <= 0;
            IdEx_is_branch <= 0;
            IdEx_is_jal <= 0;
            IdEx_is_jalr <= 0;
            IdEx_is_auipc <= 0;
            IdEx_is_lui <= 0;
            IdEx_alu_ctrl <= 0;
            IdEx_cmp_ctrl <= 0;
            IdEx_is_imm <= 0;
        end
        else begin
            IdEx_valid <= ~stall;
            if (stall) begin
                IdEx_pc <= 0;
                IdEx_inst <= `NOP_INST;
                IdEx_rd <= 0;
                IdEx_rs1 <= 0;
                IdEx_rs2 <= 0;
                IdEx_rs1_val <= 0;
                IdEx_rs2_val <= 0;
                IdEx_reg_wen <= 0;
                IdEx_imm <= 0;
                IdEx_mem_wen <= 0;
                IdEx_mem_ren <= 0;
                IdEx_is_branch <= 0;
                IdEx_is_jal <= 0;
                IdEx_is_jalr <= 0;
                IdEx_is_auipc <= 0;
                IdEx_is_lui <= 0;
                IdEx_alu_ctrl <= 0;
                IdEx_cmp_ctrl <= 0;
                IdEx_is_imm <= 0;
            end
            else begin
                IdEx_pc <= IfId_pc;
                IdEx_inst <= IfId_inst;
                IdEx_rd <= IfId_inst[11:7];
                IdEx_rs1 <= IfId_inst[19:15];
                IdEx_rs2 <= IfId_inst[24:20];
                IdEx_rs1_val <= rs1_val;
                IdEx_rs2_val <= rs2_val;
                IdEx_reg_wen <= reg_wen;
                IdEx_imm <= imm;
                IdEx_mem_wen <= mem_wen;
                IdEx_mem_ren <= mem_ren;
                IdEx_is_branch <= is_branch;
                IdEx_is_jal <= is_jal;
                IdEx_is_jalr <= is_jalr;
                IdEx_is_auipc <= is_auipc;
                IdEx_is_lui <= is_lui;
                IdEx_alu_ctrl <= alu_ctrl;
                IdEx_cmp_ctrl <= cmp_ctrl;
                IdEx_is_imm <= is_imm;
            end
        end
    end

    /** EX/MEM Latch */
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ExMa_pc <= 0;
            ExMa_inst <= `NOP_INST;
            ExMa_valid <= 0;
            ExMa_rd <= 0;
            ExMa_reg_wen <= 0;
            ExMa_mem_w_data <= 0;
            ExMa_alu_res <= 0;
            ExMa_mem_wen <= 0;
            ExMa_mem_ren <= 0;
            ExMa_is_jal <= 0;
            ExMa_is_jalr <= 0;
            ExMa_is_lui <= 0;
            ExMa_is_auipc <= 0;
            ExMa_imm <= 0;
            ExMa_branch_taken <= 0;
            ExMa_rs2_val <= 0;
        end
        else begin
            ExMa_pc <= IdEx_pc;
            ExMa_inst <= IdEx_inst;
            ExMa_valid <= IdEx_valid;
            ExMa_rd <= IdEx_rd;
            ExMa_reg_wen <= IdEx_reg_wen;
            ExMa_mem_w_data <= dmem_o_data;
            ExMa_alu_res <= alu_res;
            ExMa_mem_wen <= IdEx_mem_wen;
            ExMa_mem_ren <= IdEx_mem_ren;
            ExMa_is_jal <= IdEx_is_jal;
            ExMa_is_jalr <= IdEx_is_jalr;
            ExMa_is_lui <= IdEx_is_lui;
            ExMa_is_auipc <= IdEx_is_auipc;
            ExMa_imm <= IdEx_imm;
            ExMa_branch_taken <= IdEx_is_branch & cmp_res;
            ExMa_rs2_val <= IdEx_rs2_val;
        end
    end

    /** MEM/WB Latch */
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            MaWb_pc <= 0;
            MaWb_inst <= 0;
            MaWb_valid <= 0;
            MaWb_rd <= 0;
            MaWb_reg_wen <= 0;
            MaWb_reg_w_data <= 0;
        end
        else begin
            MaWb_pc <= ExMa_pc;
            MaWb_inst <= ExMa_inst;
            MaWb_valid <= ExMa_valid;
            MaWb_rd <= ExMa_rd;
            MaWb_reg_wen <= ExMa_reg_wen;
            MaWb_reg_w_data <= reg_i_data;
        end
    end

    /* Control Unit Signal */
    wire reg_wen; 
    wire is_imm; 
    wire mem_wen; //MemWrite
    wire mem_ren; //MemRead
    // wire m2reg;  可以把alu_res和dmem_o_data二选一使用mem_ren来选择，
    // 在MEM阶段就选好，则可以省略m2reg信号
    wire [2:0] immType; 
    wire is_aluRI;
    wire is_aluRR;
    wire is_branch;
    wire is_jal;
    wire is_jalr;
    wire is_auipc;//add upper imm20 to pc
    wire is_lui;
    wire [2:0] cmp_ctrl;
    wire [3:0] alu_ctrl;

    /** ImmGen */
    wire [31:0] imm; 

    /** regFile*/
    wire [4:0] rs1, rs2;
    wire [31:0] rs1_val, rs2_val;
    reg [31:0] reg_i_data;
   
    /** ALU and Comparator */
    wire [31:0] a_val, b_val;
    wire [31:0] alu_res;
    wire cmp_res;

    /* assign dbg_X = X; */
    `VGA_DBG_Core_Assignments

    /** ID Unit */
    Controller control_unit(
        .inst(IfId_inst),
        .alu_ctrl(alu_ctrl),
        .reg_wen(reg_wen),
        .is_imm(is_imm),
        .mem_wen(mem_wen),
        .mem_ren(mem_ren),
        .immType(immType),
        .is_branch(is_branch),
        .is_jal(is_jal),
        .is_lui(is_lui),
        .is_jalr(is_jalr),
        .is_auipc(is_auipc),
        .cmp_ctrl(cmp_ctrl),
        .is_aluRR(is_aluRR),
        .is_aluRI(is_aluRI)
    );

    ImmGen imm_generator(
        .inst(IfId_inst),
        .immType(immType),
        .imm(imm)
    );

    assign rs1 = IfId_inst[19:15];
    assign rs2 = IfId_inst[24:20];
    always@* begin
        if (ExMa_mem_ren) reg_i_data = dmem_o_data;
        else if (ExMa_is_jal | ExMa_is_jalr) reg_i_data = ExMa_pc + 4;
        else if (ExMa_is_lui) reg_i_data = ExMa_imm;
        else if (ExMa_is_auipc) reg_i_data = ExMa_imm + ExMa_pc;
        else reg_i_data = ExMa_alu_res;
    end
    
    RegFile reg_file(
        `VGA_DBG_RegFile_Arguments
        .clk(~clk),
        .rst(rst),
        .wen(MaWb_reg_wen),
        .rs1(rs1),
        .rs2(rs2),
        .rd(MaWb_rd),
        .i_data(MaWb_reg_w_data),
        .rs1_val(rs1_val),
        .rs2_val(rs2_val)
    );

    /** EXE Unit */
    assign a_val = IdEx_rs1_val;
    assign b_val = IdEx_is_imm ? IdEx_imm : IdEx_rs2_val;

    Alu alu(
        .a_val(a_val),
        .b_val(b_val),
        .ctrl(IdEx_alu_ctrl),
        .result(alu_res)
    );

    Comparator comparator(
        .a_val(a_val),
        .b_val(b_val),
        .ctrl(IdEx_cmp_ctrl),
        .result(cmp_res)
    );

    /** MEM Unit */
    reg [31:0] pc_branch;
    always@* begin
        if (ExMa_is_jalr) pc_branch = ExMa_alu_res;
        else if (ExMa_branch_taken | ExMa_is_jal) pc_branch = ExMa_pc + ExMa_imm;
        else pc_branch = pc + 4;
    end

    /* DMem */
    assign dmem_addr = ExMa_alu_res;
    assign dmem_i_data = ExMa_rs2_val;
    assign dmem_wen = ExMa_mem_wen;
    assign dmem_ren = ExMa_mem_ren;

endmodule
