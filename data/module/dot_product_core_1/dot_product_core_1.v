module dot_product_core_1 (
  clk, en, arst_n, input_a_rsc_mgc_in_wire_d, input_b_rsc_mgc_in_wire_d, output_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [7:0] input_a_rsc_mgc_in_wire_d;
  input [7:0] input_b_rsc_mgc_in_wire_d;
  output [7:0] output_rsc_mgc_out_stdreg_d;
  reg [7:0] output_rsc_mgc_out_stdreg_d;
  reg exit_MAC_lpi;
  reg [7:0] acc_sva_1;
  reg [2:0] i_1_sva_1;
  wire [2:0] MAC_acc_itm;
  wire [3:0] nl_MAC_acc_itm;
  wire [7:0] acc_sva_2;
  wire [8:0] nl_acc_sva_2;
  wire [2:0] i_1_sva_2;
  wire [3:0] nl_i_1_sva_2;
  assign nl_acc_sva_2 = (acc_sva_1 & (signext_8_1(~ exit_MAC_lpi))) + conv_s2s_16_8(input_a_rsc_mgc_in_wire_d
      * input_b_rsc_mgc_in_wire_d);
  assign acc_sva_2 = nl_acc_sva_2[7:0];
  assign nl_i_1_sva_2 = (i_1_sva_1 & (signext_3_1(~ exit_MAC_lpi))) + 3'b1;
  assign i_1_sva_2 = nl_i_1_sva_2[2:0];
  assign nl_MAC_acc_itm = i_1_sva_2 + 3'b11;
  assign MAC_acc_itm = nl_MAC_acc_itm[2:0];
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      output_rsc_mgc_out_stdreg_d <= 8'b0;
      acc_sva_1 <= 8'b0;
      i_1_sva_1 <= 3'b0;
      exit_MAC_lpi <= 1'b1;
    end
    else begin
      if ( en ) begin
        output_rsc_mgc_out_stdreg_d <= MUX_v_8_2_2({acc_sva_2 , output_rsc_mgc_out_stdreg_d},
            MAC_acc_itm[2]);
        acc_sva_1 <= acc_sva_2;
        i_1_sva_1 <= i_1_sva_2;
        exit_MAC_lpi <= ~ (MAC_acc_itm[2]);
      end
    end
  end
  function [7:0] signext_8_1;
    input [0:0] vector;
  begin
    signext_8_1= {{7{vector[0]}}, vector};
  end
  endfunction
  function [2:0] signext_3_1;
    input [0:0] vector;
  begin
    signext_3_1= {{2{vector[0]}}, vector};
  end
  endfunction
  function [7:0] MUX_v_8_2_2;
    input [15:0] inputs;
    input [0:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[15:8];
      end
      1'b1 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[15:8];
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction
  function signed [7:0] conv_s2s_16_8 ;
    input signed [15:0]  vector ;
  begin
    conv_s2s_16_8 = vector[7:0];
  end
  endfunction
endmodule