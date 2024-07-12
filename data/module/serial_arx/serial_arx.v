module serial_arx (
    input  clk,
    input  rxd,
    input  baud8tick, 
    output reg [7:0] rxd_data,
    output reg       rxd_data_ready, 
    output reg rxd_endofpacket,  
    output rxd_idle  
  );
  reg [1:0] rxd_sync_inv;  
  always @(posedge clk) if(baud8tick) rxd_sync_inv <= {rxd_sync_inv[0], ~rxd};
  reg [1:0] rxd_cnt_inv;
  reg rxd_bit_inv;
  always @(posedge clk)
  if(baud8tick) begin
    if( rxd_sync_inv[1] && rxd_cnt_inv!=2'b11) rxd_cnt_inv <= rxd_cnt_inv + 2'h1;
    else
    if(~rxd_sync_inv[1] && rxd_cnt_inv!=2'b00) rxd_cnt_inv <= rxd_cnt_inv - 2'h1;
    if(rxd_cnt_inv==2'b00) rxd_bit_inv <= 1'b0;
    else
    if(rxd_cnt_inv==2'b11) rxd_bit_inv <= 1'b1;
  end
  reg [3:0] state;
  reg [3:0] bit_spacing;
  wire next_bit = (bit_spacing==4'd10);
  always @(posedge clk)
  if(state==0)bit_spacing <= 4'b0000;
  else
  if(baud8tick) bit_spacing <= {bit_spacing[2:0] + 4'b0001} | {bit_spacing[3], 3'b000};
  always @(posedge clk)
  if(baud8tick)
  case(state)
    4'b0000: if(rxd_bit_inv)state <= 4'b1000;  
    4'b1000: if(next_bit)  state <= 4'b1001;  
    4'b1001: if(next_bit)  state <= 4'b1010;  
    4'b1010: if(next_bit)  state <= 4'b1011;  
    4'b1011: if(next_bit)  state <= 4'b1100;  
    4'b1100: if(next_bit)  state <= 4'b1101;  
    4'b1101: if(next_bit)  state <= 4'b1110;  
    4'b1110: if(next_bit)  state <= 4'b1111;  
    4'b1111: if(next_bit)  state <= 4'b0001;  
    4'b0001: if(next_bit)  state <= 4'b0000;  
    default:         state <= 4'b0000;
  endcase
  always @(posedge clk)
  if(baud8tick && next_bit && state[3]) rxd_data <= {~rxd_bit_inv, rxd_data[7:1]};
  always @(posedge clk)
  begin
    rxd_data_ready <= (baud8tick && next_bit && state==4'b0001 && ~rxd_bit_inv);  
  end
  reg [4:0] gap_count;
  always @(posedge clk) if (state!=0) gap_count<=5'h00; else if(baud8tick & ~gap_count[4]) gap_count <= gap_count + 5'h01;
  assign rxd_idle = gap_count[4];
  always @(posedge clk) rxd_endofpacket <= baud8tick & (gap_count==5'h0F);
endmodule