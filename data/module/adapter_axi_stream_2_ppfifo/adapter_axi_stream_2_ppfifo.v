module adapter_axi_stream_2_ppfifo #(
  parameter                         DATA_WIDTH = 32,
  parameter                         STROBE_WIDTH = DATA_WIDTH / 8,
  parameter                         USE_KEEP = 0
)(
  input                             rst,
  input                             i_axi_clk,
  output                            o_axi_ready,
  input       [DATA_WIDTH - 1:0]    i_axi_data,
  input       [STROBE_WIDTH - 1:0]  i_axi_keep,
  input                             i_axi_last,
  input                             i_axi_valid,
  output                            o_ppfifo_clk,
  input       [1:0]                 i_ppfifo_rdy,
  output  reg [1:0]                 o_ppfifo_act,
  input       [23:0]                i_ppfifo_size,
  output  reg                       o_ppfifo_stb,
  output  reg [DATA_WIDTH - 1:0]    o_ppfifo_data
);
localparam      IDLE        = 0;
localparam      READY       = 1;
localparam      RELEASE     = 2;
wire                        clk;  
reg           [3:0]         state;
reg           [23:0]        r_count;
assign  o_ppfifo_clk    = i_axi_clk;
assign  clk             = i_axi_clk;
assign  o_axi_ready     = (o_ppfifo_act > 0) && (r_count < i_ppfifo_size);
always @ (posedge clk) begin
  o_ppfifo_stb              <=  0;
  if (rst) begin
    r_count                 <=  0;
    o_ppfifo_act            <=  0;
    o_ppfifo_data           <=  0;
    state                   <=  IDLE;
  end
  else begin
    case (state)
      IDLE: begin
        o_ppfifo_act        <=  0;
        if ((i_ppfifo_rdy > 0) && (o_ppfifo_act == 0)) begin
          r_count           <=  0;
          if (i_ppfifo_rdy[0]) begin
            o_ppfifo_act[0] <=  1;
          end
          else begin
            o_ppfifo_act[1] <=  1;
          end
          state             <=  READY;
        end
      end
      READY: begin
        if (r_count < i_ppfifo_size) begin
          if (i_axi_valid) begin
            o_ppfifo_stb    <=  1;
            o_ppfifo_data   <=  i_axi_data;
            r_count         <=  r_count + 1;
          end
        end
        else begin
          state             <=  RELEASE;
        end
        if (i_axi_last) begin
          state             <=  RELEASE;
        end
      end
      RELEASE: begin
        o_ppfifo_act        <=  0;
        state               <=  IDLE;
      end
      default: begin
      end
    endcase
  end
end
endmodule