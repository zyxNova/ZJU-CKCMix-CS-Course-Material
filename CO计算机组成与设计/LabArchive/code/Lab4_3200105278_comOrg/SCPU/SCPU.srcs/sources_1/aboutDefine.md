放在top.v
`define VGA_DBG_RegFile_Declaration \
    wire [31:0] dbg_x0; \
    wire [31:0] dbg_ra; \
    wire [31:0] dbg_sp; \
    wire [31:0] dbg_gp; \


放在Module定义中
`define VGA_DBG_RegFile_Outputs \
    output wire [31:0] dbg_x0, \
    output wire [31:0] dbg_ra, \

放在module内部
`define VGA_DBG_RegFile_Assignments \
    assign dbg_x0 = regs[0]; \
    assign dbg_ra = regs[1]; \

放在调用regfile模块的形参表中
`define VGA_DBG_RegFile_Arguments \
    .dbg_x0(dbg_x0), \
    .dbg_ra(dbg_ra), \
    .dbg_sp(dbg_sp), \

    