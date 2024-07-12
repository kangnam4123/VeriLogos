module main_56(
    input cart_fi2,
    output cart_fi2_copy,
    input fi2,
    input cart_s4,
    input cart_s5,
    input cart_rw,
    input cart_cctl,
    output reg cart_rd4 = 1,
    output reg cart_rd5 = 1,
    input [12:0] cart_addr,
    inout [7:0] cart_data,
    output ram_oe,
    output ram_we,
    output [14:0] ram_addr,
    inout [7:0] ram_data,
    input clk,
    inout [7:0] uc_data,
    output reg uc_ack = 0,
    input uc_read,
    input uc_write,
    input set_addr_lo,
    input set_addr_hi,
    input strobe_addr,
    output aux0,
    input aux1,
    input cart_write_enable,
    output dbg0,
    output dbg1);
wire cart_select;
wire cart_ram_select;
wire cart_d5_select;
wire cart_d5ef_select;
wire fi2_falling;
wire fi2_rising;
reg state_cart_write = 0;
reg state_cart_read = 0;
reg state_uc_write = 0;
reg state_uc_read = 0;
reg [1:0] phase = 2'b01;
reg [1:0] fi2_r = 2'b00;
reg s4_r = 1;
reg s5_r = 1;
reg rw_r = 1;
reg cctl_r = 1;
reg rd4_r = 1;
reg rd5_r = 1;
reg [7:0] cart_out_data_latch;
reg [14:0] uc_addr = 0;
reg [7:0] uc_out_data_latch = 0;
reg [13:0] read_address = 0;
assign cart_fi2_copy = cart_fi2 ^ aux1;
assign fi2_falling = fi2_r[1] & ~fi2_r[0];
assign fi2_rising = ~fi2_r[1] & fi2_r[0];
assign cart_ram_select = s4_r ^ s5_r;
assign cart_d5_select = ~cctl_r & (cart_addr[7:3] == 5'b11101);  		
assign cart_d5ef_select = cart_d5_select & cart_addr[2:0] == 3'b111;
assign cart_select = cart_ram_select | cart_d5_select;
assign cart_data = (cart_select & cart_rw & cart_fi2) ? cart_out_data_latch : 8'hzz;
assign ram_addr = (state_cart_read & cart_d5ef_select) ? {1'b1, read_address} :
	              (state_cart_write | state_cart_read) ? {cctl_r, s4_r, cart_addr} :
                  uc_addr;
assign ram_data = state_cart_write ? cart_data :
                  state_uc_write ? uc_data :
                  8'hzz;
assign uc_data = uc_read ? uc_out_data_latch : 8'hzz;
always @(posedge strobe_addr) begin
    if (set_addr_lo)
        uc_addr[7:0] <= uc_data;
    else if (set_addr_hi)
        uc_addr[14:8] <= uc_data[6:0];
    else
        uc_addr <= uc_addr + 1;
end
always @(posedge fi2) begin
    s4_r <= cart_s4;
    s5_r <= cart_s5;
    rw_r <= cart_rw;
    cctl_r <= cart_cctl;
end
always @(posedge clk) begin
    fi2_r <= {fi2_r[0], fi2};
    if (state_cart_write | state_cart_read | state_uc_write | state_uc_read)
        case (phase)
            2'b01: phase <= 2'b11;
            2'b11: phase <= 2'b10;
            2'b10: phase <= 2'b00;
            2'b00: phase <= 2'b01;
        endcase
    case ({state_cart_write, state_cart_read, state_uc_write, state_uc_read})
        4'b0000:
            if (fi2_rising & ~rw_r & (cart_d5_select | (cart_ram_select & cart_write_enable)))
                state_cart_write <= 1;
            else if (fi2_rising & rw_r & cart_select)
                state_cart_read <= 1;
            else if (fi2_falling & uc_write & ~uc_ack)
                state_uc_write <= 1;
            else if (fi2_falling & uc_read & ~uc_ack)
                state_uc_read <= 1;
        4'b1000:
            if (phase == 2'b00)
                state_cart_write <= 0;
        4'b0100:
            if (phase == 2'b00)
                state_cart_read <= 0;
        4'b0010:
            if (phase == 2'b00)
                state_uc_write <= 0;
        4'b0001:
            if (phase == 2'b00)
                state_uc_read <= 0;
    endcase
    if (state_cart_read & phase == 2'b10)
        cart_out_data_latch <= ram_data;
    if (cart_d5_select & state_cart_write & phase[1] & cart_addr[2:0] == 3'b111)
        {rd5_r, rd4_r} <= cart_data[7:6];
    if (state_uc_read & phase == 2'b10)
        uc_out_data_latch <= ram_data;
    if ((state_uc_write | state_uc_read) & phase == 2'b00)
        uc_ack <= 1;
    else if (~uc_write & ~uc_read)
        uc_ack <= 0;
    if (fi2_rising & ~cart_select)
        {cart_rd5, cart_rd4} <= {rd5_r, rd4_r};
	if (state_cart_read & cart_d5ef_select & phase == 2'b00)
		read_address <= read_address + 1;
	else if (state_cart_write & cart_d5ef_select & phase == 2'b00)
		read_address <= {cart_data[4:0], 9'b0};
end
assign ram_oe = ~(state_cart_read | state_uc_read);
assign ram_we = ~((state_cart_write | state_uc_write) & phase[1]);
assign dbg0 = state_uc_read;
assign dbg1 = ram_oe;
assign aux0 = 1;
endmodule