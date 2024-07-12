module video_character_buffer_with_dma_0_avalon_char_source_arbitrator (
                                                                          clk,
                                                                          reset_n,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_data,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_endofpacket,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_startofpacket,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_valid,
                                                                          video_vga_controller_0_avalon_vga_sink_ready_from_sa,
                                                                          video_character_buffer_with_dma_0_avalon_char_source_ready
                                                                       )
;
  output           video_character_buffer_with_dma_0_avalon_char_source_ready;
  input            clk;
  input            reset_n;
  input   [ 29: 0] video_character_buffer_with_dma_0_avalon_char_source_data;
  input            video_character_buffer_with_dma_0_avalon_char_source_endofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_startofpacket;
  input            video_character_buffer_with_dma_0_avalon_char_source_valid;
  input            video_vga_controller_0_avalon_vga_sink_ready_from_sa;
  wire             video_character_buffer_with_dma_0_avalon_char_source_ready;
  assign video_character_buffer_with_dma_0_avalon_char_source_ready = video_vga_controller_0_avalon_vga_sink_ready_from_sa;
endmodule