module m_1to2_8bit_demux (w_bus_demux_out_0, w_bus_demux_out_1, w_bus_demux_in, w_channel);
	output [7:0] w_bus_demux_out_0, w_bus_demux_out_1;
	input [7:0] w_bus_demux_in;
	input w_channel;
	assign w_bus_demux_out_0 = (w_channel) ? 8'bzzzzzzzz : w_bus_demux_in;
	assign w_bus_demux_out_1 = (w_channel) ? w_bus_demux_in : 8'bzzzzzzzz;
endmodule