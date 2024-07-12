module basic_coalescer
( 
    clk, reset, i_page_addr, i_valid, o_stall, o_new_page, o_req_addr, 
    o_req_valid, i_stall 
);
parameter PAGE_ADDR_WIDTH=32;
parameter TIMEOUT=8;  
input clk;
input reset;
input [PAGE_ADDR_WIDTH-1:0] i_page_addr;
input i_valid;
output o_stall;
output o_new_page;
output [PAGE_ADDR_WIDTH-1:0] o_req_addr;
output o_req_valid;
input i_stall;
reg [PAGE_ADDR_WIDTH-1:0] page_addr;
reg valid;
wire ready;
wire waiting;
wire match;
wire timeout;
reg [$clog2(TIMEOUT):0] timeout_counter;
assign timeout = timeout_counter[$clog2(TIMEOUT)];
assign match = (i_page_addr == page_addr);
assign ready = !valid || !(i_stall || waiting);
assign waiting = !timeout && (!i_valid || match);
always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        page_addr <= {PAGE_ADDR_WIDTH{1'b0}};
        valid <= 1'b0;
        timeout_counter <= '0;
    end
    else
    begin
        page_addr <= ready ? i_page_addr : page_addr;
        valid <= ready ? i_valid : valid;
        if( i_valid )
            timeout_counter <= 'd1;
        else if( valid && !timeout )
            timeout_counter <= timeout_counter + 'd1;
    end
end
assign o_stall = i_valid && !match && !ready;
assign o_new_page = ready;
assign o_req_addr = page_addr;
assign o_req_valid = valid && !waiting;
endmodule