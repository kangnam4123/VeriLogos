module soc_system_button_pio_2 (
                                address,
                                chipselect,
                                clk,
                                in_port,
                                reset_n,
                                write_n,
                                writedata,
                                readdata
                             )
;
  output  [ 31: 0] readdata;
  input   [  1: 0] address;
  input            chipselect;
  input            clk;
  input   [  3: 0] in_port;
  input            reset_n;
  input            write_n;
  input   [ 31: 0] writedata;
  wire             clk_en;
  reg     [  3: 0] d1_data_in;
  reg     [  3: 0] d2_data_in;
  wire    [  3: 0] data_in;
  reg     [  3: 0] edge_capture;
  wire             edge_capture_wr_strobe;
  wire    [  3: 0] edge_detect;
  wire    [  3: 0] read_mux_out;
  reg     [ 31: 0] readdata;
  assign clk_en = 1;
  assign read_mux_out = ({4 {(address == 0)}} & data_in) |
    ({4 {(address == 3)}} & edge_capture);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata <= 0;
      else if (clk_en)
          readdata <= {32'b0 | read_mux_out};
    end
  assign data_in = in_port;
  assign edge_capture_wr_strobe = chipselect && ~write_n && (address == 3);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[0] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[0])
              edge_capture[0] <= 0;
          else if (edge_detect[0])
              edge_capture[0] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[1] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[1])
              edge_capture[1] <= 0;
          else if (edge_detect[1])
              edge_capture[1] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[2] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[2])
              edge_capture[2] <= 0;
          else if (edge_detect[2])
              edge_capture[2] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[3] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[3])
              edge_capture[3] <= 0;
          else if (edge_detect[3])
              edge_capture[3] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          d1_data_in <= 0;
          d2_data_in <= 0;
        end
      else if (clk_en)
        begin
          d1_data_in <= data_in;
          d2_data_in <= d1_data_in;
        end
    end
  assign edge_detect = ~d1_data_in & d2_data_in;
endmodule