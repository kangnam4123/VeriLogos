module write_signal_breakout (
  write_command_data_in,     
  write_command_data_out,  
  write_address,
  write_length,
  write_park,
  write_end_on_eop,
  write_transfer_complete_IRQ_mask,
  write_early_termination_IRQ_mask,
  write_error_IRQ_mask,
  write_burst_count,      
  write_stride,           
  write_sequence_number,  
  write_stop,
  write_sw_reset
);
  parameter DATA_WIDTH = 256;  
  input [DATA_WIDTH-1:0] write_command_data_in;
  output wire [255:0] write_command_data_out;
  output wire [63:0] write_address;
  output wire [31:0] write_length;
  output wire write_park;
  output wire write_end_on_eop;
  output wire write_transfer_complete_IRQ_mask;
  output wire write_early_termination_IRQ_mask;
  output wire [7:0] write_error_IRQ_mask;
  output wire [7:0] write_burst_count;
  output wire [15:0] write_stride;
  output wire [15:0] write_sequence_number;
  input write_stop;
  input write_sw_reset;
  assign write_address[31:0] = write_command_data_in[63:32];
  assign write_length = write_command_data_in[95:64];
  generate
    if (DATA_WIDTH == 256)
    begin
      assign write_park = write_command_data_in[235];
      assign write_end_on_eop = write_command_data_in[236];
      assign write_transfer_complete_IRQ_mask = write_command_data_in[238];
      assign write_early_termination_IRQ_mask = write_command_data_in[239];
      assign write_error_IRQ_mask = write_command_data_in[247:240];
      assign write_burst_count = write_command_data_in[127:120];
      assign write_stride = write_command_data_in[159:144];
      assign write_sequence_number = write_command_data_in[111:96];
      assign write_address[63:32] = write_command_data_in[223:192];
    end
    else
    begin
      assign write_park = write_command_data_in[107];
      assign write_end_on_eop = write_command_data_in[108];
      assign write_transfer_complete_IRQ_mask = write_command_data_in[110];
      assign write_early_termination_IRQ_mask = write_command_data_in[111];
      assign write_error_IRQ_mask = write_command_data_in[119:112];
      assign write_burst_count = 8'h00;
      assign write_stride = 16'h0000;
      assign write_sequence_number = 16'h0000; 
      assign write_address[63:32] = 32'h00000000;    
    end
  endgenerate
  assign write_command_data_out = {{132{1'b0}},  
                                  write_address[63:32],
                                  write_stride,
                                  write_burst_count,
                                  write_sw_reset,
                                  write_stop,
                                  1'b0,  
                                  write_end_on_eop,
                                  write_length,
                                  write_address[31:0]};
endmodule