module sm_cpuwr 
  (
   input        ff_wr_pend,
   input        hreset_n,
   input        cpu_wr_gnt,
   input        crt_req,
   input        svga_ack,
   input        mem_clk,
   output reg   cpu_wr_req,        	 
   output       cpu_wr_svga_req,   	 
   output       enwr_cpu_ad_da_pl, 	 
   output       cpu_fifo_read,     	 
   output reg   int_cpu_fifo_rd,
   output       cpu_mem_wr,					  
   output reg   cpu_arb_wr
   );
  reg [2:0]    current_state;
  reg [2:0]    next_state;
  reg          en_cpu_fifo_read;
  reg          wen;
  reg          int_cpu_wr_svga_req;
  wire         t32;
  wire         t34;
  parameter    cpuwr_state0 = 3'b000,
      	       cpuwr_state1 = 3'b001,
	       cpuwr_state2 = 3'b011,
	       cpuwr_state3 = 3'b111,
	       cpuwr_state4 = 3'b110;
  assign       t32 = (ff_wr_pend & (~crt_req));
  assign       t34 = ((~ff_wr_pend) | crt_req);
  assign       cpu_fifo_read = ff_wr_pend & en_cpu_fifo_read;  
  assign       enwr_cpu_ad_da_pl = ff_wr_pend & en_cpu_fifo_read;
  assign       cpu_wr_svga_req  = int_cpu_wr_svga_req & ff_wr_pend;
  assign       cpu_mem_wr = cpu_wr_req;
  always @ (posedge mem_clk or negedge hreset_n) begin
    if (hreset_n == 0) current_state = cpuwr_state0;
    else               current_state = next_state;
  end
  always @* begin
    cpu_wr_req           = 1'b0;
    int_cpu_wr_svga_req  = 1'b0;
    int_cpu_fifo_rd      = 1'b0;
    en_cpu_fifo_read     = 1'b0;
    cpu_arb_wr           = 1'b0;
    case(current_state) 
      cpuwr_state0: next_state = (ff_wr_pend) ? cpuwr_state1 : cpuwr_state0;
      cpuwr_state1: begin
	cpu_wr_req = 1'b1;          
	next_state = (cpu_wr_gnt) ? cpuwr_state2 : cpuwr_state1;
      end
      cpuwr_state2: begin
	cpu_arb_wr = 1'b1;
	cpu_wr_req = 1'b1;
	int_cpu_wr_svga_req = 1'b1; 
	int_cpu_fifo_rd = 1'b1;     
	if (svga_ack)
	  next_state = cpuwr_state3;
	else
	  next_state = cpuwr_state2;
      end
      cpuwr_state3: begin
	cpu_wr_req = 1'b1;
	cpu_arb_wr = 1'b1;
	en_cpu_fifo_read = 1'b1;
        next_state = cpuwr_state4;
      end
      cpuwr_state4: begin
	cpu_wr_req = 1'b1;
	cpu_arb_wr = 1'b1;
	if (t34)      next_state = cpuwr_state0;
	else if (t32) next_state = cpuwr_state2;
	else          next_state = cpuwr_state4;
      end
    endcase
  end   
endmodule