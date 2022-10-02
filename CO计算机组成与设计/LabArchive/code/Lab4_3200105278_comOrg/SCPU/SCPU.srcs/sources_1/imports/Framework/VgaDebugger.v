// generated code

module Hex2Ascii(
    input wire [3:0] hex,
    output reg [7:0] ascii
);

    always @* begin
        case (hex)
            4'h0: ascii = 48;
            4'h1: ascii = 49;
            4'h2: ascii = 50;
            4'h3: ascii = 51;
            4'h4: ascii = 52;
            4'h5: ascii = 53;
            4'h6: ascii = 54;
            4'h7: ascii = 55;
            4'h8: ascii = 56;
            4'h9: ascii = 57;
            4'ha: ascii = 97;
            4'hb: ascii = 98;
            4'hc: ascii = 99;
            4'hd: ascii = 100;
            4'he: ascii = 101;
            4'hf: ascii = 102;
        endcase
    end

endmodule

module VgaDebugger(
    input wire [31:0] pc,
    input wire [31:0] inst,
    input wire [4:0] rs1,
    input wire [31:0] rs1_val,
    input wire [4:0] rs2,
    input wire [31:0] rs2_val,
    input wire [4:0] rd,
    input wire [31:0] reg_i_data,
    input wire reg_wen,
    input wire is_imm,
    input wire is_auipc,
    input wire is_lui,
    input wire [31:0] imm,
    input wire [31:0] a_val,
    input wire [31:0] b_val,
    input wire [3:0] alu_ctrl,
    input wire [2:0] cmp_ctrl,
    input wire [31:0] alu_res,
    input wire cmp_res,
    input wire is_branch,
    input wire is_jal,
    input wire is_jalr,
    input wire do_branch,
    input wire [31:0] pc_branch,
    input wire mem_wen,
    input wire mem_ren,
    input wire [31:0] dmem_o_data,
    input wire [31:0] dmem_i_data,
    input wire [31:0] dmem_addr,
    input wire csr_wen,
    input wire [11:0] csr_ind,
    input wire [1:0] csr_ctrl,
    input wire [31:0] csr_r_data,
    input wire [31:0] x0,
    input wire [31:0] ra,
    input wire [31:0] sp,
    input wire [31:0] gp,
    input wire [31:0] tp,
    input wire [31:0] t0,
    input wire [31:0] t1,
    input wire [31:0] t2,
    input wire [31:0] s0,
    input wire [31:0] s1,
    input wire [31:0] a0,
    input wire [31:0] a1,
    input wire [31:0] a2,
    input wire [31:0] a3,
    input wire [31:0] a4,
    input wire [31:0] a5,
    input wire [31:0] a6,
    input wire [31:0] a7,
    input wire [31:0] s2,
    input wire [31:0] s3,
    input wire [31:0] s4,
    input wire [31:0] s5,
    input wire [31:0] s6,
    input wire [31:0] s7,
    input wire [31:0] s8,
    input wire [31:0] s9,
    input wire [31:0] s10,
    input wire [31:0] s11,
    input wire [31:0] t3,
    input wire [31:0] t4,
    input wire [31:0] t5,
    input wire [31:0] t6,
    input wire [31:0] mstatus_o,
    input wire [31:0] mcause_o,
    input wire [31:0] mepc_o,
    input wire [31:0] mtval_o,
    input wire [31:0] mtvec_o,
    input wire [31:0] mie_o,
    input wire [31:0] mip_o,
    input wire clk,
    output reg display_wen,
    output wire [11:0] display_w_addr,
    output wire [7:0] display_w_data
);

    reg [11:0] display_addr = 0;
    assign display_w_addr = display_addr;
    always @(posedge clk) begin
        display_addr <= display_addr == 2399 ? 0 : display_addr + 1;
    end

    reg [3:0] dynamic_hex = 0;
    Hex2Ascii hex2ascii(dynamic_hex, display_w_data);
    always @* begin
        case (display_addr)
            165: begin dynamic_hex = pc[31:28]; display_wen = 1; end
            166: begin dynamic_hex = pc[27:24]; display_wen = 1; end
            167: begin dynamic_hex = pc[23:20]; display_wen = 1; end
            168: begin dynamic_hex = pc[19:16]; display_wen = 1; end
            169: begin dynamic_hex = pc[15:12]; display_wen = 1; end
            170: begin dynamic_hex = pc[11:8]; display_wen = 1; end
            171: begin dynamic_hex = pc[7:4]; display_wen = 1; end
            172: begin dynamic_hex = pc[3:0]; display_wen = 1; end
            182: begin dynamic_hex = inst[31:28]; display_wen = 1; end
            183: begin dynamic_hex = inst[27:24]; display_wen = 1; end
            184: begin dynamic_hex = inst[23:20]; display_wen = 1; end
            185: begin dynamic_hex = inst[19:16]; display_wen = 1; end
            186: begin dynamic_hex = inst[15:12]; display_wen = 1; end
            187: begin dynamic_hex = inst[11:8]; display_wen = 1; end
            188: begin dynamic_hex = inst[7:4]; display_wen = 1; end
            189: begin dynamic_hex = inst[3:0]; display_wen = 1; end
            966: begin dynamic_hex = rs1[4:4]; display_wen = 1; end
            967: begin dynamic_hex = rs1[3:0]; display_wen = 1; end
            980: begin dynamic_hex = rs1_val[31:28]; display_wen = 1; end
            981: begin dynamic_hex = rs1_val[27:24]; display_wen = 1; end
            982: begin dynamic_hex = rs1_val[23:20]; display_wen = 1; end
            983: begin dynamic_hex = rs1_val[19:16]; display_wen = 1; end
            984: begin dynamic_hex = rs1_val[15:12]; display_wen = 1; end
            985: begin dynamic_hex = rs1_val[11:8]; display_wen = 1; end
            986: begin dynamic_hex = rs1_val[7:4]; display_wen = 1; end
            987: begin dynamic_hex = rs1_val[3:0]; display_wen = 1; end
            1046: begin dynamic_hex = rs2[4:4]; display_wen = 1; end
            1047: begin dynamic_hex = rs2[3:0]; display_wen = 1; end
            1060: begin dynamic_hex = rs2_val[31:28]; display_wen = 1; end
            1061: begin dynamic_hex = rs2_val[27:24]; display_wen = 1; end
            1062: begin dynamic_hex = rs2_val[23:20]; display_wen = 1; end
            1063: begin dynamic_hex = rs2_val[19:16]; display_wen = 1; end
            1064: begin dynamic_hex = rs2_val[15:12]; display_wen = 1; end
            1065: begin dynamic_hex = rs2_val[11:8]; display_wen = 1; end
            1066: begin dynamic_hex = rs2_val[7:4]; display_wen = 1; end
            1067: begin dynamic_hex = rs2_val[3:0]; display_wen = 1; end
            1126: begin dynamic_hex = rd[4:4]; display_wen = 1; end
            1127: begin dynamic_hex = rd[3:0]; display_wen = 1; end
            1143: begin dynamic_hex = reg_i_data[31:28]; display_wen = 1; end
            1144: begin dynamic_hex = reg_i_data[27:24]; display_wen = 1; end
            1145: begin dynamic_hex = reg_i_data[23:20]; display_wen = 1; end
            1146: begin dynamic_hex = reg_i_data[19:16]; display_wen = 1; end
            1147: begin dynamic_hex = reg_i_data[15:12]; display_wen = 1; end
            1148: begin dynamic_hex = reg_i_data[11:8]; display_wen = 1; end
            1149: begin dynamic_hex = reg_i_data[7:4]; display_wen = 1; end
            1150: begin dynamic_hex = reg_i_data[3:0]; display_wen = 1; end
            1163: begin dynamic_hex = reg_wen; display_wen = 1; end
            1289: begin dynamic_hex = is_imm; display_wen = 1; end
            1303: begin dynamic_hex = is_auipc; display_wen = 1; end
            1315: begin dynamic_hex = is_lui; display_wen = 1; end
            1324: begin dynamic_hex = imm[31:28]; display_wen = 1; end
            1325: begin dynamic_hex = imm[27:24]; display_wen = 1; end
            1326: begin dynamic_hex = imm[23:20]; display_wen = 1; end
            1327: begin dynamic_hex = imm[19:16]; display_wen = 1; end
            1328: begin dynamic_hex = imm[15:12]; display_wen = 1; end
            1329: begin dynamic_hex = imm[11:8]; display_wen = 1; end
            1330: begin dynamic_hex = imm[7:4]; display_wen = 1; end
            1331: begin dynamic_hex = imm[3:0]; display_wen = 1; end
            1368: begin dynamic_hex = a_val[31:28]; display_wen = 1; end
            1369: begin dynamic_hex = a_val[27:24]; display_wen = 1; end
            1370: begin dynamic_hex = a_val[23:20]; display_wen = 1; end
            1371: begin dynamic_hex = a_val[19:16]; display_wen = 1; end
            1372: begin dynamic_hex = a_val[15:12]; display_wen = 1; end
            1373: begin dynamic_hex = a_val[11:8]; display_wen = 1; end
            1374: begin dynamic_hex = a_val[7:4]; display_wen = 1; end
            1375: begin dynamic_hex = a_val[3:0]; display_wen = 1; end
            1385: begin dynamic_hex = b_val[31:28]; display_wen = 1; end
            1386: begin dynamic_hex = b_val[27:24]; display_wen = 1; end
            1387: begin dynamic_hex = b_val[23:20]; display_wen = 1; end
            1388: begin dynamic_hex = b_val[19:16]; display_wen = 1; end
            1389: begin dynamic_hex = b_val[15:12]; display_wen = 1; end
            1390: begin dynamic_hex = b_val[11:8]; display_wen = 1; end
            1391: begin dynamic_hex = b_val[7:4]; display_wen = 1; end
            1392: begin dynamic_hex = b_val[3:0]; display_wen = 1; end
            1406: begin dynamic_hex = alu_ctrl[3:0]; display_wen = 1; end
            1420: begin dynamic_hex = cmp_ctrl[2:0]; display_wen = 1; end
            1450: begin dynamic_hex = alu_res[31:28]; display_wen = 1; end
            1451: begin dynamic_hex = alu_res[27:24]; display_wen = 1; end
            1452: begin dynamic_hex = alu_res[23:20]; display_wen = 1; end
            1453: begin dynamic_hex = alu_res[19:16]; display_wen = 1; end
            1454: begin dynamic_hex = alu_res[15:12]; display_wen = 1; end
            1455: begin dynamic_hex = alu_res[11:8]; display_wen = 1; end
            1456: begin dynamic_hex = alu_res[7:4]; display_wen = 1; end
            1457: begin dynamic_hex = alu_res[3:0]; display_wen = 1; end
            1470: begin dynamic_hex = cmp_res; display_wen = 1; end
            1612: begin dynamic_hex = is_branch; display_wen = 1; end
            1624: begin dynamic_hex = is_jal; display_wen = 1; end
            1637: begin dynamic_hex = is_jalr; display_wen = 1; end
            1692: begin dynamic_hex = do_branch; display_wen = 1; end
            1707: begin dynamic_hex = pc_branch[31:28]; display_wen = 1; end
            1708: begin dynamic_hex = pc_branch[27:24]; display_wen = 1; end
            1709: begin dynamic_hex = pc_branch[23:20]; display_wen = 1; end
            1710: begin dynamic_hex = pc_branch[19:16]; display_wen = 1; end
            1711: begin dynamic_hex = pc_branch[15:12]; display_wen = 1; end
            1712: begin dynamic_hex = pc_branch[11:8]; display_wen = 1; end
            1713: begin dynamic_hex = pc_branch[7:4]; display_wen = 1; end
            1714: begin dynamic_hex = pc_branch[3:0]; display_wen = 1; end
            1850: begin dynamic_hex = mem_wen; display_wen = 1; end
            1863: begin dynamic_hex = mem_ren; display_wen = 1; end
            1934: begin dynamic_hex = dmem_o_data[31:28]; display_wen = 1; end
            1935: begin dynamic_hex = dmem_o_data[27:24]; display_wen = 1; end
            1936: begin dynamic_hex = dmem_o_data[23:20]; display_wen = 1; end
            1937: begin dynamic_hex = dmem_o_data[19:16]; display_wen = 1; end
            1938: begin dynamic_hex = dmem_o_data[15:12]; display_wen = 1; end
            1939: begin dynamic_hex = dmem_o_data[11:8]; display_wen = 1; end
            1940: begin dynamic_hex = dmem_o_data[7:4]; display_wen = 1; end
            1941: begin dynamic_hex = dmem_o_data[3:0]; display_wen = 1; end
            1958: begin dynamic_hex = dmem_i_data[31:28]; display_wen = 1; end
            1959: begin dynamic_hex = dmem_i_data[27:24]; display_wen = 1; end
            1960: begin dynamic_hex = dmem_i_data[23:20]; display_wen = 1; end
            1961: begin dynamic_hex = dmem_i_data[19:16]; display_wen = 1; end
            1962: begin dynamic_hex = dmem_i_data[15:12]; display_wen = 1; end
            1963: begin dynamic_hex = dmem_i_data[11:8]; display_wen = 1; end
            1964: begin dynamic_hex = dmem_i_data[7:4]; display_wen = 1; end
            1965: begin dynamic_hex = dmem_i_data[3:0]; display_wen = 1; end
            1980: begin dynamic_hex = dmem_addr[31:28]; display_wen = 1; end
            1981: begin dynamic_hex = dmem_addr[27:24]; display_wen = 1; end
            1982: begin dynamic_hex = dmem_addr[23:20]; display_wen = 1; end
            1983: begin dynamic_hex = dmem_addr[19:16]; display_wen = 1; end
            1984: begin dynamic_hex = dmem_addr[15:12]; display_wen = 1; end
            1985: begin dynamic_hex = dmem_addr[11:8]; display_wen = 1; end
            1986: begin dynamic_hex = dmem_addr[7:4]; display_wen = 1; end
            1987: begin dynamic_hex = dmem_addr[3:0]; display_wen = 1; end
            2090: begin dynamic_hex = csr_wen; display_wen = 1; end
            2103: begin dynamic_hex = csr_ind[11:8]; display_wen = 1; end
            2104: begin dynamic_hex = csr_ind[7:4]; display_wen = 1; end
            2105: begin dynamic_hex = csr_ind[3:0]; display_wen = 1; end
            2119: begin dynamic_hex = csr_ctrl[1:0]; display_wen = 1; end
            2135: begin dynamic_hex = csr_r_data[31:28]; display_wen = 1; end
            2136: begin dynamic_hex = csr_r_data[27:24]; display_wen = 1; end
            2137: begin dynamic_hex = csr_r_data[23:20]; display_wen = 1; end
            2138: begin dynamic_hex = csr_r_data[19:16]; display_wen = 1; end
            2139: begin dynamic_hex = csr_r_data[15:12]; display_wen = 1; end
            2140: begin dynamic_hex = csr_r_data[11:8]; display_wen = 1; end
            2141: begin dynamic_hex = csr_r_data[7:4]; display_wen = 1; end
            2142: begin dynamic_hex = csr_r_data[3:0]; display_wen = 1; end
            325: begin dynamic_hex = x0[31:28]; display_wen = 1; end
            326: begin dynamic_hex = x0[27:24]; display_wen = 1; end
            327: begin dynamic_hex = x0[23:20]; display_wen = 1; end
            328: begin dynamic_hex = x0[19:16]; display_wen = 1; end
            329: begin dynamic_hex = x0[15:12]; display_wen = 1; end
            330: begin dynamic_hex = x0[11:8]; display_wen = 1; end
            331: begin dynamic_hex = x0[7:4]; display_wen = 1; end
            332: begin dynamic_hex = x0[3:0]; display_wen = 1; end
            340: begin dynamic_hex = ra[31:28]; display_wen = 1; end
            341: begin dynamic_hex = ra[27:24]; display_wen = 1; end
            342: begin dynamic_hex = ra[23:20]; display_wen = 1; end
            343: begin dynamic_hex = ra[19:16]; display_wen = 1; end
            344: begin dynamic_hex = ra[15:12]; display_wen = 1; end
            345: begin dynamic_hex = ra[11:8]; display_wen = 1; end
            346: begin dynamic_hex = ra[7:4]; display_wen = 1; end
            347: begin dynamic_hex = ra[3:0]; display_wen = 1; end
            355: begin dynamic_hex = sp[31:28]; display_wen = 1; end
            356: begin dynamic_hex = sp[27:24]; display_wen = 1; end
            357: begin dynamic_hex = sp[23:20]; display_wen = 1; end
            358: begin dynamic_hex = sp[19:16]; display_wen = 1; end
            359: begin dynamic_hex = sp[15:12]; display_wen = 1; end
            360: begin dynamic_hex = sp[11:8]; display_wen = 1; end
            361: begin dynamic_hex = sp[7:4]; display_wen = 1; end
            362: begin dynamic_hex = sp[3:0]; display_wen = 1; end
            370: begin dynamic_hex = gp[31:28]; display_wen = 1; end
            371: begin dynamic_hex = gp[27:24]; display_wen = 1; end
            372: begin dynamic_hex = gp[23:20]; display_wen = 1; end
            373: begin dynamic_hex = gp[19:16]; display_wen = 1; end
            374: begin dynamic_hex = gp[15:12]; display_wen = 1; end
            375: begin dynamic_hex = gp[11:8]; display_wen = 1; end
            376: begin dynamic_hex = gp[7:4]; display_wen = 1; end
            377: begin dynamic_hex = gp[3:0]; display_wen = 1; end
            385: begin dynamic_hex = tp[31:28]; display_wen = 1; end
            386: begin dynamic_hex = tp[27:24]; display_wen = 1; end
            387: begin dynamic_hex = tp[23:20]; display_wen = 1; end
            388: begin dynamic_hex = tp[19:16]; display_wen = 1; end
            389: begin dynamic_hex = tp[15:12]; display_wen = 1; end
            390: begin dynamic_hex = tp[11:8]; display_wen = 1; end
            391: begin dynamic_hex = tp[7:4]; display_wen = 1; end
            392: begin dynamic_hex = tp[3:0]; display_wen = 1; end
            405: begin dynamic_hex = t0[31:28]; display_wen = 1; end
            406: begin dynamic_hex = t0[27:24]; display_wen = 1; end
            407: begin dynamic_hex = t0[23:20]; display_wen = 1; end
            408: begin dynamic_hex = t0[19:16]; display_wen = 1; end
            409: begin dynamic_hex = t0[15:12]; display_wen = 1; end
            410: begin dynamic_hex = t0[11:8]; display_wen = 1; end
            411: begin dynamic_hex = t0[7:4]; display_wen = 1; end
            412: begin dynamic_hex = t0[3:0]; display_wen = 1; end
            420: begin dynamic_hex = t1[31:28]; display_wen = 1; end
            421: begin dynamic_hex = t1[27:24]; display_wen = 1; end
            422: begin dynamic_hex = t1[23:20]; display_wen = 1; end
            423: begin dynamic_hex = t1[19:16]; display_wen = 1; end
            424: begin dynamic_hex = t1[15:12]; display_wen = 1; end
            425: begin dynamic_hex = t1[11:8]; display_wen = 1; end
            426: begin dynamic_hex = t1[7:4]; display_wen = 1; end
            427: begin dynamic_hex = t1[3:0]; display_wen = 1; end
            435: begin dynamic_hex = t2[31:28]; display_wen = 1; end
            436: begin dynamic_hex = t2[27:24]; display_wen = 1; end
            437: begin dynamic_hex = t2[23:20]; display_wen = 1; end
            438: begin dynamic_hex = t2[19:16]; display_wen = 1; end
            439: begin dynamic_hex = t2[15:12]; display_wen = 1; end
            440: begin dynamic_hex = t2[11:8]; display_wen = 1; end
            441: begin dynamic_hex = t2[7:4]; display_wen = 1; end
            442: begin dynamic_hex = t2[3:0]; display_wen = 1; end
            450: begin dynamic_hex = s0[31:28]; display_wen = 1; end
            451: begin dynamic_hex = s0[27:24]; display_wen = 1; end
            452: begin dynamic_hex = s0[23:20]; display_wen = 1; end
            453: begin dynamic_hex = s0[19:16]; display_wen = 1; end
            454: begin dynamic_hex = s0[15:12]; display_wen = 1; end
            455: begin dynamic_hex = s0[11:8]; display_wen = 1; end
            456: begin dynamic_hex = s0[7:4]; display_wen = 1; end
            457: begin dynamic_hex = s0[3:0]; display_wen = 1; end
            465: begin dynamic_hex = s1[31:28]; display_wen = 1; end
            466: begin dynamic_hex = s1[27:24]; display_wen = 1; end
            467: begin dynamic_hex = s1[23:20]; display_wen = 1; end
            468: begin dynamic_hex = s1[19:16]; display_wen = 1; end
            469: begin dynamic_hex = s1[15:12]; display_wen = 1; end
            470: begin dynamic_hex = s1[11:8]; display_wen = 1; end
            471: begin dynamic_hex = s1[7:4]; display_wen = 1; end
            472: begin dynamic_hex = s1[3:0]; display_wen = 1; end
            485: begin dynamic_hex = a0[31:28]; display_wen = 1; end
            486: begin dynamic_hex = a0[27:24]; display_wen = 1; end
            487: begin dynamic_hex = a0[23:20]; display_wen = 1; end
            488: begin dynamic_hex = a0[19:16]; display_wen = 1; end
            489: begin dynamic_hex = a0[15:12]; display_wen = 1; end
            490: begin dynamic_hex = a0[11:8]; display_wen = 1; end
            491: begin dynamic_hex = a0[7:4]; display_wen = 1; end
            492: begin dynamic_hex = a0[3:0]; display_wen = 1; end
            500: begin dynamic_hex = a1[31:28]; display_wen = 1; end
            501: begin dynamic_hex = a1[27:24]; display_wen = 1; end
            502: begin dynamic_hex = a1[23:20]; display_wen = 1; end
            503: begin dynamic_hex = a1[19:16]; display_wen = 1; end
            504: begin dynamic_hex = a1[15:12]; display_wen = 1; end
            505: begin dynamic_hex = a1[11:8]; display_wen = 1; end
            506: begin dynamic_hex = a1[7:4]; display_wen = 1; end
            507: begin dynamic_hex = a1[3:0]; display_wen = 1; end
            515: begin dynamic_hex = a2[31:28]; display_wen = 1; end
            516: begin dynamic_hex = a2[27:24]; display_wen = 1; end
            517: begin dynamic_hex = a2[23:20]; display_wen = 1; end
            518: begin dynamic_hex = a2[19:16]; display_wen = 1; end
            519: begin dynamic_hex = a2[15:12]; display_wen = 1; end
            520: begin dynamic_hex = a2[11:8]; display_wen = 1; end
            521: begin dynamic_hex = a2[7:4]; display_wen = 1; end
            522: begin dynamic_hex = a2[3:0]; display_wen = 1; end
            530: begin dynamic_hex = a3[31:28]; display_wen = 1; end
            531: begin dynamic_hex = a3[27:24]; display_wen = 1; end
            532: begin dynamic_hex = a3[23:20]; display_wen = 1; end
            533: begin dynamic_hex = a3[19:16]; display_wen = 1; end
            534: begin dynamic_hex = a3[15:12]; display_wen = 1; end
            535: begin dynamic_hex = a3[11:8]; display_wen = 1; end
            536: begin dynamic_hex = a3[7:4]; display_wen = 1; end
            537: begin dynamic_hex = a3[3:0]; display_wen = 1; end
            545: begin dynamic_hex = a4[31:28]; display_wen = 1; end
            546: begin dynamic_hex = a4[27:24]; display_wen = 1; end
            547: begin dynamic_hex = a4[23:20]; display_wen = 1; end
            548: begin dynamic_hex = a4[19:16]; display_wen = 1; end
            549: begin dynamic_hex = a4[15:12]; display_wen = 1; end
            550: begin dynamic_hex = a4[11:8]; display_wen = 1; end
            551: begin dynamic_hex = a4[7:4]; display_wen = 1; end
            552: begin dynamic_hex = a4[3:0]; display_wen = 1; end
            565: begin dynamic_hex = a5[31:28]; display_wen = 1; end
            566: begin dynamic_hex = a5[27:24]; display_wen = 1; end
            567: begin dynamic_hex = a5[23:20]; display_wen = 1; end
            568: begin dynamic_hex = a5[19:16]; display_wen = 1; end
            569: begin dynamic_hex = a5[15:12]; display_wen = 1; end
            570: begin dynamic_hex = a5[11:8]; display_wen = 1; end
            571: begin dynamic_hex = a5[7:4]; display_wen = 1; end
            572: begin dynamic_hex = a5[3:0]; display_wen = 1; end
            580: begin dynamic_hex = a6[31:28]; display_wen = 1; end
            581: begin dynamic_hex = a6[27:24]; display_wen = 1; end
            582: begin dynamic_hex = a6[23:20]; display_wen = 1; end
            583: begin dynamic_hex = a6[19:16]; display_wen = 1; end
            584: begin dynamic_hex = a6[15:12]; display_wen = 1; end
            585: begin dynamic_hex = a6[11:8]; display_wen = 1; end
            586: begin dynamic_hex = a6[7:4]; display_wen = 1; end
            587: begin dynamic_hex = a6[3:0]; display_wen = 1; end
            595: begin dynamic_hex = a7[31:28]; display_wen = 1; end
            596: begin dynamic_hex = a7[27:24]; display_wen = 1; end
            597: begin dynamic_hex = a7[23:20]; display_wen = 1; end
            598: begin dynamic_hex = a7[19:16]; display_wen = 1; end
            599: begin dynamic_hex = a7[15:12]; display_wen = 1; end
            600: begin dynamic_hex = a7[11:8]; display_wen = 1; end
            601: begin dynamic_hex = a7[7:4]; display_wen = 1; end
            602: begin dynamic_hex = a7[3:0]; display_wen = 1; end
            610: begin dynamic_hex = s2[31:28]; display_wen = 1; end
            611: begin dynamic_hex = s2[27:24]; display_wen = 1; end
            612: begin dynamic_hex = s2[23:20]; display_wen = 1; end
            613: begin dynamic_hex = s2[19:16]; display_wen = 1; end
            614: begin dynamic_hex = s2[15:12]; display_wen = 1; end
            615: begin dynamic_hex = s2[11:8]; display_wen = 1; end
            616: begin dynamic_hex = s2[7:4]; display_wen = 1; end
            617: begin dynamic_hex = s2[3:0]; display_wen = 1; end
            625: begin dynamic_hex = s3[31:28]; display_wen = 1; end
            626: begin dynamic_hex = s3[27:24]; display_wen = 1; end
            627: begin dynamic_hex = s3[23:20]; display_wen = 1; end
            628: begin dynamic_hex = s3[19:16]; display_wen = 1; end
            629: begin dynamic_hex = s3[15:12]; display_wen = 1; end
            630: begin dynamic_hex = s3[11:8]; display_wen = 1; end
            631: begin dynamic_hex = s3[7:4]; display_wen = 1; end
            632: begin dynamic_hex = s3[3:0]; display_wen = 1; end
            645: begin dynamic_hex = s4[31:28]; display_wen = 1; end
            646: begin dynamic_hex = s4[27:24]; display_wen = 1; end
            647: begin dynamic_hex = s4[23:20]; display_wen = 1; end
            648: begin dynamic_hex = s4[19:16]; display_wen = 1; end
            649: begin dynamic_hex = s4[15:12]; display_wen = 1; end
            650: begin dynamic_hex = s4[11:8]; display_wen = 1; end
            651: begin dynamic_hex = s4[7:4]; display_wen = 1; end
            652: begin dynamic_hex = s4[3:0]; display_wen = 1; end
            660: begin dynamic_hex = s5[31:28]; display_wen = 1; end
            661: begin dynamic_hex = s5[27:24]; display_wen = 1; end
            662: begin dynamic_hex = s5[23:20]; display_wen = 1; end
            663: begin dynamic_hex = s5[19:16]; display_wen = 1; end
            664: begin dynamic_hex = s5[15:12]; display_wen = 1; end
            665: begin dynamic_hex = s5[11:8]; display_wen = 1; end
            666: begin dynamic_hex = s5[7:4]; display_wen = 1; end
            667: begin dynamic_hex = s5[3:0]; display_wen = 1; end
            675: begin dynamic_hex = s6[31:28]; display_wen = 1; end
            676: begin dynamic_hex = s6[27:24]; display_wen = 1; end
            677: begin dynamic_hex = s6[23:20]; display_wen = 1; end
            678: begin dynamic_hex = s6[19:16]; display_wen = 1; end
            679: begin dynamic_hex = s6[15:12]; display_wen = 1; end
            680: begin dynamic_hex = s6[11:8]; display_wen = 1; end
            681: begin dynamic_hex = s6[7:4]; display_wen = 1; end
            682: begin dynamic_hex = s6[3:0]; display_wen = 1; end
            690: begin dynamic_hex = s7[31:28]; display_wen = 1; end
            691: begin dynamic_hex = s7[27:24]; display_wen = 1; end
            692: begin dynamic_hex = s7[23:20]; display_wen = 1; end
            693: begin dynamic_hex = s7[19:16]; display_wen = 1; end
            694: begin dynamic_hex = s7[15:12]; display_wen = 1; end
            695: begin dynamic_hex = s7[11:8]; display_wen = 1; end
            696: begin dynamic_hex = s7[7:4]; display_wen = 1; end
            697: begin dynamic_hex = s7[3:0]; display_wen = 1; end
            705: begin dynamic_hex = s8[31:28]; display_wen = 1; end
            706: begin dynamic_hex = s8[27:24]; display_wen = 1; end
            707: begin dynamic_hex = s8[23:20]; display_wen = 1; end
            708: begin dynamic_hex = s8[19:16]; display_wen = 1; end
            709: begin dynamic_hex = s8[15:12]; display_wen = 1; end
            710: begin dynamic_hex = s8[11:8]; display_wen = 1; end
            711: begin dynamic_hex = s8[7:4]; display_wen = 1; end
            712: begin dynamic_hex = s8[3:0]; display_wen = 1; end
            725: begin dynamic_hex = s9[31:28]; display_wen = 1; end
            726: begin dynamic_hex = s9[27:24]; display_wen = 1; end
            727: begin dynamic_hex = s9[23:20]; display_wen = 1; end
            728: begin dynamic_hex = s9[19:16]; display_wen = 1; end
            729: begin dynamic_hex = s9[15:12]; display_wen = 1; end
            730: begin dynamic_hex = s9[11:8]; display_wen = 1; end
            731: begin dynamic_hex = s9[7:4]; display_wen = 1; end
            732: begin dynamic_hex = s9[3:0]; display_wen = 1; end
            740: begin dynamic_hex = s10[31:28]; display_wen = 1; end
            741: begin dynamic_hex = s10[27:24]; display_wen = 1; end
            742: begin dynamic_hex = s10[23:20]; display_wen = 1; end
            743: begin dynamic_hex = s10[19:16]; display_wen = 1; end
            744: begin dynamic_hex = s10[15:12]; display_wen = 1; end
            745: begin dynamic_hex = s10[11:8]; display_wen = 1; end
            746: begin dynamic_hex = s10[7:4]; display_wen = 1; end
            747: begin dynamic_hex = s10[3:0]; display_wen = 1; end
            755: begin dynamic_hex = s11[31:28]; display_wen = 1; end
            756: begin dynamic_hex = s11[27:24]; display_wen = 1; end
            757: begin dynamic_hex = s11[23:20]; display_wen = 1; end
            758: begin dynamic_hex = s11[19:16]; display_wen = 1; end
            759: begin dynamic_hex = s11[15:12]; display_wen = 1; end
            760: begin dynamic_hex = s11[11:8]; display_wen = 1; end
            761: begin dynamic_hex = s11[7:4]; display_wen = 1; end
            762: begin dynamic_hex = s11[3:0]; display_wen = 1; end
            770: begin dynamic_hex = t3[31:28]; display_wen = 1; end
            771: begin dynamic_hex = t3[27:24]; display_wen = 1; end
            772: begin dynamic_hex = t3[23:20]; display_wen = 1; end
            773: begin dynamic_hex = t3[19:16]; display_wen = 1; end
            774: begin dynamic_hex = t3[15:12]; display_wen = 1; end
            775: begin dynamic_hex = t3[11:8]; display_wen = 1; end
            776: begin dynamic_hex = t3[7:4]; display_wen = 1; end
            777: begin dynamic_hex = t3[3:0]; display_wen = 1; end
            785: begin dynamic_hex = t4[31:28]; display_wen = 1; end
            786: begin dynamic_hex = t4[27:24]; display_wen = 1; end
            787: begin dynamic_hex = t4[23:20]; display_wen = 1; end
            788: begin dynamic_hex = t4[19:16]; display_wen = 1; end
            789: begin dynamic_hex = t4[15:12]; display_wen = 1; end
            790: begin dynamic_hex = t4[11:8]; display_wen = 1; end
            791: begin dynamic_hex = t4[7:4]; display_wen = 1; end
            792: begin dynamic_hex = t4[3:0]; display_wen = 1; end
            805: begin dynamic_hex = t5[31:28]; display_wen = 1; end
            806: begin dynamic_hex = t5[27:24]; display_wen = 1; end
            807: begin dynamic_hex = t5[23:20]; display_wen = 1; end
            808: begin dynamic_hex = t5[19:16]; display_wen = 1; end
            809: begin dynamic_hex = t5[15:12]; display_wen = 1; end
            810: begin dynamic_hex = t5[11:8]; display_wen = 1; end
            811: begin dynamic_hex = t5[7:4]; display_wen = 1; end
            812: begin dynamic_hex = t5[3:0]; display_wen = 1; end
            820: begin dynamic_hex = t6[31:28]; display_wen = 1; end
            821: begin dynamic_hex = t6[27:24]; display_wen = 1; end
            822: begin dynamic_hex = t6[23:20]; display_wen = 1; end
            823: begin dynamic_hex = t6[19:16]; display_wen = 1; end
            824: begin dynamic_hex = t6[15:12]; display_wen = 1; end
            825: begin dynamic_hex = t6[11:8]; display_wen = 1; end
            826: begin dynamic_hex = t6[7:4]; display_wen = 1; end
            827: begin dynamic_hex = t6[3:0]; display_wen = 1; end
            2170: begin dynamic_hex = mstatus_o[31:28]; display_wen = 1; end
            2171: begin dynamic_hex = mstatus_o[27:24]; display_wen = 1; end
            2172: begin dynamic_hex = mstatus_o[23:20]; display_wen = 1; end
            2173: begin dynamic_hex = mstatus_o[19:16]; display_wen = 1; end
            2174: begin dynamic_hex = mstatus_o[15:12]; display_wen = 1; end
            2175: begin dynamic_hex = mstatus_o[11:8]; display_wen = 1; end
            2176: begin dynamic_hex = mstatus_o[7:4]; display_wen = 1; end
            2177: begin dynamic_hex = mstatus_o[3:0]; display_wen = 1; end
            2188: begin dynamic_hex = mcause_o[31:28]; display_wen = 1; end
            2189: begin dynamic_hex = mcause_o[27:24]; display_wen = 1; end
            2190: begin dynamic_hex = mcause_o[23:20]; display_wen = 1; end
            2191: begin dynamic_hex = mcause_o[19:16]; display_wen = 1; end
            2192: begin dynamic_hex = mcause_o[15:12]; display_wen = 1; end
            2193: begin dynamic_hex = mcause_o[11:8]; display_wen = 1; end
            2194: begin dynamic_hex = mcause_o[7:4]; display_wen = 1; end
            2195: begin dynamic_hex = mcause_o[3:0]; display_wen = 1; end
            2204: begin dynamic_hex = mepc_o[31:28]; display_wen = 1; end
            2205: begin dynamic_hex = mepc_o[27:24]; display_wen = 1; end
            2206: begin dynamic_hex = mepc_o[23:20]; display_wen = 1; end
            2207: begin dynamic_hex = mepc_o[19:16]; display_wen = 1; end
            2208: begin dynamic_hex = mepc_o[15:12]; display_wen = 1; end
            2209: begin dynamic_hex = mepc_o[11:8]; display_wen = 1; end
            2210: begin dynamic_hex = mepc_o[7:4]; display_wen = 1; end
            2211: begin dynamic_hex = mepc_o[3:0]; display_wen = 1; end
            2221: begin dynamic_hex = mtval_o[31:28]; display_wen = 1; end
            2222: begin dynamic_hex = mtval_o[27:24]; display_wen = 1; end
            2223: begin dynamic_hex = mtval_o[23:20]; display_wen = 1; end
            2224: begin dynamic_hex = mtval_o[19:16]; display_wen = 1; end
            2225: begin dynamic_hex = mtval_o[15:12]; display_wen = 1; end
            2226: begin dynamic_hex = mtval_o[11:8]; display_wen = 1; end
            2227: begin dynamic_hex = mtval_o[7:4]; display_wen = 1; end
            2228: begin dynamic_hex = mtval_o[3:0]; display_wen = 1; end
            2250: begin dynamic_hex = mtvec_o[31:28]; display_wen = 1; end
            2251: begin dynamic_hex = mtvec_o[27:24]; display_wen = 1; end
            2252: begin dynamic_hex = mtvec_o[23:20]; display_wen = 1; end
            2253: begin dynamic_hex = mtvec_o[19:16]; display_wen = 1; end
            2254: begin dynamic_hex = mtvec_o[15:12]; display_wen = 1; end
            2255: begin dynamic_hex = mtvec_o[11:8]; display_wen = 1; end
            2256: begin dynamic_hex = mtvec_o[7:4]; display_wen = 1; end
            2257: begin dynamic_hex = mtvec_o[3:0]; display_wen = 1; end
            2268: begin dynamic_hex = mie_o[31:28]; display_wen = 1; end
            2269: begin dynamic_hex = mie_o[27:24]; display_wen = 1; end
            2270: begin dynamic_hex = mie_o[23:20]; display_wen = 1; end
            2271: begin dynamic_hex = mie_o[19:16]; display_wen = 1; end
            2272: begin dynamic_hex = mie_o[15:12]; display_wen = 1; end
            2273: begin dynamic_hex = mie_o[11:8]; display_wen = 1; end
            2274: begin dynamic_hex = mie_o[7:4]; display_wen = 1; end
            2275: begin dynamic_hex = mie_o[3:0]; display_wen = 1; end
            2284: begin dynamic_hex = mip_o[31:28]; display_wen = 1; end
            2285: begin dynamic_hex = mip_o[27:24]; display_wen = 1; end
            2286: begin dynamic_hex = mip_o[23:20]; display_wen = 1; end
            2287: begin dynamic_hex = mip_o[19:16]; display_wen = 1; end
            2288: begin dynamic_hex = mip_o[15:12]; display_wen = 1; end
            2289: begin dynamic_hex = mip_o[11:8]; display_wen = 1; end
            2290: begin dynamic_hex = mip_o[7:4]; display_wen = 1; end
            2291: begin dynamic_hex = mip_o[3:0]; display_wen = 1; end
            default: begin dynamic_hex = 0; display_wen = 0; end
        endcase
    end

endmodule
