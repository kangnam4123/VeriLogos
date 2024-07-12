module zap_sync_fifo #(
        parameter WIDTH            = 32, 
        parameter DEPTH            = 32, 
        parameter FWFT             = 1,
        parameter PROVIDE_NXT_DATA = 0
)
(
        input   wire             i_clk,
        input   wire             i_reset,
        input   wire             i_ack,
        input   wire             i_wr_en,
        input   wire [WIDTH-1:0] i_data,
        output  reg [WIDTH-1:0]  o_data,
        output  reg [WIDTH-1:0]  o_data_nxt,
        output wire              o_empty,
        output wire              o_full,
        output wire              o_empty_n,
        output wire              o_full_n,
        output wire              o_full_n_nxt
);
parameter PTR_WDT = $clog2(DEPTH) + 32'd1;
parameter [PTR_WDT-1:0] DEFAULT = {PTR_WDT{1'd0}}; 
reg [PTR_WDT-1:0] rptr_ff;
reg [PTR_WDT-1:0] rptr_nxt;
reg [PTR_WDT-1:0] wptr_ff;
reg               empty, nempty;
reg               full, nfull;
reg [PTR_WDT-1:0] wptr_nxt;
reg [WIDTH-1:0]   mem [DEPTH-1:0]; 
wire [WIDTH-1:0]  dt;
reg [WIDTH-1:0]   dt1;
reg               sel_ff;
reg [WIDTH-1:0]   bram_ff;         
reg [WIDTH-1:0]   dt_ff;
assign o_empty = empty;
assign o_full  = full;
assign o_empty_n = nempty;
assign o_full_n = nfull;
assign o_full_n_nxt = i_reset ? 1 :
                      !( ( wptr_nxt[PTR_WDT-2:0] == rptr_nxt[PTR_WDT-2:0] ) &&
                       ( wptr_nxt != rptr_nxt ) );
always @ (posedge i_clk)
        if ( i_wr_en && !o_full )
                mem[wptr_ff[PTR_WDT-2:0]] <= i_data;
generate
begin:gb1
        if ( FWFT == 1 )
        begin:f1
                always @ (posedge i_clk) 
                begin
                         dt_ff <= i_data;
                        sel_ff <= ( i_wr_en && (wptr_ff == rptr_nxt) );
                       bram_ff <= mem[rptr_nxt[PTR_WDT-2:0]];
                end
                always @*
                begin
                        o_data = sel_ff ? dt_ff : bram_ff;
                        o_data_nxt = 0; 
                end
        end
        else
        begin:f0
                always @ (posedge i_clk)
                begin
                        if ( i_ack && nempty ) 
                        begin
                                o_data <= mem [ rptr_ff[PTR_WDT-2:0] ];
                        end
                end
                if ( PROVIDE_NXT_DATA ) 
                begin: f11
                        always @ (*)
                        begin 
                                if ( i_ack && nempty ) 
                                        o_data_nxt = mem [ rptr_ff[PTR_WDT-2:0] ];
                                else
                                        o_data_nxt = o_data;
                        end
                end
                else
                begin: f22
                        always @* o_data_nxt = 0;
                end
        end
end
endgenerate
always @ (posedge i_clk)
begin
        dt1     <= i_reset ? 0 : i_data;
        rptr_ff <= i_reset ? 0 : rptr_nxt;
        wptr_ff <= i_reset ? 0 : wptr_nxt;
        empty   <= i_reset ? 1 : ( wptr_nxt == rptr_nxt );
        nempty  <= i_reset ? 0 : ( wptr_nxt != rptr_nxt );
        nfull   <= o_full_n_nxt;
        full    <= !o_full_n_nxt;
end
always @*
begin
        wptr_nxt = wptr_ff + (i_wr_en && !o_full);
        rptr_nxt = rptr_ff + (i_ack && !o_empty);
end
endmodule