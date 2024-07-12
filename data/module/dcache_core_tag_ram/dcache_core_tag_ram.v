module dcache_core_tag_ram
(
     input           clk0_i
    ,input           rst0_i
    ,input  [  7:0]  addr0_i
    ,input           clk1_i
    ,input           rst1_i
    ,input  [  7:0]  addr1_i
    ,input  [ 20:0]  data1_i
    ,input           wr1_i
    ,output [ 20:0]  data0_o
);
reg [20:0]   ram [255:0] ;
reg [20:0] ram_read0_q;
always @ (posedge clk1_i)
begin
    if (wr1_i)
        ram[addr1_i] = data1_i;
    ram_read0_q = ram[addr0_i];
end
assign data0_o = ram_read0_q;
endmodule