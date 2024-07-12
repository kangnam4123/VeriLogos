module mux_8path_4b(
            input [2:0] mux_sel, 
            input [3:0] mux_in7,
            input [3:0] mux_in6,
            input [3:0] mux_in5,
            input [3:0] mux_in4,
            input [3:0] mux_in3,
            input [3:0] mux_in2,
            input [3:0] mux_in1,
            input [3:0] mux_in0,
            output reg [3:0] mux_out); 
        always @(mux_sel or mux_in7 or
                    mux_in6 or mux_in5 or
                    mux_in4 or mux_in3 or
                    mux_in2 or mux_in1 or mux_in0) 
         begin
            mux_out = 4'd0;
            case(mux_sel)
                3'd0: mux_out = mux_in0;
                3'd1: mux_out = mux_in1;
                3'd2: mux_out = mux_in2;
                3'd3: mux_out = mux_in3;
                3'd4: mux_out = mux_in4;
                3'd5: mux_out = mux_in5;
                3'd6: mux_out = mux_in6;
                3'd7: mux_out = mux_in7;
                default: mux_out = 4'h0;
            endcase
         end 
endmodule