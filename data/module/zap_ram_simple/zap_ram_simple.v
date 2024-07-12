module zap_ram_simple #(
        parameter WIDTH = 32,
        parameter DEPTH = 32
)
(
        input wire                          i_clk,
        input wire                          i_wr_en,
        input wire                          i_rd_en,
        input wire [WIDTH-1:0]              i_wr_data,
        input wire[$clog2(DEPTH)-1:0]       i_wr_addr,
        input wire [$clog2(DEPTH)-1:0]      i_rd_addr,
        output reg [WIDTH-1:0]              o_rd_data
);
reg [WIDTH-1:0] mem [DEPTH-1:0];
reg [WIDTH-1:0] mem_data;
reg [WIDTH-1:0] buffer;
reg             sel;
initial
begin: blk1
        integer i;
        for(i=0;i<DEPTH;i=i+1)
                mem[i] = {WIDTH{1'd0}};
end
always @ ( posedge i_clk )
begin
        if ( i_wr_addr == i_rd_addr && i_wr_en && i_rd_en )
                sel <= 1'd1;
        else
                sel <= 1'd0;                
end
always @ ( posedge i_clk )
begin
        if ( i_wr_addr == i_rd_addr && i_wr_en && i_rd_en )
                buffer <= i_wr_data;
end
always @ (posedge i_clk)
begin
        if ( i_rd_en )
                mem_data <= mem [ i_rd_addr ];
end
always @*
begin
        if ( sel )
                o_rd_data = buffer;
        else
                o_rd_data = mem_data;
end
always @ (posedge i_clk)
begin
        if ( i_wr_en )  
                mem [ i_wr_addr ] <= i_wr_data;
end
endmodule