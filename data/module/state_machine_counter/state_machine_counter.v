module state_machine_counter #(
parameter INTR_TYPE = 1'b1
)(
   clk,
	reset_n,
	pulse_irq_counter_stop,
	global_enable_reg,
	counter_start,
	counter_stop,
	enable,
	c_idle,
	level_reset,
	data_store
);
input wire clk;
input wire reset_n;
input wire pulse_irq_counter_stop;
input wire global_enable_reg;
input wire counter_start;
input wire counter_stop;
output reg enable;
output reg level_reset;
output reg data_store;
output reg c_idle;
reg [1:0] state ;
reg [1:0] next_state ;
localparam IDLE  =2'b00;
localparam START =2'b01;
localparam STOP  =2'b10;
localparam STORE =2'b11;
always @ (posedge clk or negedge reset_n)
begin
       if (!reset_n) state <= IDLE;
       else          state<= next_state;
end
always @(state or counter_start or counter_stop or pulse_irq_counter_stop or global_enable_reg) 
      begin
           case (state)
               IDLE: if (counter_start==1'b0 || global_enable_reg == 1'b0 || pulse_irq_counter_stop==1'b1) begin
					           next_state = IDLE;  
                       end else begin                         
							     next_state = START;
							  end
               START: if (global_enable_reg == 1'b0) begin
							     next_state = IDLE;
                            end 
					   else if ((INTR_TYPE == 0 & counter_stop==1'b1) |(INTR_TYPE == 1 & pulse_irq_counter_stop==1'b1))
					        begin
							     next_state = STOP;
					    	end
					   else
					       begin
						        next_state = START;
						   end
               STOP: begin
				  	           next_state = STORE;
							  end  
               STORE: begin
					           next_state = IDLE;
							  end
              default:next_state = IDLE; 
     endcase
end
always @ (state) begin
        case (state)
          IDLE: begin
		           enable = 1'b0;
					  level_reset = 1'b0;
		 			  data_store = 1'b0;
					  c_idle = 1'b1;
		        end
          START: begin
		           enable = 1'b1;
					  level_reset = 1'b1;
					  data_store = 1'b0;
					  c_idle = 1'b0;
		        end 
          STOP: begin
		           enable = 1'b0;
					  level_reset = 1'b1;
					  data_store = 1'b0;
					  c_idle = 1'b0;
		        end 
          STORE: begin
		           enable = 1'b0;
					  level_reset = 1'b1;
					  data_store = 1'b1;
					  c_idle = 1'b0;
		        end
        endcase
end
endmodule