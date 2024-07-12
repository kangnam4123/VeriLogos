module axis_level_cross #
(
  parameter integer AXIS_TDATA_WIDTH = 32,
  parameter integer CROSS_MASK = 8192,
  parameter ALWAYS_READY = "TRUE"
)
(
  input  wire                        aclk,
  input  wire                        aresetn,
  input wire signed[AXIS_TDATA_WIDTH-1:0] level,
  input wire                        direction,                        
  input  wire signed [AXIS_TDATA_WIDTH-1:0] s_axis_tdata, 
  input wire                        s_axis_tvalid, 
  output wire                       s_axis_tready, 
  input  wire                        m_axis_tready,
  output  wire signed [AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire                        m_axis_tvalid,
  output wire                        state_out
);
reg [1:0] int_cross_reg, int_cross_next; 
reg int_state_reg, int_state_next;
wire int_comp_wire; 
assign int_comp_wire = direction?s_axis_tdata<level:s_axis_tdata>level; 
always @(posedge aclk)
	begin
		if(~aresetn)
      			begin
        			int_state_reg <= 0;
      			end
    		else
    			begin
 				int_state_reg <= int_state_next; 
			end
	end
always @(posedge aclk)
	begin
		int_cross_reg <= int_cross_next; 
  	end
always @*
        begin
		int_cross_next = int_cross_reg;
		int_state_next = int_state_reg;
		if(s_axis_tvalid)
			begin
				int_cross_next = {int_cross_reg[0:0],int_comp_wire}; 
			end
		if(int_cross_reg == 2'b10) 
			begin
				int_state_next = 1'b1; 
			end
	end
 if(ALWAYS_READY == "TRUE")
  assign s_axis_tready = 1'b1;
 else
  assign s_axis_tready = m_axis_tready;
assign m_axis_tvalid = s_axis_tvalid;
assign m_axis_tdata = s_axis_tdata;
assign state_out = int_state_reg;
endmodule