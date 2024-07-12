module pixel_panning
  (
   input 	   din,
   input 	   clk,         
   input 	   clk_en,      
   input [3:0]     pp_ctl,      
   input 	   mode_13_ctl,
   input           r_n,
   input           by_4_syn_cclk,
   output 	   dout,
   output 	   dout_1
   );
  reg [8:0]            shift_ff;
  reg [7:0]            mux_ctl; 
  wire [7:0]           int_d;
  wire [7:0]           mux_ctl_8_f_op;
  assign               int_d[7] = mux_ctl[7] ? din : shift_ff[8];
  assign               int_d[6] = mux_ctl[6] ? din : shift_ff[7];
  assign               int_d[5] = mux_ctl[5] ? din : shift_ff[6];
  assign               int_d[4] = mux_ctl[4] ? din : shift_ff[5];
  assign               int_d[3] = mux_ctl[3] ? din : shift_ff[4];
  assign               int_d[2] = mux_ctl[2] ? din : shift_ff[3];
  assign               int_d[1] = mux_ctl[1] ? din : shift_ff[2];
  assign               int_d[0] = mux_ctl[0] ? din : shift_ff[1];
  always@(posedge clk or negedge r_n) begin
    if(~r_n) shift_ff[8:0] <= 8'b0;
    else if (clk_en) begin
      shift_ff[8] <= din;
      shift_ff[7] <= int_d[7];
      shift_ff[6] <= int_d[6];
      shift_ff[5] <= int_d[5];
      shift_ff[4] <= int_d[4];
      shift_ff[3] <= int_d[3];
      shift_ff[2] <= int_d[2];
      shift_ff[1] <= int_d[1];
      shift_ff[0] <= int_d[0];	    
    end
  end
  assign mux_ctl_8_f_op = mode_13_ctl ? 8'b0001_0000 : 8'b0000_0000;
  always @(pp_ctl or mode_13_ctl or mux_ctl_8_f_op or by_4_syn_cclk) begin
    case(pp_ctl) 
      4'h0: mux_ctl = (by_4_syn_cclk) ? 8'b0000_1000 : 8'b1000_0000;
      4'h1: mux_ctl = 8'b0100_0000;
      4'h2: mux_ctl = (mode_13_ctl) ? 8'b0100_0000 : 8'b0010_0000;
      4'h3: mux_ctl = 8'b0001_0000;
      4'h4: mux_ctl = (mode_13_ctl) ? 8'b0010_0000 : 8'b0000_1000;
      4'h5: mux_ctl = 8'b0000_0100;
      4'h6: mux_ctl = (mode_13_ctl) ? 8'b0001_0000 : 8'b0000_0010;
      4'h7: mux_ctl = 8'b0000_0001;
      4'h8: mux_ctl = mux_ctl_8_f_op;
      4'h9: mux_ctl = mux_ctl_8_f_op;
      4'ha: mux_ctl = mux_ctl_8_f_op;
      4'hb: mux_ctl = mux_ctl_8_f_op;
      4'hc: mux_ctl = mux_ctl_8_f_op;
      4'hd: mux_ctl = mux_ctl_8_f_op;
      4'he: mux_ctl = mux_ctl_8_f_op;
      4'hf: mux_ctl = mux_ctl_8_f_op;
    endcase
  end
  assign dout = shift_ff[0];
  assign dout_1 = int_d[0];
endmodule