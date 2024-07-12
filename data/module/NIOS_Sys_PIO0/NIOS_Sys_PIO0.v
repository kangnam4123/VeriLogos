module NIOS_Sys_PIO0 (
                        address,
                        chipselect,
                        clk,
                        reset_n,
                        write_n,
                        writedata,
                        bidir_port,
                        irq,
                        readdata
                     )
;
  inout   [  4: 0] bidir_port;
  output           irq;
  output  [ 31: 0] readdata;
  input   [  1: 0] address;
  input            chipselect;
  input            clk;
  input            reset_n;
  input            write_n;
  input   [ 31: 0] writedata;
  wire    [  4: 0] bidir_port;
  wire             clk_en;
  reg     [  4: 0] d1_data_in;
  reg     [  4: 0] d2_data_in;
  reg     [  4: 0] data_dir;
  wire    [  4: 0] data_in;
  reg     [  4: 0] data_out;
  reg     [  4: 0] edge_capture;
  wire             edge_capture_wr_strobe;
  wire    [  4: 0] edge_detect;
  wire             irq;
  reg     [  4: 0] irq_mask;
  wire    [  4: 0] read_mux_out;
  reg     [ 31: 0] readdata;
  assign clk_en = 1;
  assign read_mux_out = ({5 {(address == 0)}} & data_in) |
    ({5 {(address == 1)}} & data_dir) |
    ({5 {(address == 2)}} & irq_mask) |
    ({5 {(address == 3)}} & edge_capture);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata <= 0;
      else if (clk_en)
          readdata <= {32'b0 | read_mux_out};
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (chipselect && ~write_n && (address == 0))
          data_out <= writedata[4 : 0];
    end
  assign bidir_port[0] = data_dir[0] ? data_out[0] : 1'bZ;
  assign bidir_port[1] = data_dir[1] ? data_out[1] : 1'bZ;
  assign bidir_port[2] = data_dir[2] ? data_out[2] : 1'bZ;
  assign bidir_port[3] = data_dir[3] ? data_out[3] : 1'bZ;
  assign bidir_port[4] = data_dir[4] ? data_out[4] : 1'bZ;
  assign data_in = bidir_port;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_dir <= 0;
      else if (chipselect && ~write_n && (address == 1))
          data_dir <= writedata[4 : 0];
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          irq_mask <= 0;
      else if (chipselect && ~write_n && (address == 2))
          irq_mask <= writedata[4 : 0];
    end
  assign irq = |(data_in      & irq_mask);
  assign edge_capture_wr_strobe = chipselect && ~write_n && (address == 3);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[0] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe)
              edge_capture[0] <= 0;
          else if (edge_detect[0])
              edge_capture[0] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[1] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe)
              edge_capture[1] <= 0;
          else if (edge_detect[1])
              edge_capture[1] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[2] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe)
              edge_capture[2] <= 0;
          else if (edge_detect[2])
              edge_capture[2] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[3] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe)
              edge_capture[3] <= 0;
          else if (edge_detect[3])
              edge_capture[3] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[4] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe)
              edge_capture[4] <= 0;
          else if (edge_detect[4])
              edge_capture[4] <= -1;
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
  assign edge_detect = d1_data_in ^  d2_data_in;
endmodule