module bw_io_dtlhstl_rcv (
  out, so, 
  pad, ref, clk, pad_clk_en_l, cmsi_clk_en_l, cmsi_l, se_buf, vddo
  );
  input		pad;
  input 	ref;
  input		clk;
  input		pad_clk_en_l;
  input		cmsi_clk_en_l;
  input		cmsi_l;
  input		se_buf;
  input		vddo;
  output	out;
  output	so;
  assign so = out;
  wire net0281 = se_buf; 
  reg out;
  always @(posedge clk) begin
    casex ({ pad_clk_en_l, pad, cmsi_clk_en_l, cmsi_l })
      4'b001x: out <= 1'b0;
      4'b011x: out <= 1'b1;
      4'b1x00: out <= 1'b1;
      4'b1x01: out <= 1'b0;
      default: out <= 1'bx;
      endcase
    end
  endmodule