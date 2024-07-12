module mig_7series_v4_0_ddr_phy_ocd_edge #
  (parameter TCQ                = 100)
  (
  scan_right, z2f, f2z, o2f, f2o, zero2fuzz, fuzz2zero,
  oneeighty2fuzz, fuzz2oneeighty,
  clk, samp_done, phy_rddata_en_2, reset_scan, scanning_right,
  samp_result, stg3
  );
  localparam [1:0] NULL       = 2'b11,
                   FUZZ       = 2'b00,
                   ONEEIGHTY  = 2'b10,
                   ZERO       = 2'b01;
  input clk;
  input samp_done;
  input phy_rddata_en_2;
  wire samp_valid = samp_done && phy_rddata_en_2;
  input reset_scan;
  input scanning_right;
  reg prev_samp_valid_ns, prev_samp_valid_r;
  always @(posedge clk) prev_samp_valid_r <= #TCQ prev_samp_valid_ns;
  always @(*) begin
    prev_samp_valid_ns = prev_samp_valid_r;
    if (reset_scan) prev_samp_valid_ns = 1'b0;
    else if (samp_valid) prev_samp_valid_ns = 1'b1;
  end
  input [1:0] samp_result;
  reg [1:0] prev_samp_ns, prev_samp_r;
  always @(posedge clk) prev_samp_r <= #TCQ prev_samp_ns;
  always @(*)
    if (samp_valid) prev_samp_ns = samp_result;
    else prev_samp_ns = prev_samp_r;
  reg scan_right_ns, scan_right_r;
  always @(posedge clk) scan_right_r <= #TCQ scan_right_ns;
  output scan_right;
  assign scan_right = scan_right_r;
  input [5:0] stg3;
  reg z2f_ns, z2f_r, f2z_ns, f2z_r, o2f_ns, o2f_r, f2o_ns, f2o_r;
  always @(posedge clk) z2f_r <= #TCQ z2f_ns;
  always @(posedge clk) f2z_r <= #TCQ f2z_ns;
  always @(posedge clk) o2f_r <= #TCQ o2f_ns;
  always @(posedge clk) f2o_r <= #TCQ f2o_ns;
  output z2f, f2z, o2f, f2o;
  assign z2f = z2f_r;
  assign f2z = f2z_r;
  assign o2f = o2f_r;
  assign f2o = f2o_r;
  reg [5:0] zero2fuzz_ns, zero2fuzz_r, fuzz2zero_ns, fuzz2zero_r, 
            oneeighty2fuzz_ns, oneeighty2fuzz_r, fuzz2oneeighty_ns, fuzz2oneeighty_r;
  always @(posedge clk) zero2fuzz_r <= #TCQ zero2fuzz_ns;
  always @(posedge clk) fuzz2zero_r <= #TCQ fuzz2zero_ns;
  always @(posedge clk) oneeighty2fuzz_r <= #TCQ oneeighty2fuzz_ns;
  always @(posedge clk) fuzz2oneeighty_r <= #TCQ fuzz2oneeighty_ns;
  output [5:0] zero2fuzz, fuzz2zero, oneeighty2fuzz, fuzz2oneeighty;
  assign zero2fuzz = zero2fuzz_r;
  assign fuzz2zero = fuzz2zero_r;
  assign oneeighty2fuzz = oneeighty2fuzz_r;
  assign fuzz2oneeighty = fuzz2oneeighty_r;
  always @(*) begin
    z2f_ns = z2f_r;
    f2z_ns = f2z_r;
    o2f_ns = o2f_r;
    f2o_ns = f2o_r;
    zero2fuzz_ns = zero2fuzz_r;
    fuzz2zero_ns = fuzz2zero_r;
    oneeighty2fuzz_ns = oneeighty2fuzz_r;
    fuzz2oneeighty_ns = fuzz2oneeighty_r;
    scan_right_ns = 1'b0;
    if (reset_scan) begin
      z2f_ns = 1'b0;
      f2z_ns = 1'b0;
      o2f_ns = 1'b0;
      f2o_ns = 1'b0;
    end  
    else if (samp_valid && prev_samp_valid_r)
      case (prev_samp_r)
	FUZZ :
	  if (scanning_right) begin
            if (samp_result == ZERO) begin
	      fuzz2zero_ns = stg3;
	      f2z_ns = 1'b1;
	    end
            if (samp_result == ONEEIGHTY) begin
	      fuzz2oneeighty_ns = stg3;
	      f2o_ns = 1'b1;
	    end
	  end
	ZERO : begin
          if (samp_result == FUZZ || samp_result == ONEEIGHTY) scan_right_ns = !scanning_right;
          if (scanning_right) begin
	    if (samp_result == FUZZ) begin
	      zero2fuzz_ns = stg3 - 6'b1;
	      z2f_ns = 1'b1;
	    end
	    if (samp_result == ONEEIGHTY) begin
	      zero2fuzz_ns = stg3 - 6'b1;
	      z2f_ns = 1'b1;
	      fuzz2oneeighty_ns = stg3;
	      f2o_ns = 1'b1;
	    end
	  end
	end
        ONEEIGHTY :
          if (scanning_right) begin
	    if (samp_result == FUZZ) begin
	      oneeighty2fuzz_ns = stg3 - 6'b1;
	      o2f_ns = 1'b1;
	    end 
            if (samp_result == ZERO)
              if (f2o_r) begin
		oneeighty2fuzz_ns = stg3 - 6'b1;
	        o2f_ns = 1'b1;
              end else begin
	        fuzz2zero_ns = stg3;
	        f2z_ns = 1'b1;
	      end
	  end 
      endcase	 
  end
endmodule