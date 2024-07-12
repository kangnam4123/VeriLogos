module gh_fifo_async16_sr(
clk_WR,
clk_RD,
rst,
srst,
WR,
RD,
D,
Q,
empty,
full
);
parameter [31:0] data_width=8;
input clk_WR;
input clk_RD;
input rst;
input srst;
input WR;
input RD;
input [data_width - 1:0] D;
output [data_width - 1:0] Q;
output empty;
output full;
wire clk_WR;
wire clk_RD;
wire rst;
wire srst;
wire WR;
wire RD;
wire [data_width - 1:0] D;
wire [data_width - 1:0] Q;
wire empty;
wire full;
reg [data_width - 1:0] ram_mem[15:0];
wire iempty;
wire ifull;
wire add_WR_CE;
reg [4:0] add_WR;  
reg [4:0] add_WR_GC;  
wire [4:0] n_add_WR;  
reg [4:0] add_WR_RS;  
wire add_RD_CE;
reg [4:0] add_RD;
reg [4:0] add_RD_GC;
reg [4:0] add_RD_GCwc;
wire [4:0] n_add_RD;
reg [4:0] add_RD_WS;  
reg srst_w;
reg isrst_w;
reg srst_r;
reg isrst_r;
  always @(posedge clk_WR) begin
    if(((WR == 1'b 1) && (ifull == 1'b 0))) begin
      ram_mem[(add_WR[3:0])] <= D;
    end
  end
  assign Q = ram_mem[(add_RD[3:0])];
  assign add_WR_CE = (ifull == 1'b 1) ? 1'b 0 : (WR == 1'b 0) ? 1'b 0 : 1'b 1;
  assign n_add_WR = add_WR + 4'h 1;
  always @(posedge clk_WR or posedge rst) begin
    if((rst == 1'b 1)) begin
      add_WR <= {5{1'b0}};
      add_RD_WS <= 5'b 11000;
      add_WR_GC <= {5{1'b0}};
    end else begin
      add_RD_WS <= add_RD_GCwc;
      if((srst_w == 1'b 1)) begin
        add_WR <= {5{1'b0}};
        add_WR_GC <= {5{1'b0}};
      end
      else if((add_WR_CE == 1'b 1)) begin
        add_WR <= n_add_WR;
        add_WR_GC[0] <= n_add_WR[0] ^ n_add_WR[1];
        add_WR_GC[1] <= n_add_WR[1] ^ n_add_WR[2];
        add_WR_GC[2] <= n_add_WR[2] ^ n_add_WR[3];
        add_WR_GC[3] <= n_add_WR[3] ^ n_add_WR[4];
        add_WR_GC[4] <= n_add_WR[4];
      end
      else begin
        add_WR <= add_WR;
        add_WR_GC <= add_WR_GC;
      end
    end
  end
  assign full = ifull;
  assign ifull = (iempty == 1'b 1) ? 1'b 0 : (add_RD_WS != add_WR_GC) ? 1'b 0 : 1'b 1;
  assign add_RD_CE = (iempty == 1'b 1) ? 1'b 0 : (RD == 1'b 0) ? 1'b 0 : 1'b 1;
  assign n_add_RD = add_RD + 4'h 1;
  always @(posedge clk_RD or posedge rst) begin
    if((rst == 1'b 1)) begin
      add_RD <= {5{1'b0}};
      add_WR_RS <= {5{1'b0}};
      add_RD_GC <= {5{1'b0}};
      add_RD_GCwc <= 5'b 11000;
    end else begin
      add_WR_RS <= add_WR_GC;
      if((srst_r == 1'b 1)) begin
        add_RD <= {5{1'b0}};
        add_RD_GC <= {5{1'b0}};
        add_RD_GCwc <= 5'b 11000;
      end
      else if((add_RD_CE == 1'b 1)) begin
        add_RD <= n_add_RD;
        add_RD_GC[0] <= n_add_RD[0] ^ n_add_RD[1];
        add_RD_GC[1] <= n_add_RD[1] ^ n_add_RD[2];
        add_RD_GC[2] <= n_add_RD[2] ^ n_add_RD[3];
        add_RD_GC[3] <= n_add_RD[3] ^ n_add_RD[4];
        add_RD_GC[4] <= n_add_RD[4];
        add_RD_GCwc[0] <= n_add_RD[0] ^ n_add_RD[1];
        add_RD_GCwc[1] <= n_add_RD[1] ^ n_add_RD[2];
        add_RD_GCwc[2] <= n_add_RD[2] ^ n_add_RD[3];
        add_RD_GCwc[3] <= n_add_RD[3] ^ (( ~n_add_RD[4]));
        add_RD_GCwc[4] <= ( ~n_add_RD[4]);
      end
      else begin
        add_RD <= add_RD;
        add_RD_GC <= add_RD_GC;
        add_RD_GCwc <= add_RD_GCwc;
      end
    end
  end
  assign empty = iempty;
  assign iempty = (add_WR_RS == add_RD_GC) ? 1'b 1 : 1'b 0;
  always @(posedge clk_WR or posedge rst) begin
    if((rst == 1'b 1)) begin
      srst_w <= 1'b 0;
      isrst_r <= 1'b 0;
    end else begin
      isrst_r <= srst_r;
      if((srst == 1'b 1)) begin
        srst_w <= 1'b 1;
      end
      else if((isrst_r == 1'b 1)) begin
        srst_w <= 1'b 0;
      end
    end
  end
  always @(posedge clk_RD or posedge rst) begin
    if((rst == 1'b 1)) begin
      srst_r <= 1'b 0;
      isrst_w <= 1'b 0;
    end else begin
      isrst_w <= srst_w;
      if((isrst_w == 1'b 1)) begin
        srst_r <= 1'b 1;
      end
      else begin
        srst_r <= 1'b 0;
      end
    end
  end
endmodule