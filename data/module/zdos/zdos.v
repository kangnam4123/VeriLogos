module zdos(
	input  wire        fclk,
	input  wire        rst_n,
	input  wire        dos_turn_on,
	input  wire        dos_turn_off,
	input  wire        cpm_n,
	output reg         dos,
	input  wire        zpos,
	input  wire        m1_n,
	output reg         in_trdemu,
	input  wire        clr_nmi, 
	input  wire        vg_rdwr_fclk,
	input  wire [ 3:0] fdd_mask,
	input  wire [ 1:0] vg_a,
	input  wire        romnram,
	output reg         trdemu_wr_disable
);
	wire trdemu_on = vg_rdwr_fclk && fdd_mask[vg_a] && dos && romnram;
	always @(posedge fclk, negedge rst_n)
	if( !rst_n )
	begin
		dos = 1'b1;
	end
	else 
	begin
		if( !cpm_n )
			dos <= 1'b1;
		else if( dos_turn_off )
			dos <= 1'b0;
		else if( dos_turn_on )
			dos <= 1'b1;
	end
	always @(posedge fclk, negedge rst_n)
	if( !rst_n )
		in_trdemu <= 1'b0;
	else if( clr_nmi )
		in_trdemu <= 1'b0;
	else if( trdemu_on )
		in_trdemu <= 1'b1;
	always @(posedge fclk, negedge rst_n)
	if( !rst_n )
		trdemu_wr_disable <= 1'b0;
	else if( zpos && !m1_n )
		trdemu_wr_disable <= 1'b0;
	else if( trdemu_on )
		trdemu_wr_disable <= 1'b1;
endmodule