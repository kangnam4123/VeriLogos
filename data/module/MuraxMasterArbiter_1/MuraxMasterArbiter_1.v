module MuraxMasterArbiter_1 (
      input   io_iBus_cmd_valid,
      output reg  io_iBus_cmd_ready,
      input  [31:0] io_iBus_cmd_payload_pc,
      output  io_iBus_rsp_valid,
      output  io_iBus_rsp_payload_error,
      output [31:0] io_iBus_rsp_payload_inst,
      input   io_dBus_cmd_valid,
      output reg  io_dBus_cmd_ready,
      input   io_dBus_cmd_payload_wr,
      input  [31:0] io_dBus_cmd_payload_address,
      input  [31:0] io_dBus_cmd_payload_data,
      input  [1:0] io_dBus_cmd_payload_size,
      output  io_dBus_rsp_ready,
      output  io_dBus_rsp_error,
      output [31:0] io_dBus_rsp_data,
      output reg  io_masterBus_cmd_valid,
      input   io_masterBus_cmd_ready,
      output  io_masterBus_cmd_payload_wr,
      output [31:0] io_masterBus_cmd_payload_address,
      output [31:0] io_masterBus_cmd_payload_data,
      output [3:0] io_masterBus_cmd_payload_mask,
      input   io_masterBus_rsp_valid,
      input  [31:0] io_masterBus_rsp_payload_data,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [3:0] _zz_1_;
  reg  rspPending;
  reg  rspTarget;
  always @ (*) begin
    io_masterBus_cmd_valid = (io_iBus_cmd_valid || io_dBus_cmd_valid);
    io_iBus_cmd_ready = (io_masterBus_cmd_ready && (! io_dBus_cmd_valid));
    io_dBus_cmd_ready = io_masterBus_cmd_ready;
    if((rspPending && (! io_masterBus_rsp_valid)))begin
      io_iBus_cmd_ready = 1'b0;
      io_dBus_cmd_ready = 1'b0;
      io_masterBus_cmd_valid = 1'b0;
    end
  end
  assign io_masterBus_cmd_payload_wr = (io_dBus_cmd_valid && io_dBus_cmd_payload_wr);
  assign io_masterBus_cmd_payload_address = (io_dBus_cmd_valid ? io_dBus_cmd_payload_address : io_iBus_cmd_payload_pc);
  assign io_masterBus_cmd_payload_data = io_dBus_cmd_payload_data;
  always @ (*) begin
    case(io_dBus_cmd_payload_size)
      2'b00 : begin
        _zz_1_ = (4'b0001);
      end
      2'b01 : begin
        _zz_1_ = (4'b0011);
      end
      default : begin
        _zz_1_ = (4'b1111);
      end
    endcase
  end
  assign io_masterBus_cmd_payload_mask = (_zz_1_ <<< io_dBus_cmd_payload_address[1 : 0]);
  assign io_iBus_rsp_valid = (io_masterBus_rsp_valid && (! rspTarget));
  assign io_iBus_rsp_payload_inst = io_masterBus_rsp_payload_data;
  assign io_iBus_rsp_payload_error = 1'b0;
  assign io_dBus_rsp_ready = (io_masterBus_rsp_valid && rspTarget);
  assign io_dBus_rsp_data = io_masterBus_rsp_payload_data;
  assign io_dBus_rsp_error = 1'b0;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      rspPending <= 1'b0;
      rspTarget <= 1'b0;
    end else begin
      if(io_masterBus_rsp_valid)begin
        rspPending <= 1'b0;
      end
      if(((io_masterBus_cmd_valid && io_masterBus_cmd_ready) && (! io_masterBus_cmd_payload_wr)))begin
        rspTarget <= io_dBus_cmd_valid;
        rspPending <= 1'b1;
      end
    end
  end
endmodule