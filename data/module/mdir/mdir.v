module mdir(clk, mdir_we, mdir_next, size, sx, mdir);
    input clk;
    input mdir_we;
    input [31:0] mdir_next;
    input [1:0] size;
    input sx;
    output reg [31:0] mdir;
  reg [31:0] data;
  always @(posedge clk) begin
    if (mdir_we == 1) begin
      data <= mdir_next;
    end
  end
  always @(*) begin
    case ({ size, sx })
      3'b000:
        begin
          mdir[31:0] = { 24'h000000, data[7:0] };
        end
      3'b001:
        begin
          if (data[7] == 1) begin
            mdir[31:0] = { 24'hFFFFFF, data[7:0] };
          end else begin
            mdir[31:0] = { 24'h000000, data[7:0] };
          end
        end
      3'b010:
        begin
          mdir[31:0] = { 16'h0000, data[15:0] };
        end
      3'b011:
        begin
          if (data[15] == 1) begin
            mdir[31:0] = { 16'hFFFF, data[15:0] };
          end else begin
            mdir[31:0] = { 16'h0000, data[15:0] };
          end
        end
      default:
        begin
          mdir[31:0] = data[31:0];
        end
    endcase
  end
endmodule