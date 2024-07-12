module SoundDriver(input CLK, input [15:0] write_data, input write_left, input write_right,
                   output AUD_MCLK, output AUD_LRCK, output AUD_SCK, output AUD_SDIN);
  reg lrck;
  reg [15:0] leftbuf;
  reg [15:0] rightbuf;
  reg [16:0] currbuf;
  reg [3:0] sclk_div;
  reg [4:0] bitcnt_24;   
  wire [4:0] bitcnt_24_new = bitcnt_24 + 1;
  always @(posedge CLK) begin
    if (write_left)  leftbuf <= write_data;
    if (write_right) rightbuf <= write_data;
    sclk_div <= sclk_div + 1;
    if (sclk_div == 4'b1111) begin
      currbuf <= {currbuf[15:0], 1'b0};
      bitcnt_24 <= bitcnt_24_new;
      if (bitcnt_24_new[4:3] == 2'b11) begin
        bitcnt_24[4:3] <= 2'b00; 
        lrck <= !lrck;
        currbuf[15:0] <= lrck ? leftbuf : rightbuf;
      end
    end
  end
  assign AUD_MCLK = sclk_div[0];
  assign AUD_SCK = 1; 
  assign AUD_SDIN = currbuf[16];
  assign AUD_LRCK = lrck;
endmodule