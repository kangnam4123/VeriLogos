module fabric2_control #(
	parameter PORTNO_WIDTH = 11
)
(
	clk,
	nrst,
	i_I_act,
	i_I_done,
	i_D_act,
	i_D_done,
	i_I_portno,
	i_D_portno,
	o_I_mswitch,
	o_D_mswitch,
	o_p0_sswitch,
	o_p1_sswitch,
	o_p2_sswitch,
	o_p3_sswitch,
	o_p4_sswitch
);
input wire			clk;
input wire			nrst;
input wire			i_I_act;
input wire			i_I_done;
input wire			i_D_act;
input wire			i_D_done;
input wire [PORTNO_WIDTH-1:0]	i_I_portno;
input wire [PORTNO_WIDTH-1:0]	i_D_portno;
output wire [PORTNO_WIDTH-1:0]	o_I_mswitch;
output wire [PORTNO_WIDTH-1:0]	o_D_mswitch;
output wire			o_p0_sswitch;
output wire			o_p1_sswitch;
output wire			o_p2_sswitch;
output wire			o_p3_sswitch;
output wire			o_p4_sswitch;
reg			instr_act_r;
reg			data_act_r;
reg [PORTNO_WIDTH-1:0]	i_portno_r;
reg [PORTNO_WIDTH-1:0]	d_portno_r;
wire			instr_act = i_I_act || instr_act_r;
wire			data_act = i_D_act || data_act_r;
wire [PORTNO_WIDTH-1:0]	i_portno = i_I_act ? i_I_portno : i_portno_r;
wire [PORTNO_WIDTH-1:0]	d_portno = i_D_act ? i_D_portno : d_portno_r;
wire			confl = (i_portno == d_portno && instr_act && data_act);
reg			c_sw_r;
always @(posedge clk or negedge nrst)
begin
	if(!nrst)
	begin
		instr_act_r <= 1'b0;
		data_act_r <= 1'b0;
		i_portno_r <= { (PORTNO_WIDTH){1'b0} };
		d_portno_r <= { (PORTNO_WIDTH){1'b0} };
		c_sw_r <= 1'b0;
	end
	else
	begin
		instr_act_r <= ((i_I_act || instr_act_r) && !i_I_done ? 1'b1 : 1'b0);
		data_act_r <= ((i_D_act || data_act_r) && !i_D_done ? 1'b1 : 1'b0);
		if(i_I_act)
			i_portno_r <= i_I_portno;
		if(i_D_act)
			d_portno_r <= i_D_portno;
		if(instr_act && !confl)
			c_sw_r <= 1'b0;
		if(data_act && !confl)
			c_sw_r <= 1'b1;
	end
end
assign o_p0_sswitch = !confl ? ((instr_act && i_portno == 'd0) ? 1'b0 : 1'b1) : c_sw_r;
assign o_p1_sswitch = !confl ? ((instr_act && i_portno == 'd1) ? 1'b0 : 1'b1) : c_sw_r;
assign o_p2_sswitch = !confl ? ((instr_act && i_portno == 'd2) ? 1'b0 : 1'b1) : c_sw_r;
assign o_p3_sswitch = !confl ? ((instr_act && i_portno == 'd3) ? 1'b0 : 1'b1) : c_sw_r;
assign o_p4_sswitch = !confl ? ((instr_act && i_portno == 'd4) ? 1'b0 : 1'b1) : c_sw_r;
assign o_I_mswitch = i_portno;
assign o_D_mswitch = d_portno;
endmodule