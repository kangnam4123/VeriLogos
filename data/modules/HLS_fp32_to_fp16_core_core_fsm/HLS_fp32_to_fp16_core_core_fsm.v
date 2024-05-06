module HLS_fp32_to_fp16_core_core_fsm (
  nvdla_core_clk, nvdla_core_rstn, core_wen, fsm_output
);
  input nvdla_core_clk;
  input nvdla_core_rstn;
  input core_wen;
  output [1:0] fsm_output;
  reg [1:0] fsm_output;
  parameter
    core_rlp_C_0 = 1'd0,
    main_C_0 = 1'd1;
  reg [0:0] state_var;
  reg [0:0] state_var_NS;
  always @(*)
  begin : HLS_fp32_to_fp16_core_core_fsm_1
    case (state_var)
      main_C_0 : begin
        fsm_output = 2'b10;
        state_var_NS = main_C_0;
      end
      default : begin
        fsm_output = 2'b1;
        state_var_NS = main_C_0;
      end
    endcase
  end
  always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if ( ~ nvdla_core_rstn ) begin
      state_var <= core_rlp_C_0;
    end
    else if ( core_wen ) begin
      state_var <= state_var_NS;
    end
  end
endmodule