module control_registers (en, ce, wnr, clk, a, din, dout, picoblaze_reset) ;
parameter integer 	C_NUM_PICOBLAZE = 1 ;
parameter integer 	C_BRAM_MAX_ADDR_WIDTH = 10 ;
parameter integer 	C_PICOBLAZE_INSTRUCTION_DATA_WIDTH = 18 ;
parameter integer 	C_JTAG_CHAIN = 2 ;
parameter [4:0] 	C_ADDR_WIDTH_0 = 10 ;
parameter [4:0] 	C_ADDR_WIDTH_1 = 10 ;
parameter [4:0] 	C_ADDR_WIDTH_2 = 10 ;
parameter [4:0] 	C_ADDR_WIDTH_3 = 10 ;
parameter [4:0] 	C_ADDR_WIDTH_4 = 10 ;
parameter [4:0] 	C_ADDR_WIDTH_5 = 10 ;
parameter [4:0] 	C_ADDR_WIDTH_6 = 10 ;
parameter [4:0] 	C_ADDR_WIDTH_7 = 10 ;
input				en ;
input   			ce ;
input				wnr ;
input				clk ;
input	[3:0]			a ;
input	[C_NUM_PICOBLAZE-1:0]	din ;
output	[7:0]			dout ;
output	[C_NUM_PICOBLAZE-1:0]	picoblaze_reset ;
wire	[7:0]			version  ; 				
reg	[C_NUM_PICOBLAZE-1:0]	picoblaze_reset_int ;			
wire	[C_NUM_PICOBLAZE-1:0]	picoblaze_wait_int ;			
reg	[7:0]			dout_int ;				
wire	[2:0]			num_picoblaze ; 			
wire	[4:0]			picoblaze_instruction_data_width ;	
initial picoblaze_reset_int = 0 ;
assign num_picoblaze = C_NUM_PICOBLAZE-3'h1 ;
assign picoblaze_instruction_data_width = C_PICOBLAZE_INSTRUCTION_DATA_WIDTH-5'h01 ;
always @ (posedge clk) begin
        if (en == 1'b1 && wnr == 1'b0 && ce == 1'b1) begin
                case (a) 
                0 :							
                        dout_int <= {num_picoblaze, picoblaze_instruction_data_width};
                1 : 							
                        if (C_NUM_PICOBLAZE >= 1) begin 
                                dout_int <= {picoblaze_reset_int[0], 2'b00, C_ADDR_WIDTH_0-5'h01};
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                2 :							
                        if (C_NUM_PICOBLAZE >= 2) begin 
                                dout_int <= {picoblaze_reset_int[1], 2'b00, C_ADDR_WIDTH_1-5'h01} ;
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                3 : 							
                        if (C_NUM_PICOBLAZE >= 3) begin 
                                dout_int <= {picoblaze_reset_int[2], 2'b00, C_ADDR_WIDTH_2-5'h01} ;
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                4 : 							
                        if (C_NUM_PICOBLAZE >= 4) begin 
                                dout_int <= {picoblaze_reset_int[3], 2'b00, C_ADDR_WIDTH_3-5'h01} ;
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                5: 							
                        if (C_NUM_PICOBLAZE >= 5) begin 
                                dout_int <= {picoblaze_reset_int[4], 2'b00, C_ADDR_WIDTH_4-5'h01} ;
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                6 : 							
                        if (C_NUM_PICOBLAZE >= 6) begin 
                                dout_int <= {picoblaze_reset_int[5], 2'b00, C_ADDR_WIDTH_5-5'h01} ;
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                7 : 							
                        if (C_NUM_PICOBLAZE >= 7) begin 
                                dout_int <= {picoblaze_reset_int[6], 2'b00, C_ADDR_WIDTH_6-5'h01} ;
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                8 : 							
                        if (C_NUM_PICOBLAZE >= 8) begin 
                                dout_int <= {picoblaze_reset_int[7], 2'b00, C_ADDR_WIDTH_7-5'h01} ;
                        end else begin
                                dout_int <= 8'h00 ;
                        end
                15 : 
                        dout_int <= C_BRAM_MAX_ADDR_WIDTH -1 ;
                default :
                        dout_int <= 8'h00 ;
                endcase
	end else begin
                dout_int <= 8'h00 ;
        end
end 
assign dout = dout_int;
always @ (posedge clk) begin
	if (en == 1'b1 && wnr == 1'b1 && ce == 1'b1) begin
		picoblaze_reset_int[C_NUM_PICOBLAZE-1:0] <= din[C_NUM_PICOBLAZE-1:0];
	end
end     
assign picoblaze_reset = picoblaze_reset_int ;
endmodule