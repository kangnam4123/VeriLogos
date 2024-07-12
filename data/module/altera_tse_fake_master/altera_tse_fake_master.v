module altera_tse_fake_master(
   input clk,
   input reset,
   output [8:0] phy_mgmt_address,
   output phy_mgmt_read,
   input [31:0] phy_mgmt_readdata,
   output phy_mgmt_write,
   output reg [31:0] phy_mgmt_writedata,
   input phy_mgmt_waitrequest,
   input sd_loopback
);
reg [1:0] state;
reg [1:0] next_state;
reg sd_loopback_r1, sd_loopback_r2;
reg bit_event;
localparam IDLE = 2'b0 ;
localparam WRITE_DATA = 2'b1;
always @ (posedge clk or posedge reset)
begin
   if (reset)
   begin
      sd_loopback_r1 <= 1'b0;
      sd_loopback_r2 <= 1'b0;
   end
   else
   begin
	   sd_loopback_r2 <= sd_loopback_r1;
	   sd_loopback_r1 <= sd_loopback;
   end
end 
always @ (posedge clk or posedge reset)
begin 
   if (reset)
   begin
      bit_event <= 0;
   end
   else
   begin
      if ( sd_loopback_r1 != sd_loopback_r2)
      begin 
         bit_event <= 1'b1;
      end
      else
      begin
         if (next_state == IDLE && state == WRITE_DATA && phy_mgmt_writedata[0] == sd_loopback)
         begin 
            bit_event <= 1'b0;
         end
      end 
   end
end
always @ (posedge clk or posedge reset)
begin 
     if (reset)
        state <= IDLE;
     else 
        state <= next_state;
end 
always @ (*)
begin
	case (state)
	IDLE:
   begin
		if (bit_event)
		   next_state = WRITE_DATA;
		else 
		   next_state = IDLE;
   end
	WRITE_DATA:
   begin
		if (!phy_mgmt_waitrequest)
			next_state = IDLE;
		else
		   next_state = WRITE_DATA;
   end
	default : next_state = IDLE;
	endcase
end
assign phy_mgmt_write = (state == WRITE_DATA)? 1'b1 : 1'b0;
assign phy_mgmt_read = 1'b0;
assign phy_mgmt_address = (state == WRITE_DATA) ? 9'h61 : 9'h0;
always @(posedge clk or posedge reset)
begin
   if (reset)
   begin
      phy_mgmt_writedata <= 32'b0;
   end
   else
   begin
      if (state == IDLE && next_state == WRITE_DATA)
      begin
         phy_mgmt_writedata <= {31'b0, sd_loopback};
      end
      else if (state == WRITE_DATA && next_state == IDLE)
      begin
         phy_mgmt_writedata <= 32'b0;
      end
   end
end
endmodule