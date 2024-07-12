module util_axis_upscale # (
  parameter NUM_OF_CHANNELS = 4,
  parameter DATA_WIDTH = 24,
  parameter UDATA_WIDTH = 32)(
  input                                           clk,
  input                                           resetn,
  input                                           s_axis_valid,
  output  reg                                     s_axis_ready,
  input       [(NUM_OF_CHANNELS*DATA_WIDTH)-1:0]  s_axis_data,
  output  reg                                     m_axis_valid,
  input                                           m_axis_ready,
  output  reg [(NUM_OF_CHANNELS*UDATA_WIDTH)-1:0] m_axis_data,
  input                                           dfmt_enable,
  input                                           dfmt_type,
  input                                           dfmt_se);
  wire                                        type_s;
  wire                                        signext_s;
  wire                                        sign_s;
  wire    [(NUM_OF_CHANNELS*UDATA_WIDTH)-1:0] data_out_s;
  localparam MSB_WIDTH = UDATA_WIDTH - DATA_WIDTH;
  assign type_s = dfmt_enable & dfmt_type;
  assign signext_s = dfmt_enable & dfmt_se;
  assign sign_s = signext_s & (type_s ^ s_axis_data[(DATA_WIDTH-1)]);
  genvar i;
  generate
  for (i=1; i <= NUM_OF_CHANNELS; i=i+1) begin
    assign data_out_s[(i*UDATA_WIDTH-1):(i*UDATA_WIDTH-MSB_WIDTH)] = {(MSB_WIDTH){sign_s}};
    assign data_out_s[((i-1)*UDATA_WIDTH+DATA_WIDTH-1)] = type_s ^ s_axis_data[(i*DATA_WIDTH-1)];
    assign data_out_s[((i-1)*UDATA_WIDTH+DATA_WIDTH-2):((i-1)*UDATA_WIDTH)] = s_axis_data[(i*DATA_WIDTH-2):((i-1)*DATA_WIDTH)];
  end
  endgenerate
  always @(posedge clk) begin
    if (resetn == 1'b0) begin
      m_axis_valid <= 1'b0;
      s_axis_ready <= 1'b0;
      m_axis_data <= {(NUM_OF_CHANNELS*UDATA_WIDTH){1'b0}};
    end else begin
      m_axis_valid <= s_axis_valid;
      s_axis_ready <= m_axis_ready;
      m_axis_data <= data_out_s;
    end
  end
endmodule