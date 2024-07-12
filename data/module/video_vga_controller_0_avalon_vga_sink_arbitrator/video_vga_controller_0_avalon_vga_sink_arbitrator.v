module video_vga_controller_0_avalon_vga_sink_arbitrator (
                                                            clk,
                                                            reset_n,
                                                            video_character_buffer_with_dma_0_avalon_char_source_data,
                                                            video_character_buffer_with_dma_0_avalon_char_source_endofpacket,
                                                            video_character_buffer_with_dma_0_avalon_char_source_startofpacket,
                                                            video_character_buffer_with_dma_0_avalon_char_source_valid,
                                                            video_vga_controller_0_avalon_vga_sink_ready,
                                                            video_vga_controller_0_avalon_vga_sink_data,
                                                            video_vga_controller_0_avalon_vga_sink_endofpacket,
                                                            video_vga_controller_0_avalon_vga_sink_ready_from_sa,
                                                            video_vga_controller_0_avalon_vga_sink_reset,
                                                            video_vga_controller_0_avalon_vga_sink_startofpacket,
                                                            video_vga_controller_0_avalon_vga_sink_valid
                                                         )
;
  output  [ 29: 0] video_vga_controller_0_avalon_vga_sink_data;
  output           video_vga_controller_0_avalon_vga_sink_endofpacket;
  output           video_vga_controller_0_avalon_vga_sink_ready_from_sa;
  output           video_vga_controller_0_avalon_vga_sink_reset;
  output           video_vga_controller_0_avalon_vga_sink_startofpacket;
  output           video_vga_controller_0_avalon_vga_sink_valid;
  input            clk;
  input            reset_n;
  input   [ 29: 0] video_character_buffer_with_dma_0_avalon_char_source_data;
  input            video_character_buffer_with_dma_0_avalon_char_source_endofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_startofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_valid;
  input            video_vga_controller_0_avalon_vga_sink_ready;
  wire    [ 29: 0] video_vga_controller_0_avalon_vga_sink_data;
  wire             video_vga_controller_0_avalon_vga_sink_endofpacket;
  wire             video_vga_controller_0_avalon_vga_sink_ready_from_sa;
  wire             video_vga_controller_0_avalon_vga_sink_reset;
  wire             video_vga_controller_0_avalon_vga_sink_startofpacket;
  wire             video_vga_controller_0_avalon_vga_sink_valid;
  assign video_vga_controller_0_avalon_vga_sink_data = video_character_buffer_with_dma_0_avalon_char_source_data;
  assign video_vga_controller_0_avalon_vga_sink_endofpacket = video_character_buffer_with_dma_0_avalon_char_source_endofpacket;
  assign video_vga_controller_0_avalon_vga_sink_ready_from_sa = video_vga_controller_0_avalon_vga_sink_ready;
  assign video_vga_controller_0_avalon_vga_sink_startofpacket = video_character_buffer_with_dma_0_avalon_char_source_startofpacket;
  assign video_vga_controller_0_avalon_vga_sink_valid = video_character_buffer_with_dma_0_avalon_char_source_valid;
  assign video_vga_controller_0_avalon_vga_sink_reset = ~reset_n;
endmodule