module axi_dmac_resize_dest #(
  parameter DATA_WIDTH_DEST = 64,
  parameter DATA_WIDTH_MEM = 64
) (
  input clk,
  input reset,
  input mem_data_valid,
  output mem_data_ready,
  input [DATA_WIDTH_MEM-1:0] mem_data,
  input mem_data_last,
  output dest_data_valid,
  input dest_data_ready,
  output [DATA_WIDTH_DEST-1:0] dest_data,
  output dest_data_last
);
generate if (DATA_WIDTH_DEST == DATA_WIDTH_MEM)  begin
  assign dest_data_valid = mem_data_valid;
  assign dest_data = mem_data;
  assign dest_data_last = mem_data_last;
  assign mem_data_ready = dest_data_ready;
end else begin
  localparam RATIO = DATA_WIDTH_MEM / DATA_WIDTH_DEST;
  reg [$clog2(RATIO)-1:0] count = 'h0;
  reg valid = 1'b0;
  reg [RATIO-1:0] last = 'h0;
  reg [DATA_WIDTH_MEM-1:0] data = 'h0;
  wire last_beat;
  assign last_beat = count == RATIO - 1;
  always @(posedge clk) begin
    if (reset == 1'b1) begin
      valid <= 1'b0;
    end else if (mem_data_valid == 1'b1) begin
      valid <= 1'b1;
    end else if (last_beat == 1'b1 && dest_data_ready == 1'b1) begin
      valid <= 1'b0;
    end
  end
  always @(posedge clk) begin
    if (reset == 1'b1) begin
      count <= 'h0;
    end else if (dest_data_ready == 1'b1 && dest_data_valid == 1'b1) begin
      count <= count + 1;
    end
  end
  assign mem_data_ready = ~valid | (dest_data_ready & last_beat);
  always @(posedge clk) begin
    if (mem_data_ready == 1'b1) begin
      data <= mem_data;
      last <= {mem_data_last,{RATIO-1{1'b0}}};
    end else if (dest_data_ready == 1'b1) begin
      data[DATA_WIDTH_MEM-DATA_WIDTH_DEST-1:0] <= data[DATA_WIDTH_MEM-1:DATA_WIDTH_DEST];
      last[RATIO-2:0] <= last[RATIO-1:1];
    end
  end
  assign dest_data_valid = valid;
  assign dest_data = data[DATA_WIDTH_DEST-1:0];
  assign dest_data_last = last[0];
end endgenerate
endmodule