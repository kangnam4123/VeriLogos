module i2s_writer (
  rst,
  clk,
  enable,
  starved,
  i2s_clock,
  audio_data_request,
  audio_data_ack,
  audio_data,
  audio_lr_bit,
  i2s_data,
  i2s_lr
);
parameter           DATA_SIZE = 32;
input               rst;
input               clk;
input               enable;
input               i2s_clock;
output  reg         audio_data_request;
input               audio_data_ack;
input       [23:0]  audio_data;
input               audio_lr_bit;
output  reg         i2s_data;
output  reg         i2s_lr;
output  reg         starved;
parameter           START         = 4'h0;
parameter           REQUEST_DATA  = 4'h1;
parameter           DATA_READY    = 4'h2;
reg         [7:0]   bit_count;
reg         [23:0]  new_audio_data;
reg                 new_audio_lr_bit;
reg         [23:0]  audio_shifter;
reg         [3:0]   state;
always @ (posedge rst or negedge i2s_clock) begin
  if (rst) begin
    bit_count           <=  DATA_SIZE -1;
    new_audio_data      <=  0;
    new_audio_lr_bit    <=  0;
    audio_shifter       <=  0;
    state               <=  START;
    starved             <=  0;
    i2s_data            <=  0;
    i2s_lr              <=  0;
    audio_data_request  <=  0;
  end
  else if (enable) begin
    starved           <=  0;
    case (state)
      START: begin
         audio_data_request       <=  1;
        if (audio_data_ack) begin
          audio_data_request     <=  0;
          state             <=  DATA_READY;
          new_audio_data    <=  {1'b0, audio_data[23:1]};
          new_audio_lr_bit  <=  audio_lr_bit;
        end
      end
      REQUEST_DATA: begin
        audio_data_request       <=  1;
        if (audio_data_ack) begin
          audio_data_request     <=  0;
          state             <=  DATA_READY;
          new_audio_data    <=  audio_data;
          new_audio_lr_bit  <=  audio_lr_bit;
        end
      end
      DATA_READY: begin
        if (bit_count == DATA_SIZE - 2) begin
          state       <=  REQUEST_DATA;
        end
      end
      default: begin
        state       <=  REQUEST_DATA;
      end
    endcase
    if (bit_count == 0) begin
      if (state == DATA_READY) begin
        bit_count       <=  DATA_SIZE - 1;
        audio_shifter   <=  new_audio_data;
        i2s_lr          <=  new_audio_lr_bit;
        new_audio_data  <=  0;
        new_audio_lr_bit<=  0;
      end
      else begin
        starved         <=  1;
        i2s_data        <=  0;
      end
    end
    else begin
      bit_count         <=  bit_count - 1;
      i2s_data          <=  audio_shifter[23];
      audio_shifter     <=  {audio_shifter[22:0], 1'b0};
    end
  end
end
endmodule