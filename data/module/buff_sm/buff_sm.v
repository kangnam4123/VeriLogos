module buff_sm
  #(parameter PORT_USE_FLAG=0)
   (input clk, input reset, input clear,
    input write_done, input access_done, input access_skip_read, input read_done,
    input [1:0] write_port_state, input [1:0] access_port_state, input [1:0] read_port_state,
    output reg [1:0] buff_state);
   localparam BUFF_WRITABLE = 0;
   localparam BUFF_ACCESSIBLE = 1;
   localparam BUFF_READABLE = 2;
   localparam BUFF_ERROR = 3;
   always @(posedge clk)
     if(reset | clear)
       buff_state <= BUFF_WRITABLE;
     else
       case(buff_state)
	 BUFF_WRITABLE :
	   if(write_done & (write_port_state == PORT_USE_FLAG))
	     buff_state <= BUFF_ACCESSIBLE;
	 BUFF_ACCESSIBLE :
	   if(access_done & (access_port_state == PORT_USE_FLAG))
	     if(access_skip_read)
	       buff_state <= BUFF_WRITABLE;
	     else
	       buff_state <= BUFF_READABLE;
	 BUFF_READABLE :
	   if(read_done & (read_port_state == PORT_USE_FLAG))
	     buff_state <= BUFF_WRITABLE;
	 BUFF_ERROR :
	   ;
       endcase
endmodule