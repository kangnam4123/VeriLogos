module depunc (
        clk         , 
        nrst        , 
        start       , 
        dav         ,   
        din         , 
        vout        , 
        dout_a      , 
        dout_b      , 
        buf_rd      , 
        rate            
        ) ;
parameter           SW = 4 ;        
input               clk ;
input               nrst ;
input               start ;
input               dav ;
input   [SW*2 -1:0] din ;
input   [1:0]       rate ;
output              vout ;
output  [SW -1:0]   dout_a ;
output  [SW -1:0]   dout_b ;
output              buf_rd ;
reg     [1:0]               cnt ;
wire                        rd ;
wire                        rd_r12 ;
wire                        rd_r34 ;
wire                        rd_r23 ;
wire                        r23_ext ;
reg                         r23_ext_s0 ;
wire                        r34_ext ;
reg     [SW -1:0]           app_i_r34 ; 
reg     [SW -1:0]           app_q_r34 ;
reg     [SW -1:0]           app_i_r23 ; 
reg     [SW -1:0]           app_q_r23 ;
wire    [SW -1:0]           app_i_r12 ; 
wire    [SW -1:0]           app_q_r12 ;
wire    [SW -1:0]           app_i_mux ; 
wire    [SW -1:0]           app_q_mux ;
wire                        app_valid ;
wire    [SW*2 -1:0]         iq_data_buf ;
reg     [SW*2 -1:0]         iq_data_buf_lat ;
assign buf_rd = rd ;
assign dout_a = app_i_mux ;
assign dout_b = app_q_mux ;
assign vout = app_valid ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (start)
    cnt <= 0 ;
  else if (dav)
  begin
    if (rate == 1)
      cnt <= cnt + 1 ;  
    else if (rate ==2)
      cnt <= (cnt == 2 ? 0 : cnt +1) ;    
  end
assign rd_r12 = dav ;
assign r23_ext = cnt == 3 ;
always @ (posedge clk)
  r23_ext_s0 <= r23_ext ;
assign r23_ext_p = ~r23_ext_s0 & r23_ext ;
assign rd_r23 = dav & ~r23_ext ; 
assign rd_r34 = dav & (cnt != 2) ; 
assign r34_ext = dav & (cnt == 2) ;
assign rd = rate == 0 ? rd_r12 : rate == 1 ? rd_r23 : rd_r34 ;
assign iq_data_buf = din ;
always @ (posedge clk)
  if (rd)
    iq_data_buf_lat <= iq_data_buf ;
always @*
begin
  app_i_r23 = 0 ;
  app_q_r23 = 0 ;
  case (cnt)
  0: begin
    app_i_r23 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r23 = iq_data_buf [SW -1: 0] ;
  end
  1: begin
    app_i_r23 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r23 = 0 ;
  end
  2: begin
    app_i_r23 = iq_data_buf_lat [SW -1: 0] ;
    app_q_r23 = iq_data_buf [SW*2 -1 : SW] ;
  end
  3: begin
    app_i_r23 = iq_data_buf_lat [SW -1: 0] ;
    app_q_r23 = 0 ;
  end  
  endcase
end
always @*
begin
  app_i_r34 = 0 ;
  app_q_r34 = 0 ;
  case (cnt)
  0: begin
    app_i_r34 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r34 = iq_data_buf [SW -1: 0] ;
  end
  1: begin
    app_i_r34 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r34 = 0 ;
  end
  2: begin
    app_i_r34 = 0 ;
    app_q_r34 = iq_data_buf_lat [SW -1: 0] ;
  end
  default: begin
    app_i_r34 = 0 ;
    app_q_r34 = 0 ;
  end  
  endcase
end
assign app_i_r12 = iq_data_buf [SW*2 -1 : SW] ;
assign app_q_r12 = iq_data_buf [SW -1: 0] ;
assign app_i_mux = rate == 0 ? app_i_r12 : rate == 1 ? app_i_r23 : app_i_r34 ;
assign app_q_mux = rate == 0 ? app_q_r12 : rate == 1 ? app_q_r23 : app_q_r34 ;
assign app_valid = rate == 0 ? rd_r12 : rate == 1 ? (rd_r23 | r23_ext_p) : (rd_r34 | r34_ext) ;
endmodule