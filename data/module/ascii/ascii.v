module ascii (
    input scan_ready,
    input [7:0] scan_code,
    output [7:0] ascii
);
    reg [7:0] r_ascii;
    assign ascii = r_ascii;
    reg keyup = 0;
    always @(posedge scan_ready) begin
        if (scan_code == 8'hf0) begin
            keyup <= 1;
        end else begin
            if (keyup) begin
                keyup <= 0;
                r_ascii <= 8'd0;
            end else 
            case (scan_code)
                8'h29: r_ascii <= 8'd32;  
                8'h45: r_ascii <= 8'd48;  
                8'h16: r_ascii <= 8'd49;  
                8'h1e: r_ascii <= 8'd50;  
                8'h26: r_ascii <= 8'd51;  
                8'h25: r_ascii <= 8'd52;  
                8'h2e: r_ascii <= 8'd53;  
                8'h36: r_ascii <= 8'd54;  
                8'h3d: r_ascii <= 8'd55;  
                8'h3e: r_ascii <= 8'd56;  
                8'h46: r_ascii <= 8'd57;  
                8'h1c: r_ascii <= 8'd97;  
                8'h32: r_ascii <= 8'd98;  
                8'h21: r_ascii <= 8'd99;  
                8'h23: r_ascii <= 8'd100; 
                8'h24: r_ascii <= 8'd101; 
                8'h2b: r_ascii <= 8'd102; 
                8'h34: r_ascii <= 8'd103; 
                8'h33: r_ascii <= 8'd104; 
                8'h43: r_ascii <= 8'd105; 
                8'h3b: r_ascii <= 8'd106; 
                8'h42: r_ascii <= 8'd107; 
                8'h4b: r_ascii <= 8'd108; 
                8'h3a: r_ascii <= 8'd109; 
                8'h31: r_ascii <= 8'd110; 
                8'h44: r_ascii <= 8'd111; 
                8'h4d: r_ascii <= 8'd112; 
                8'h15: r_ascii <= 8'd113; 
                8'h2d: r_ascii <= 8'd114; 
                8'h1b: r_ascii <= 8'd115; 
                8'h2c: r_ascii <= 8'd116; 
                8'h3c: r_ascii <= 8'd117; 
                8'h2a: r_ascii <= 8'd118; 
                8'h1d: r_ascii <= 8'd119; 
                8'h22: r_ascii <= 8'd120; 
                8'h35: r_ascii <= 8'd121; 
                8'h1a: r_ascii <= 8'd122; 
                default: r_ascii <= 8'd0; 
            endcase
        end
    end
endmodule