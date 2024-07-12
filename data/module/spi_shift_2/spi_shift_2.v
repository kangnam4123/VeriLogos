module spi_shift_2 #(
  parameter SPI_CHAR_LEN_BITS = 10
)(
  input                           clk,          
  input                           rst,          
  input       [31:0]              len,          
  input                           lsb,          
  input                           go,           
  input                           pos_edge,     
  input                           neg_edge,     
  input                           rx_negedge,   
  input                           tx_negedge,   
  output  reg                     tip,          
  output                          last,         
  input                           s_clk,        
  input                           s_in,         
  output  reg                     s_out,        
  output  reg [SPI_MAX_CHAR-1:0]  miso_data,    
  input       [SPI_MAX_CHAR-1:0]  mosi_data     
);
localparam  SPI_MAX_CHAR        = 2 ** SPI_CHAR_LEN_BITS;
reg     [31:0]                  cnt;          
reg     [SPI_MAX_CHAR-1:0]      data;         
wire                            rx_clk;       
wire                            tx_clk;       
assign last = !(|cnt);
assign rx_clk = (rx_negedge ? neg_edge : pos_edge) && (!last || s_clk);
assign tx_clk = (tx_negedge ? neg_edge : pos_edge) && !last;
always @(posedge clk) begin
  if(rst) begin
    cnt <=  0;
  end
  else begin
    if(tip) begin
      cnt <=  pos_edge ? (cnt - 1) : cnt;
    end
    else begin
      cnt <=  !(|len) ? {1'b1, {SPI_CHAR_LEN_BITS{1'b0}}} : len;
    end
  end
end
always @(posedge clk) begin
  if(rst) begin
    tip <=  1'b0;
  end
  else begin
    if(go && ~tip) begin
      tip <=  1'b1;
    end
    else if(tip && last && pos_edge) begin
      tip <=  1'b0;
    end
  end
end
always @(posedge clk) begin
  if (rst) begin
    s_out   <=  1'b0;
    data    <=  0;
  end
  else begin
    if (tx_clk && tip) begin
      if (!lsb) begin
        s_out         <=  data[(SPI_MAX_CHAR - 1)];
        data     <=  {data[(SPI_MAX_CHAR - 2):0], 1'b1};
      end
      else begin
        s_out         <=  data[0];
        data     <=  {1'b1, data[(SPI_MAX_CHAR - 1):1]};
      end
    end
    if (!tip) begin
      data            <=  mosi_data;
    end
  end
end
always @(posedge clk) begin
  if (rst) begin
    miso_data     <=  0;
  end
  else begin
    if (rx_clk) begin
      miso_data <=  {miso_data[(SPI_MAX_CHAR - 2):0], s_in};
    end
  end
end
endmodule