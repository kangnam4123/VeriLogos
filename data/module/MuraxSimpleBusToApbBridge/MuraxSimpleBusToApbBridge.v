module MuraxSimpleBusToApbBridge (
      input   io_simpleBus_cmd_valid,
      output  io_simpleBus_cmd_ready,
      input   io_simpleBus_cmd_payload_wr,
      input  [31:0] io_simpleBus_cmd_payload_address,
      input  [31:0] io_simpleBus_cmd_payload_data,
      input  [3:0] io_simpleBus_cmd_payload_mask,
      output  io_simpleBus_rsp_valid,
      output [31:0] io_simpleBus_rsp_payload_data,
      output [19:0] io_apb_PADDR,
      output [0:0] io_apb_PSEL,
      output  io_apb_PENABLE,
      input   io_apb_PREADY,
      output  io_apb_PWRITE,
      output [31:0] io_apb_PWDATA,
      input  [31:0] io_apb_PRDATA,
      input   io_apb_PSLVERROR,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_10;
  wire  _zz_11;
  wire  simpleBusStage_cmd_valid;
  reg  simpleBusStage_cmd_ready;
  wire  simpleBusStage_cmd_payload_wr;
  wire [31:0] simpleBusStage_cmd_payload_address;
  wire [31:0] simpleBusStage_cmd_payload_data;
  wire [3:0] simpleBusStage_cmd_payload_mask;
  reg  simpleBusStage_rsp_valid;
  wire [31:0] simpleBusStage_rsp_payload_data;
  wire  _zz_1;
  reg  _zz_2;
  reg  _zz_3;
  reg  _zz_4;
  reg [31:0] _zz_5;
  reg [31:0] _zz_6;
  reg [3:0] _zz_7;
  reg  _zz_8;
  reg [31:0] _zz_9;
  reg  state;
  assign _zz_10 = (! _zz_2);
  assign _zz_11 = (! state);
  assign io_simpleBus_cmd_ready = _zz_3;
  assign simpleBusStage_cmd_valid = _zz_2;
  assign _zz_1 = simpleBusStage_cmd_ready;
  assign simpleBusStage_cmd_payload_wr = _zz_4;
  assign simpleBusStage_cmd_payload_address = _zz_5;
  assign simpleBusStage_cmd_payload_data = _zz_6;
  assign simpleBusStage_cmd_payload_mask = _zz_7;
  assign io_simpleBus_rsp_valid = _zz_8;
  assign io_simpleBus_rsp_payload_data = _zz_9;
  always @ (*) begin
    simpleBusStage_cmd_ready = 1'b0;
    simpleBusStage_rsp_valid = 1'b0;
    if(! _zz_11) begin
      if(io_apb_PREADY)begin
        simpleBusStage_rsp_valid = (! simpleBusStage_cmd_payload_wr);
        simpleBusStage_cmd_ready = 1'b1;
      end
    end
  end
  assign io_apb_PSEL[0] = simpleBusStage_cmd_valid;
  assign io_apb_PENABLE = state;
  assign io_apb_PWRITE = simpleBusStage_cmd_payload_wr;
  assign io_apb_PADDR = simpleBusStage_cmd_payload_address[19:0];
  assign io_apb_PWDATA = simpleBusStage_cmd_payload_data;
  assign simpleBusStage_rsp_payload_data = io_apb_PRDATA;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      _zz_2 <= 1'b0;
      _zz_3 <= 1'b1;
      _zz_8 <= 1'b0;
      state <= 1'b0;
    end else begin
      if(_zz_10)begin
        _zz_2 <= io_simpleBus_cmd_valid;
        _zz_3 <= (! io_simpleBus_cmd_valid);
      end else begin
        _zz_2 <= (! _zz_1);
        _zz_3 <= _zz_1;
      end
      _zz_8 <= simpleBusStage_rsp_valid;
      if(_zz_11)begin
        state <= simpleBusStage_cmd_valid;
      end else begin
        if(io_apb_PREADY)begin
          state <= 1'b0;
        end
      end
    end
  end
  always @ (posedge io_mainClk) begin
    if(_zz_10)begin
      _zz_4 <= io_simpleBus_cmd_payload_wr;
      _zz_5 <= io_simpleBus_cmd_payload_address;
      _zz_6 <= io_simpleBus_cmd_payload_data;
      _zz_7 <= io_simpleBus_cmd_payload_mask;
    end
    _zz_9 <= simpleBusStage_rsp_payload_data;
  end
endmodule