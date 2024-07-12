module rom_firbank_48_96(
    input wire clk,
    input wire [4:0] addr,
    output wire [23:0] data);
reg [23:0] data_ff;
assign data = data_ff;
always @(posedge clk) begin
    case(addr)
        0: data_ff <= 24'h164B2D; 
        1: data_ff <= 24'hF5BAE8; 
        2: data_ff <= 24'h0633AB; 
        3: data_ff <= 24'hFC29F9; 
        4: data_ff <= 24'h0242A4; 
        5: data_ff <= 24'hFEC9C7; 
        6: data_ff <= 24'h008EDD; 
        7: data_ff <= 24'hFFCE7B; 
        8: data_ff <= 24'h0005BB; 
        9: data_ff <= 24'h00091C; 
        10: data_ff <= 24'hFFF5DC; 
        11: data_ff <= 24'h0006AF; 
        12: data_ff <= 24'hFFFCC4; 
        13: data_ff <= 24'h000124; 
        14: data_ff <= 24'hFFFFC3; 
        15: data_ff <= 24'h000004; 
        16: data_ff <= 24'h35A6A3; 
        17: data_ff <= 24'hF90C13; 
        18: data_ff <= 24'h01922A; 
        19: data_ff <= 24'h005211; 
        20: data_ff <= 24'hFEFDCB; 
        21: data_ff <= 24'h011F4C; 
        22: data_ff <= 24'hFF0A15; 
        23: data_ff <= 24'h00B389; 
        24: data_ff <= 24'hFF8D35; 
        25: data_ff <= 24'h00406C; 
        26: data_ff <= 24'hFFE0A7; 
        27: data_ff <= 24'h000CDE; 
        28: data_ff <= 24'hFFFBC5; 
        29: data_ff <= 24'h0000FE; 
        30: data_ff <= 24'hFFFFE3; 
        31: data_ff <= 24'hFFFFFF; 
        default: data_ff <= 0;
    endcase
end
endmodule