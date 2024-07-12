module MuraxSimpleBusToApbBridge_1 (
      input   io_simpleBus_cmd_valid,
      output  io_simpleBus_cmd_ready,
      input   io_simpleBus_cmd_payload_wr,
      input  [31:0] io_simpleBus_cmd_payload_address,
      input  [31:0] io_simpleBus_cmd_payload_data,
      input  [3:0] io_simpleBus_cmd_payload_mask,
      output  io_simpleBus_rsp_valid,
      output [31:0] io_simpleBus_rsp_1_data,
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
  wire  _zz_8_;
  wire  _zz_9_;
  wire  simpleBusStage_cmd_valid;
  reg  simpleBusStage_cmd_ready;
  wire  simpleBusStage_cmd_payload_wr;
  wire [31:0] simpleBusStage_cmd_payload_address;
  wire [31:0] simpleBusStage_cmd_payload_data;
  wire [3:0] simpleBusStage_cmd_payload_mask;
  reg  simpleBusStage_rsp_valid;
  wire [31:0] simpleBusStage_rsp_payload_data;
  wire  _zz_1_;
  reg  _zz_2_;
  reg  _zz_3_;
  reg  _zz_4_;
  reg [31:0] _zz_5_;
  reg [31:0] _zz_6_;
  reg [3:0] _zz_7_;
  reg  simpleBusStage_rsp_regNext_valid;
  reg [31:0] simpleBusStage_rsp_regNext_payload_data;
  reg  state;
  assign _zz_8_ = (! state);
  assign _zz_9_ = (! _zz_2_);
  assign io_simpleBus_cmd_ready = _zz_3_;
  assign simpleBusStage_cmd_valid = _zz_2_;
  assign _zz_1_ = simpleBusStage_cmd_ready;
  assign simpleBusStage_cmd_payload_wr = _zz_4_;
  assign simpleBusStage_cmd_payload_address = _zz_5_;
  assign simpleBusStage_cmd_payload_data = _zz_6_;
  assign simpleBusStage_cmd_payload_mask = _zz_7_;
  assign io_simpleBus_rsp_valid = simpleBusStage_rsp_regNext_valid;
  assign io_simpleBus_rsp_1_data = simpleBusStage_rsp_regNext_payload_data;
  always @ (*) begin
    simpleBusStage_cmd_ready = 1'b0;
    simpleBusStage_rsp_valid = 1'b0;
    if(! _zz_8_) begin
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
      _zz_2_ <= 1'b0;
      _zz_3_ <= 1'b1;
      simpleBusStage_rsp_regNext_valid <= 1'b0;
      state <= 1'b0;
    end else begin
      if(_zz_9_)begin
        _zz_2_ <= io_simpleBus_cmd_valid;
        _zz_3_ <= (! io_simpleBus_cmd_valid);
      end else begin
        _zz_2_ <= (! _zz_1_);
        _zz_3_ <= _zz_1_;
      end
      simpleBusStage_rsp_regNext_valid <= simpleBusStage_rsp_valid;
      if(_zz_8_)begin
        state <= simpleBusStage_cmd_valid;
      end else begin
        if(io_apb_PREADY)begin
          state <= 1'b0;
        end
      end
    end
  end
  always @ (posedge io_mainClk) begin
    if(_zz_9_)begin
      _zz_4_ <= io_simpleBus_cmd_payload_wr;
      _zz_5_ <= io_simpleBus_cmd_payload_address;
      _zz_6_ <= io_simpleBus_cmd_payload_data;
      _zz_7_ <= io_simpleBus_cmd_payload_mask;
    end
    simpleBusStage_rsp_regNext_payload_data <= simpleBusStage_rsp_payload_data;
  end
endmodule