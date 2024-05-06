module AsyncResetRegVec_w1_i0_6(
  input   clock,
  input   reset,
  input   io_d,
  output  io_q,
  input   io_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif 
  reg  reg_; 
  assign io_q = reg_; 
  always @(posedge clock or posedge reset) begin
    if (reset) begin 
      reg_ <= 1'h0; 
    end else if (io_en) begin 
      reg_ <= io_d;
    end
  end
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[0:0];
`endif 
  if (reset) begin
    reg_ = 1'h0;
  end
  `endif 
end 
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif 
endmodule