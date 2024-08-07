module csr#(
    parameter NUM_CH = 8,
    parameter NUM_SPDIF_IN = 3,
    parameter NUM_RATE = 5,
    parameter VOL_WIDTH = NUM_CH*32,
    parameter NKMDDBG_WIDTH = 16*8,
    parameter RATE_WIDTH = NUM_SPDIF_IN*NUM_RATE,
    parameter UDATA_WIDTH = NUM_SPDIF_IN*192,
    parameter CDATA_WIDTH = UDATA_WIDTH
)(
    input wire clk,
    input wire rst,
    input wire [11:0] addr_i,
    input wire ack_i,
    input wire [7:0] data_i,
    output wire [7:0] data_o,
    output wire [(VOL_WIDTH-1):0] vol_o, 
    output wire nkmd_rst_o, 
    input wire [(NKMDDBG_WIDTH-1):0] nkmd_dbgout_i, 
    output wire [(NKMDDBG_WIDTH-1):0] nkmd_dbgin_o, 
    input wire [(RATE_WIDTH-1):0] rate_i,  
    input wire [(UDATA_WIDTH-1):0] udata_i,  
    input wire [(CDATA_WIDTH-1):0] cdata_i  
    );
reg [7:0] data_o_ff;
reg ack_o_ff;
wire [3:0] addr_tag = addr_i[11:8];
wire [7:0] addr_offset = addr_i[7:0];
reg [(VOL_WIDTH-1):0] vol_ff;
assign vol_o = vol_ff;
reg nkmd_rst_ff;
assign nkmd_rst_o = nkmd_rst_ff;
reg [(NKMDDBG_WIDTH-1):0] nkmd_dbgin_ff;
assign nkmd_dbgin_o = nkmd_dbgin_ff;
integer i;
always @(posedge clk) begin
    if(rst) begin
        vol_ff <= {(NUM_CH*2){16'h00ff}};
        nkmd_rst_ff <= 1'b1;
        nkmd_dbgin_ff <= {(NKMDDBG_WIDTH){1'b0}};
    end else if(ack_i) begin
        case(addr_tag)
            4'h0: begin
                for(i = 0; i < 8; i = i + 1)
                    vol_ff[(addr_offset*8 + i)] <= data_i[i];
            end
            4'h4: begin
                nkmd_rst_ff <= data_i[0];
            end
            4'h6: begin
                for(i = 0; i < 8; i = i + 1)
                    nkmd_dbgin_ff[(addr_offset*8 + i)] <= data_i[i];
            end
        endcase
    end
end
always @(posedge clk) begin
    case(addr_tag)
        4'h0:
            data_o_ff <= vol_ff[(addr_offset*8) +: 8];
        4'h4:
            data_o_ff <= {7'b0000_000, nkmd_rst_ff};
        4'h5:
            data_o_ff <= nkmd_dbgout_i[(addr_offset*8) +: 8];
        4'h6:
            data_o_ff <= nkmd_dbgin_ff[(addr_offset*8) +: 8];
        4'h8:
            data_o_ff <= rate_i[(addr_offset*NUM_RATE) +: NUM_RATE];
        4'h9:
            data_o_ff <= udata_i[(addr_offset*8) +: 8];
        4'ha:
            data_o_ff <= cdata_i[(addr_offset*8) +: 8];
        default:
            data_o_ff <= 0;
    endcase
end
assign data_o = data_o_ff;
endmodule