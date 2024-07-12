module adapter_bram_2_axi_stream #(
  parameter                                     AXIS_DATA_WIDTH     = 32,
  parameter                                     BRAM_DEPTH          = 8,
  parameter                                     AXIS_STROBE_WIDTH   = AXIS_DATA_WIDTH / 8,
  parameter                                     USE_KEEP            = 0,
  parameter                                     USER_DEPTH          = 1
)(
  input                                         clk,
  input                                         rst,
  input       [USER_DEPTH - 1:0]                i_axis_user,
  input                                         i_bram_en,
  input       [BRAM_DEPTH - 1:0]                i_bram_size,
  output  reg [BRAM_DEPTH - 1:0]                o_bram_addr,
  input       [AXIS_DATA_WIDTH - 1:0]           i_bram_data,
  output      [USER_DEPTH - 1:0]                o_axis_user,
  input                                         i_axis_ready,
  output      [AXIS_DATA_WIDTH - 1:0]           o_axis_data,
  output                                        o_axis_last,
  output                                        o_axis_valid
);
function integer clogb2 (input integer bit_depth);
begin
  for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
    bit_depth = bit_depth >> 1;
end
endfunction
localparam  IDLE        = 0;
localparam  BRAM_START  = 1;
localparam  BRAM_DELAY  = 2;
localparam  BRAM_READ   = 3;
localparam  BRAM_FIN    = 4;
localparam  AXIS_SEND_DATA   = 1;
localparam  DECOUPLE_DEPTH = 4;
localparam  DECOUPLE_COUNT_SIZE = 2;
reg   [3:0]                   state;
reg   [DECOUPLE_COUNT_SIZE - 1:0]  dstart;
reg   [DECOUPLE_COUNT_SIZE - 1:0]  dend;
reg   [AXIS_DATA_WIDTH - 1:0] dfifo[0:DECOUPLE_DEPTH - 1];  
wire  dempty;
wire  dfull;
wire  dalmost_full;
wire  dlast;
wire  w_axis_active;
reg   r_axis_enable;
assign  o_axis_user       = i_axis_user;
assign  dempty            = (dstart == dend);
assign  dfull             = (dend == (1 << DECOUPLE_COUNT_SIZE) - 1) ?  (dstart == 0) : ((dend + 1) == dstart);
assign  dalmost_full      = (dend == (1 << DECOUPLE_COUNT_SIZE) - 2) ?  (dstart == 0) : (dend == (1 << DECOUPLE_COUNT_SIZE) - 1) ?  (dstart == 1) : ((dend + 2) == dstart);
assign  dlast             = (dstart == (1 << DECOUPLE_COUNT_SIZE) - 1) ? (dend   == 0) : ((dstart + 1) == dend);
assign  o_axis_last       = ((o_bram_addr > i_bram_size) || !i_bram_en) && dlast && (state == BRAM_FIN);
assign  o_axis_valid      = (!dempty && r_axis_enable);
assign  w_axis_active     = (o_axis_valid && i_axis_ready);
assign  o_axis_data       = dfifo[dstart];
integer i;
always @ (posedge clk) begin
  if (rst) begin
    state          <=  IDLE;
    o_bram_addr         <=  0;
    dstart              <=  0;
    dend                <=  0;
    r_axis_enable       <=  0;
    for (i = 0; i < DECOUPLE_DEPTH; i = i + 1) begin
      dfifo[i] <=  0;
    end
  end
  else begin
    case (state)
      IDLE: begin
        o_bram_addr   <=  0;
        dstart        <=  0;
        dend          <=  0;
        if (i_bram_en) begin
          state  <=  BRAM_START;
        end
      end
      BRAM_START: begin
        if (!dfull) begin
          dfifo[dend]   <=  i_bram_data;
          dend          <=  dend + 1;
          o_bram_addr   <=  o_bram_addr + 1;
          if ((o_bram_addr + 1) >= i_bram_size) begin
            state  <=  BRAM_FIN; 
          end
          else begin
            state  <=  BRAM_DELAY;
          end
        end
      end
      BRAM_DELAY: begin
        if (o_bram_addr >= i_bram_size) begin
            state  <=  BRAM_FIN;
        end
        else if (dfull) begin
          state    <=  BRAM_START;
        end
        else begin
          state    <=  BRAM_READ;
          o_bram_addr   <=  o_bram_addr + 1;
        end
      end
      BRAM_READ: begin
        dfifo[dend]     <=  i_bram_data;
        dend            <=  dend + 1;
        if (o_bram_addr > i_bram_size) begin
          state  <=  BRAM_FIN; 
        end
        else if (dfull || dalmost_full) begin
          state  <=  BRAM_START;
        end
        else begin
          o_bram_addr     <=  o_bram_addr + 1;
        end
      end
      BRAM_FIN: begin
        if (!i_bram_en) begin
          state  <=  IDLE;
          r_axis_enable <=  0;
        end
      end
    endcase
    if (!i_bram_en) begin
      state     <= IDLE;
    end
    if (!r_axis_enable && dfull) begin
      r_axis_enable     <=  1;
    end
    else if (dempty && (o_bram_addr >= i_bram_size)) begin
      r_axis_enable     <=  0;
    end
    if (w_axis_active) begin
      dstart            <=  dstart + 1;
    end
  end
end
endmodule