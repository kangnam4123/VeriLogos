module LogicProbe_sampler(clock, reset, trigger, sample,
                          data_in, full, rdaddr, data_out);
    input clock;
    input reset;
    input trigger;
    input sample;
    input [127:0] data_in;
    output reg full;
    input [12:0] rdaddr;
    output reg [7:0] data_out;
  reg [31:0] mem3[0:511];
  reg [31:0] mem2[0:511];
  reg [31:0] mem1[0:511];
  reg [31:0] mem0[0:511];
  reg [8:0] wraddr;
  wire [8:0] addr;
  reg [31:0] data3;
  reg [31:0] data2;
  reg [31:0] data1;
  reg [31:0] data0;
  reg [3:0] muxctrl;
  reg triggered;
  assign addr = (full == 0) ? wraddr: rdaddr[12:4];
  always @(posedge clock) begin
    muxctrl <= rdaddr[3:0];
  end
  always @(*) begin
    case (muxctrl)
      4'h0: data_out = data3[31:24];
      4'h1: data_out = data3[23:16];
      4'h2: data_out = data3[15: 8];
      4'h3: data_out = data3[ 7: 0];
      4'h4: data_out = data2[31:24];
      4'h5: data_out = data2[23:16];
      4'h6: data_out = data2[15: 8];
      4'h7: data_out = data2[ 7: 0];
      4'h8: data_out = data1[31:24];
      4'h9: data_out = data1[23:16];
      4'hA: data_out = data1[15: 8];
      4'hB: data_out = data1[ 7: 0];
      4'hC: data_out = data0[31:24];
      4'hD: data_out = data0[23:16];
      4'hE: data_out = data0[15: 8];
      4'hF: data_out = data0[ 7: 0];
    endcase
  end
  always @(posedge clock) begin
    if (full == 0) begin
      mem3[addr] <= data_in[127:96];
      mem2[addr] <= data_in[ 95:64];
      mem1[addr] <= data_in[ 63:32];
      mem0[addr] <= data_in[ 31: 0];
    end
    data3 <= mem3[addr];
    data2 <= mem2[addr];
    data1 <= mem1[addr];
    data0 <= mem0[addr];
  end
  always @(posedge clock) begin
    if (reset == 1) begin
      wraddr <= 9'd0;
      triggered <= 0;
      full <= 0;
    end else begin
      if (triggered == 1) begin
        if (sample == 1) begin
          if (wraddr == 9'd511) begin
            full <= 1;
          end else begin
            wraddr <= wraddr + 1;
          end
        end
      end else begin
        if (trigger == 1) begin
          triggered <= 1;
          if (sample == 1) begin
            wraddr <= wraddr + 1;
          end
        end
      end
    end
  end
endmodule