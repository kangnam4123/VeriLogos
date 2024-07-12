module       ARM_INT(input wire clk,
							input wire reset,
							input wire INT,
							input wire eret,
							input wire[31:0] pc_next,
							output reg [31:0] pc
							);
reg int_act=0,int_req_r=0,int_en=1;
reg [31:0] EPC;
		assign int_clr = reset|int_act;		
		always @(posedge INT or 				
					posedge int_clr )begin		
			if(int_clr==1 )int_req_r<=0;		
			else int_req_r<=1;					
		end
	always @(posedge clk or posedge reset ) begin	  			
			if (reset)begin EPC     <= 0; 	
								 int_act <= 0;		
								 int_en  <= 1;	
			end 			
			else if(int_req_r & int_en)begin 
							EPC <= pc_next; 		
							int_act<=1;				
							int_en<=0; 				
				  end
				  else begin int_act<=0; 	
						 if(eret) int_en<=1;	 	
						 end
	end
		always @* begin
			if (reset==1)pc <= 32'h00000000; 
			else if(int_req_r & int_en )
					  pc <= 32'h00000004;		
				  else if(eret)pc <= EPC; 		
				       else pc <= pc_next;		
		end
endmodule