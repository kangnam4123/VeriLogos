module sm_graphic_crt 
   (
    input            sync_c_crt_line_end,
    input            hreset_n,
    input            ff_writeable_crt,
    input            crt_gnt,
    input            svga_ack,
    input            mem_clk,    	         
    input            graphic_mode,
    input            data_complete,
    input [7:0]      c_hde,
    input            color_256_mode,
    output           gra_crt_svga_req,
    output           enrd_gra_addr,
    output           gra_cnt_inc,
    output [30:0]    probe
    );
  reg [2:0]    current_state;
  reg [2:0]    next_state;
  reg [3:0]    gra_cnt_qout;
  reg          gra_s1;
  reg          gra_s1x, gra_s2;
  reg          gra_s2x, gra_s3;
  reg [4:0]    char_count;
  wire         gra_cnt_0;
  wire         cnt_inc;
  wire 	       char_done;
  assign       probe = {data_complete, char_done, cnt_inc, ff_writeable_crt,
			crt_gnt, svga_ack, graphic_mode, color_256_mode,
			gra_crt_svga_req, enrd_gra_addr, gra_cnt_inc,
			char_count, c_hde, current_state, gra_cnt_qout};
  parameter    gra_crt_state0  = 3'b000,
               gra_crt_state1x = 3'b001,
	       gra_crt_state2  = 3'b011,
	       gra_crt_state1  = 3'b111,
	       gra_crt_state2x = 3'b110,
	       gra_crt_state3  = 3'b010;
  always @ (posedge mem_clk or negedge hreset_n)
    if (!hreset_n)                char_count <= 5'b0;
    else if (sync_c_crt_line_end) char_count <= 5'b0;
    else if (data_complete)       char_count <= char_count + 1;
  assign       char_done = {char_count, 4'b0} >= (c_hde + 4);
  always @ (posedge mem_clk or negedge hreset_n) begin
    if (~hreset_n)                current_state <= gra_crt_state0;
    else if (sync_c_crt_line_end) current_state <= gra_crt_state0;
    else                          current_state <= next_state;
  end
  always @* begin
    gra_s1    = 1'b0;
    gra_s1x   = 1'b0;
    gra_s2    = 1'b0;
    gra_s2x   = 1'b0;
    gra_s3    = 1'b0;
    case (current_state) 
      gra_crt_state0: begin
        if (crt_gnt && ff_writeable_crt & graphic_mode && ~char_done) 
	  next_state = gra_crt_state1x;
	else
	  next_state = gra_crt_state0;
      end
      gra_crt_state1x: begin
	gra_s1x = 1'b1;
	if (svga_ack) 
	  next_state = gra_crt_state2;
	else
	  next_state = gra_crt_state1x;
      end
      gra_crt_state2: begin
	gra_s2 = 1'b1;
	if (~gra_cnt_0 ) 
	  next_state = gra_crt_state1;
	else if (gra_cnt_0 )
	  next_state = gra_crt_state2x;
	else
	  next_state = gra_crt_state2;
      end
      gra_crt_state1: begin
        gra_s1 = 1'b1;
        if (svga_ack)
          next_state = gra_crt_state2;
	else
	  next_state = gra_crt_state1;
      end
      gra_crt_state2x: begin 
	gra_s2x = 1'b1;
	next_state = gra_crt_state3;
      end
      gra_crt_state3: begin
	gra_s3 = 1'b1;
	if (data_complete)
	  next_state = gra_crt_state0;
	else
	  next_state = gra_crt_state3;
      end
    endcase
  end  			
  assign enrd_gra_addr = (gra_s2 );
  assign gra_crt_svga_req = gra_s1x | ((gra_s1 | gra_s2) & ~gra_cnt_0);
  assign gra_cnt_inc = (svga_ack & (gra_s2 | gra_s1)) | gra_s2x;
  assign cnt_inc = svga_ack & (gra_s1x | gra_s2 | gra_s1);
  assign gra_cnt_0 = (~gra_cnt_qout[3]  & ~gra_cnt_qout[2] & ~gra_cnt_qout[1] & ~gra_cnt_qout[0] ) ;
  always @ (posedge mem_clk or negedge hreset_n) begin
    if (~hreset_n)                gra_cnt_qout <= 4'b0;
    else if (sync_c_crt_line_end) gra_cnt_qout <= 4'b0;
    else if (cnt_inc)             gra_cnt_qout <= gra_cnt_qout + 1;
  end
endmodule