module seven_seg_Dev_IO_2(input clk,
							input rst,
							input GPIOe0000000_we,				
							input[2:0]Test,						
							input[31:0]point_in,					
							input[31:0]blink_in,
							input[31:0] Data0,					
							input[31:0] Test_data1,
							input[31:0] Test_data2,
							input[31:0] Test_data3,
							input[31:0] Test_data4,
							input[31:0] Test_data5,
							input[31:0] Test_data6,
							input[31:0] Test_data7,
							output reg[3:0] point_out,
							output reg[3:0] blink_out,
							output reg[31:0]Disp_num=32'h12345678
							);
	always@(posedge clk or posedge rst)	begin				
		if(rst)
			Disp_num <= 32'hAA5555AA;
		else begin
			point_out <= 4'b1111;
			blink_out <= 4'b0000;
			case (Test) 
				3'b000:begin
					if(GPIOe0000000_we) begin Disp_num <= Data0;		
							 blink_out <= blink_in[3:0];
							 point_out <= point_in[3:0];end					 
					else begin Disp_num <= Disp_num; 
							 blink_out <= blink_out;
							 point_out <= point_in[3:0]; end
					end
				3'b001:begin											
					Disp_num <= Test_data1;
					blink_out <= blink_in[7:4];
					point_out <= point_in[7:4];
					end
				3'b010:begin											
					Disp_num <= Test_data2;					
					blink_out <= blink_in[11:8];
					point_out <= point_in[11:8];
					end
				3'b011:begin											
					Disp_num <= Test_data3;					
					blink_out <= blink_in[15:12];
					point_out <= point_in[15:12];
					end				
				3'b100:													
					begin										
					Disp_num <= Test_data4;						
					point_out <= point_in[19:16];
					blink_out <= blink_in[19:16];
					end
				3'b101:begin											
					Disp_num<=Test_data5;						
					point_out <= point_in[23:20];
					blink_out <= blink_in[23:20];
					end
				3'b110:begin											
					Disp_num<=Test_data6;							
					point_out <= point_in[27:24];
					blink_out <= blink_in[27:24];
					end
				4'b111:begin											
					Disp_num<=Test_data7;	
					point_out <= point_in[31:28];
					blink_out <= blink_in[31:28];
					end
			endcase
		end
	end
endmodule