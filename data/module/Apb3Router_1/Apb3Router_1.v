module Apb3Router_1 (
      input  [19:0] io_input_PADDR,
      input  [2:0] io_input_PSEL,
      input   io_input_PENABLE,
      output  io_input_PREADY,
      input   io_input_PWRITE,
      input  [31:0] io_input_PWDATA,
      output [31:0] io_input_PRDATA,
      output  io_input_PSLVERROR,
      output [19:0] io_outputs_0_PADDR,
      output [0:0] io_outputs_0_PSEL,
      output  io_outputs_0_PENABLE,
      input   io_outputs_0_PREADY,
      output  io_outputs_0_PWRITE,
      output [31:0] io_outputs_0_PWDATA,
      input  [31:0] io_outputs_0_PRDATA,
      input   io_outputs_0_PSLVERROR,
      output [19:0] io_outputs_1_PADDR,
      output [0:0] io_outputs_1_PSEL,
      output  io_outputs_1_PENABLE,
      input   io_outputs_1_PREADY,
      output  io_outputs_1_PWRITE,
      output [31:0] io_outputs_1_PWDATA,
      input  [31:0] io_outputs_1_PRDATA,
      input   io_outputs_1_PSLVERROR,
      output [19:0] io_outputs_2_PADDR,
      output [0:0] io_outputs_2_PSEL,
      output  io_outputs_2_PENABLE,
      input   io_outputs_2_PREADY,
      output  io_outputs_2_PWRITE,
      output [31:0] io_outputs_2_PWDATA,
      input  [31:0] io_outputs_2_PRDATA,
      input   io_outputs_2_PSLVERROR,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg  _zz_3_;
  reg [31:0] _zz_4_;
  reg  _zz_5_;
  wire  _zz_1_;
  wire  _zz_2_;
  reg [1:0] selIndex;
  always @(*) begin
    case(selIndex)
      2'b00 : begin
        _zz_3_ = io_outputs_0_PREADY;
        _zz_4_ = io_outputs_0_PRDATA;
        _zz_5_ = io_outputs_0_PSLVERROR;
      end
      2'b01 : begin
        _zz_3_ = io_outputs_1_PREADY;
        _zz_4_ = io_outputs_1_PRDATA;
        _zz_5_ = io_outputs_1_PSLVERROR;
      end
      default : begin
        _zz_3_ = io_outputs_2_PREADY;
        _zz_4_ = io_outputs_2_PRDATA;
        _zz_5_ = io_outputs_2_PSLVERROR;
      end
    endcase
  end
  assign io_outputs_0_PADDR = io_input_PADDR;
  assign io_outputs_0_PENABLE = io_input_PENABLE;
  assign io_outputs_0_PSEL[0] = io_input_PSEL[0];
  assign io_outputs_0_PWRITE = io_input_PWRITE;
  assign io_outputs_0_PWDATA = io_input_PWDATA;
  assign io_outputs_1_PADDR = io_input_PADDR;
  assign io_outputs_1_PENABLE = io_input_PENABLE;
  assign io_outputs_1_PSEL[0] = io_input_PSEL[1];
  assign io_outputs_1_PWRITE = io_input_PWRITE;
  assign io_outputs_1_PWDATA = io_input_PWDATA;
  assign io_outputs_2_PADDR = io_input_PADDR;
  assign io_outputs_2_PENABLE = io_input_PENABLE;
  assign io_outputs_2_PSEL[0] = io_input_PSEL[2];
  assign io_outputs_2_PWRITE = io_input_PWRITE;
  assign io_outputs_2_PWDATA = io_input_PWDATA;
  assign _zz_1_ = io_input_PSEL[1];
  assign _zz_2_ = io_input_PSEL[2];
  assign io_input_PREADY = _zz_3_;
  assign io_input_PRDATA = _zz_4_;
  assign io_input_PSLVERROR = _zz_5_;
  always @ (posedge io_mainClk) begin
    selIndex <= {_zz_2_,_zz_1_};
  end
endmodule