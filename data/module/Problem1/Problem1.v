module Problem1(
    input [3:0] Binary_Number,
    output reg [6:0] Cathodes,
    output reg Anode
    );
    always @ ( Binary_Number)
    begin
        Anode = 0;
        case(Binary_Number)
            4'b0000: begin			
                 Cathodes[0] = 0;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0; 
                 Cathodes[6] = 1;
                 end
        4'b0001: begin				
                 Cathodes[0] = 1;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 1;
                 Cathodes[4] = 1;
                 Cathodes[5] = 1;
                 Cathodes[6] = 1;
                 end
        4'b0010: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 0;
                 Cathodes[2] = 1;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 1;
                 Cathodes[6] = 0;
                 end
        4'b0011: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 1;
                 Cathodes[5] = 1;
                 Cathodes[6] = 0;
                 end
        4'b0100: begin			
                 Cathodes[0] = 1;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 1;
                 Cathodes[4] = 1;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b0101: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 1;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 1;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b0110: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 1;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b0111: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 1;
                 Cathodes[4] = 1;
                 Cathodes[5] = 1;
                 Cathodes[6] = 1;
                 end
        4'b1000: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b1001: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 1;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b1010: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 1;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b1011: begin				
                 Cathodes[0] = 1;
                 Cathodes[1] = 1;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b1100: begin				
                 Cathodes[0] = 1;
                 Cathodes[1] = 1;
                 Cathodes[2] = 1;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 1;
                 Cathodes[6] = 0;
                 end
        4'b1101: begin				
                 Cathodes[0] = 1;
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 1;
                 Cathodes[6] = 0;
                 end
        4'b1110: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 1;
                 Cathodes[2] = 1;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
        4'b1111: begin				
                 Cathodes[0] = 0;
                 Cathodes[1] = 1;
                 Cathodes[2] = 1;
                 Cathodes[3] = 1;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0;
                 Cathodes[6] = 0;
                 end
            endcase
    end
endmodule