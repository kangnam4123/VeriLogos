module soc_system_master_secure_b2p_adapter (
      input              clk,
      input              reset_n,
      output reg         in_ready,
      input              in_valid,
      input      [ 7: 0] in_data,
      input      [ 7: 0] in_channel,
      input              in_startofpacket,
      input              in_endofpacket,
      input              out_ready,
      output reg         out_valid,
      output reg [ 7: 0] out_data,
      output reg         out_startofpacket,
      output reg         out_endofpacket
);
   reg          out_channel;
   always @* begin
      in_ready = out_ready;
      out_valid = in_valid;
      out_data = in_data;
      out_startofpacket = in_startofpacket;
      out_endofpacket = in_endofpacket;
      out_channel = in_channel       ;
      if (in_channel > 0) begin
         out_valid = 0;
      end
   end
endmodule