module inst_rom_1(
    input      [4 :0] addr, 
    output reg [31:0] inst       
    );
    wire [31:0] inst_rom[19:0];  
    assign inst_rom[ 0] = 32'h24010001; 
    assign inst_rom[ 1] = 32'h00011100; 
    assign inst_rom[ 2] = 32'h00411821; 
    assign inst_rom[ 3] = 32'h00022082; 
    assign inst_rom[ 4] = 32'h00642823; 
    assign inst_rom[ 5] = 32'hAC250013; 
    assign inst_rom[ 6] = 32'h00A23027; 
    assign inst_rom[ 7] = 32'h00C33825; 
    assign inst_rom[ 8] = 32'h00E64026; 
    assign inst_rom[ 9] = 32'hAC08001C; 
    assign inst_rom[10] = 32'h00C7482A; 
    assign inst_rom[11] = 32'h11210002; 
    assign inst_rom[12] = 32'h24010004; 
    assign inst_rom[13] = 32'h8C2A0013; 
    assign inst_rom[14] = 32'h15450003; 
    assign inst_rom[15] = 32'h00415824; 
    assign inst_rom[16] = 32'hAC0B001C; 
    assign inst_rom[17] = 32'hAC040010; 
    assign inst_rom[18] = 32'h3C0C000C; 
    assign inst_rom[19] = 32'h08000000; 
    always @(*)
    begin
        case (addr)
            5'd0 : inst <= inst_rom[0 ];
            5'd1 : inst <= inst_rom[1 ];
            5'd2 : inst <= inst_rom[2 ];
            5'd3 : inst <= inst_rom[3 ];
            5'd4 : inst <= inst_rom[4 ];
            5'd5 : inst <= inst_rom[5 ];
            5'd6 : inst <= inst_rom[6 ];
            5'd7 : inst <= inst_rom[7 ];
            5'd8 : inst <= inst_rom[8 ];
            5'd9 : inst <= inst_rom[9 ];
            5'd10: inst <= inst_rom[10];
            5'd11: inst <= inst_rom[11];
            5'd12: inst <= inst_rom[12];
            5'd13: inst <= inst_rom[13];
            5'd14: inst <= inst_rom[14];
            5'd15: inst <= inst_rom[15];
            5'd16: inst <= inst_rom[16];
            5'd17: inst <= inst_rom[17];
            5'd18: inst <= inst_rom[18];
            5'd19: inst <= inst_rom[19];
            default: inst <= 32'd0;
        endcase
    end
endmodule