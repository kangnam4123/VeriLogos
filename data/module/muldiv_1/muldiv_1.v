module muldiv_1(clk, a, b, fnc, start, done, error, res);
    input clk;
    input [31:0] a;
    input [31:0] b;
    input [2:0] fnc;
    input start;
    output reg done;
    output reg error;
    output reg [31:0] res;
  reg div;
  reg rem;
  reg [5:0] count;
  reg a_neg;
  reg b_neg;
  reg [31:0] b_abs;
  reg [64:0] q;
  wire [64:1] s;
  wire [64:0] d;
  assign s[64:32] = q[64:32] + { 1'b0, b_abs };
  assign s[31: 1] = q[31: 1];
  assign d[64:32] = q[64:32] - { 1'b0, b_abs };
  assign d[31: 0] = q[31: 0];
  always @(posedge clk) begin
    if (start == 1) begin
      if (fnc[2] == 1 && (| b[31:0]) == 0) begin
        done <= 1;
        error <= 1;
      end else begin
        done <= 0;
        error <= 0;
      end
      div <= fnc[2];
      rem <= fnc[1];
      count <= 6'd0;
      if (fnc[0] == 0 && a[31] == 1) begin
        a_neg <= 1;
        if (fnc[2] == 0) begin
          q[64:32] <= 33'b0;
          q[31: 0] <= ~a + 1;
        end else begin
          q[64:33] <= 32'b0;
          q[32: 1] <= ~a + 1;
          q[ 0: 0] <= 1'b0;
        end
      end else begin
        a_neg <= 0;
        if (fnc[2] == 0) begin
          q[64:32] <= 33'b0;
          q[31: 0] <= a;
        end else begin
          q[64:33] <= 32'b0;
          q[32: 1] <= a;
          q[ 0: 0] <= 1'b0;
        end
      end
      if (fnc[0] == 0 && b[31] == 1) begin
        b_neg <= 1;
        b_abs <= ~b + 1;
      end else begin
        b_neg <= 0;
        b_abs <= b;
      end
    end else begin
      if (done == 0) begin
        if (div == 0) begin
          if (count == 6'd32) begin
            done <= 1;
            if (a_neg == b_neg) begin
              res <= q[31:0];
            end else begin
              res <= ~q[31:0] + 1;
            end
          end else begin
            count <= count + 1;
            if (q[0] == 1) begin
              q <= { 1'b0, s[64:1] };
            end else begin
              q <= { 1'b0, q[64:1] };
            end
          end
        end else begin
          if (count == 6'd32) begin
            done <= 1;
            if (rem == 0) begin
              if (a_neg == b_neg) begin
                res <= q[31:0];
              end else begin
                res <= ~q[31:0] + 1;
              end
            end else begin
              if (a_neg == 0) begin
                res <= q[64:33];
              end else begin
                res <= ~q[64:33] + 1;
              end
            end
          end else begin
            count <= count + 1;
            if (d[64] == 0) begin
              q <= { d[63:0], 1'b1 };
            end else begin
              q <= { q[63:0], 1'b0 };
            end
          end
        end
      end
    end
  end
endmodule