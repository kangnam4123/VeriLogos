module    ic_req_upload(
                         clk,
                         rst,
                         ic_flits_req,
                         v_ic_flits_req,
                         req_fifo_rdy,
                         ic_flit_out,
                         v_ic_flit_out,
								 ic_ctrl_out,
                         ic_req_upload_state
                         );
input                         clk;
input                         rst;
input       [47:0]            ic_flits_req;
input                         v_ic_flits_req;
input                         req_fifo_rdy;
output      [15:0]             ic_flit_out;
output                         v_ic_flit_out;
output      [1:0]              ic_ctrl_out;
output                         ic_req_upload_state;
parameter    ic_req_upload_idle=1'b0;
parameter    ic_req_upload_busy=1'b1;
reg          ic_req_state;
reg  [47:0]  ic_req_flits;
reg  [1:0]   sel_cnt;
reg          v_ic_flit_out;
reg          fsm_rst;
reg          next;
reg          en_flits_in;
reg          inc_cnt;
assign ic_req_upload_state=ic_req_state;
always@(*)
begin
  v_ic_flit_out=1'b0;
  inc_cnt=1'b0;
  fsm_rst=1'b0;
  en_flits_in=1'b0;
  next=1'b0;
  case(ic_req_state)
    ic_req_upload_idle:
       begin
         if(v_ic_flits_req)
           begin
             en_flits_in=1'b1;
             next=1'b1;
           end
       end
    ic_req_upload_busy:
       begin
         if(req_fifo_rdy)
           begin
             if(sel_cnt==2'b10)
               fsm_rst=1'b1;
             inc_cnt=1'b1;
             v_ic_flit_out=1'b1;
           end
       end
    endcase
end
always@(posedge clk)
begin
  if(rst||fsm_rst)
    ic_req_state<=1'b0;
else if(next)
    ic_req_state<=1'b1;
end
always@(posedge clk)
begin
  if(rst||fsm_rst)
    ic_req_flits<=48'h0000;
  else if(en_flits_in)
    ic_req_flits<=ic_flits_req;
end
reg  [15:0]  ic_flit_out;
reg  [1:0]   ic_ctrl_out;
always@(*)
begin
  case(sel_cnt)
    2'b00:
	   begin
	     ic_flit_out=ic_req_flits[47:32];
	     ic_ctrl_out=2'b01;
	   end
    2'b01:
	   begin
	     ic_flit_out=ic_req_flits[31:16];
		  ic_ctrl_out=2'b10;
		end
    2'b10:
	   begin
	     ic_flit_out=ic_req_flits[15:0];
		  ic_ctrl_out=2'b11;
		end
    default:
	   begin
	     ic_flit_out=ic_req_flits[47:32];
		  ic_ctrl_out=2'b00;
	   end
  endcase
end
always@(posedge clk)
begin
  if(rst||fsm_rst)
    sel_cnt<=2'b00;
  else if(inc_cnt)
    sel_cnt<=sel_cnt+2'b01;
end
endmodule