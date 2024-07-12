module aceusb_access(
	input ace_clkin,
	input rst,
	input [5:0] a,
	input [15:0] di,
	output reg [15:0] do,
	input read,
	input write,
	output reg ack,
	output [6:0] aceusb_a,
	inout [15:0] aceusb_d,
	output reg aceusb_oe_n,
	output reg aceusb_we_n,
	output reg ace_mpce_n,
	input ace_mpirq,
	output usb_cs_n,
	output usb_hpi_reset_n,
	input usb_hpi_int
);
assign usb_cs_n = 1'b1;
assign usb_hpi_reset_n = 1'b1;
assign aceusb_a = {a, 1'b0};
reg d_drive;
assign aceusb_d = d_drive ? di : 16'hzz;
reg d_drive_r;
reg aceusb_oe_n_r;
reg aceusb_we_n_r;
reg ace_mpce_n_r;
always @(posedge ace_clkin) begin
	d_drive <= d_drive_r;
	aceusb_oe_n <= aceusb_oe_n_r;
	aceusb_we_n <= aceusb_we_n_r;
	ace_mpce_n <= ace_mpce_n_r;
end
reg d_in_sample;
always @(posedge ace_clkin)
	if(d_in_sample)
		do <= aceusb_d;
reg [2:0] state;
reg [2:0] next_state;
localparam
	IDLE = 3'd0,
	READ = 3'd1,
	READ1 = 3'd2,
	READ2 = 3'd3,
	WRITE = 3'd4,
	ACK = 3'd5;
always @(posedge ace_clkin) begin
	if(rst)
		state <= IDLE;
	else
		state <= next_state;
end
always @(*) begin
	d_drive_r = 1'b0;
	aceusb_oe_n_r = 1'b1;
	aceusb_we_n_r = 1'b1;
	ace_mpce_n_r = 1'b1;
	d_in_sample = 1'b0;
	ack = 1'b0;
	next_state = state;
	case(state)
		IDLE: begin
			if(read) begin
				ace_mpce_n_r = 1'b0;
				next_state = READ;
			end
			if(write) begin
				ace_mpce_n_r = 1'b0;
				next_state = WRITE;
			end
		end
		READ: begin
			ace_mpce_n_r = 1'b0;
			next_state = READ1;
		end
		READ1: begin
			ace_mpce_n_r = 1'b0;
			aceusb_oe_n_r = 1'b0;
			next_state = READ2;
		end
		READ2: begin
			d_in_sample = 1'b1;
			next_state = ACK;
		end
		WRITE: begin
			d_drive_r = 1'b1;
			ace_mpce_n_r = 1'b0;
			aceusb_we_n_r = 1'b0;
			next_state = ACK;
		end
		ACK: begin
			ack = 1'b1;
			next_state = IDLE;
		end
	endcase
end
endmodule