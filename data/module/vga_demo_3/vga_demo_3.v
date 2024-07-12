module vga_demo_3
    (
        CLOCK_50,
        RESET,
        VGA_RED,
        VGA_GREEN,
        VGA_BLUE,
        VGA_HS,
        VGA_VS
    );
    input CLOCK_50;
    input RESET;
    output VGA_RED;
    output VGA_GREEN;
    output VGA_BLUE;
    output VGA_HS;
    output VGA_VS;
    reg [10:0] hor_reg; 
    reg hor_sync;
    wire hor_max = (hor_reg == 1039); 
    reg [9:0] ver_reg; 
    reg ver_sync;
    reg red, green, blue;
    wire ver_max = (ver_reg == 665); 
    always @ (posedge CLOCK_50 or posedge RESET) begin
        if (RESET) begin 
            hor_reg <= 0;
            ver_reg <= 0;
        end
        else if (hor_max) begin
            hor_reg <= 0;
            if (ver_max)
                ver_reg <= 0;
            else
            ver_reg <= ver_reg + 1;
        end else
            hor_reg <= hor_reg + 1;
    end
    always @ (posedge CLOCK_50 or posedge RESET) begin
        if (RESET) begin 
            hor_sync <= 0;
            ver_sync <= 0;
        end
        else begin
            if (hor_reg == 856)      
                hor_sync <= 1;       
            else if (hor_reg == 976) 
                hor_sync <= 0;       
            if (ver_reg == 637)      
                ver_sync <= 1;       
            else if (ver_reg == 643) 
                ver_sync <= 0;       
            if (hor_reg >= 100 && hor_reg <= 200 && ver_reg >= 100 && ver_reg <= 200) begin
                red <= 1;
                green <= 0;
                blue <= 0;
            end 
            else begin
                red <= 1;
                green <= 1;
                blue <= 1;
            end
        end
    end
    assign VGA_HS = ~hor_sync;
    assign VGA_VS = ~ver_sync;
    assign VGA_RED =  red && ver_reg < 600 && hor_reg < 800;
    assign VGA_GREEN = green && ver_reg < 600 && hor_reg < 800;
    assign VGA_BLUE = blue && ver_reg < 600 && hor_reg < 800;    
endmodule