module limbus_nios2_qsys_0_nios2_oci_compute_input_tm_cnt (
                                                             atm_valid,
                                                             dtm_valid,
                                                             itm_valid,
                                                             compute_input_tm_cnt
                                                          )
;
  output  [  1: 0] compute_input_tm_cnt;
  input            atm_valid;
  input            dtm_valid;
  input            itm_valid;
  reg     [  1: 0] compute_input_tm_cnt;
  wire    [  2: 0] switch_for_mux;
  assign switch_for_mux = {itm_valid, atm_valid, dtm_valid};
  always @(switch_for_mux)
    begin
      case (switch_for_mux)
          3'b000: begin
              compute_input_tm_cnt = 0;
          end 
          3'b001: begin
              compute_input_tm_cnt = 1;
          end 
          3'b010: begin
              compute_input_tm_cnt = 1;
          end 
          3'b011: begin
              compute_input_tm_cnt = 2;
          end 
          3'b100: begin
              compute_input_tm_cnt = 1;
          end 
          3'b101: begin
              compute_input_tm_cnt = 2;
          end 
          3'b110: begin
              compute_input_tm_cnt = 2;
          end 
          3'b111: begin
              compute_input_tm_cnt = 3;
          end 
      endcase 
    end
endmodule