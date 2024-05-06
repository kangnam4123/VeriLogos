module ClockCrossingReg_w32_inTestHarness(
  input         clock,
  input  [31:0] io_d,
  output [31:0] io_q,
  input         io_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif 
  reg [31:0] cdc_reg; 
  assign io_q = cdc_reg; 
  always @(posedge clock) begin
    if (io_en) begin 
      cdc_reg <= io_d; 
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
  cdc_reg = _RAND_0[31:0];
`endif 
  `endif 
end 
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif 
endmodule