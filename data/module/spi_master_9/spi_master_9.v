module spi_master_9 (clk, rst, sssd_in, start, miso, data_in, mosi, sck, ss, sssd_out, data_out, busy, new_data);
	input clk;
	input rst;
	input sssd_in; 
	input start;
	input miso; 
	input[7:0] data_in;
	output mosi; 
	output sck;	
	output ss;	
	output sssd_out;
	output[7:0] data_out;
	output busy;
	output new_data;
	  parameter CLK_DIV = 3;		
	  localparam STATE_SIZE = 2;            
	  localparam IDLE = 2'd0,   WAIT_HALF = 2'd1,   TRANSFER = 2'd2;	
	  reg [STATE_SIZE-1:0] state_d, state_q;				
	  reg [7:0] data_d, data_q;						
	  reg [CLK_DIV-1:0] sck_d, sck_q;					
	  reg mosi_d, mosi_q;							
	  reg [2:0] ctr_d, ctr_q;						
	  reg new_data_d, new_data_q;						
	  reg [7:0] data_out_d, data_out_q;		
	  assign sssd_out = sssd_in;	
	  assign mosi = mosi_d;							
	  assign sck = (~sck_q[CLK_DIV-1]) & (state_q == TRANSFER);	
	  assign busy = (state_q != IDLE);				
	  assign ss = !busy;						
	  assign data_out = data_out_q;					
	  assign new_data = new_data_q;					
	always @(*) begin
			 sck_d = sck_q;		
			 data_d = data_q;		
			 mosi_d = mosi_q;		
			 ctr_d = ctr_q;		
			 new_data_d = 1'b0;		
			 data_out_d = data_out_q;	
			 state_d = state_q;		
	    case (state_q)
	      IDLE: begin		   
		sck_d = 4'b0;              
		ctr_d = 3'b0;              
		if (start == 1'b1) begin   
		  data_d = data_in;        
		  state_d = WAIT_HALF;     
		end
	      end
	      WAIT_HALF: begin		   	       
		sck_d = sck_q + 1'b1;                  
		if (sck_q == {CLK_DIV-1{1'b1}}) begin  
		  sck_d = 1'b0;                        
		  state_d = TRANSFER;                  
		end
	      end
	      TRANSFER: begin				
		sck_d = sck_q + 1'b1;                           
		if (sck_q == 4'b0000) begin                     
		  mosi_d = data_q[7];                           
		end 
		else if (sck_q == {CLK_DIV-1{1'b1}}) begin  
		  data_d = {data_q[6:0], miso};      
		end 
		else if (sck_q == {CLK_DIV{1'b1}}) begin    
		  ctr_d = ctr_q + 1'b1;                         
		  if (ctr_q == 3'b111) begin                    
		    state_d = IDLE;                             
		    data_out_d = data_q;                        
		    new_data_d = 1'b1;                          
		  end
		end
	      end
	    endcase
	  end
	  always @(posedge clk) begin
		if (rst) begin
			ctr_q <= 3'b0;
			data_q <= 8'b0;
			sck_q <= 4'b0;
			mosi_q <= 1'b0;
			state_q <= IDLE;
			data_out_q <= 8'b0;
			new_data_q <= 1'b0;
	    	end 
		   else begin
		      ctr_q <= ctr_d;
		      data_q <= data_d;
		      sck_q <= sck_d;
		      mosi_q <= mosi_d;
		      state_q <= state_d;
		      data_out_q <= data_out_d;
		      new_data_q <= new_data_d;
		    end
	  end
endmodule