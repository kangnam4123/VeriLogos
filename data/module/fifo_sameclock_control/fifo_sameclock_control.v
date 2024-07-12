module  fifo_sameclock_control#(
    parameter WIDTH = 9
)(
    input                  clk,
    input                  rst,  
    input                  wr,  
    input                  rd,  
    output                 nempty,    
    output       [WIDTH:0] fill_in,   
    output reg [WIDTH-1:0] mem_wa,
    output reg [WIDTH-1:0] mem_ra,
    output                 mem_re,
    output                 mem_regen,
    output reg             over,
    output reg             under
);
    reg       [WIDTH:0] fill_ram;
    reg                 ramo_full;
    reg                 rreg_full;
    assign mem_re = (|fill_ram) && (!ramo_full || !rreg_full || rd);
    assign mem_regen =   ramo_full && (!rreg_full || rd);
    assign nempty =    rreg_full;
    assign fill_in =   fill_ram;
    always @ (posedge clk) begin
        if     (rst) mem_wa <= 0;
        else if (wr) mem_wa <= mem_wa + 1;
        if      (rst)    mem_ra <= 0;
        else if (mem_re) mem_ra <= mem_ra + 1;
        if      (rst)                fill_ram <= 0;
        else if (wr ^ mem_re)        fill_ram <= mem_re ? (fill_ram - 1) : (fill_ram + 1);
        if      (rst)                ramo_full <= 0;
        else if (mem_re ^ mem_regen) ramo_full <= mem_re;
        if      (rst)                           rreg_full <= 0;
        else if (mem_regen ^ (rd && rreg_full)) rreg_full <= mem_regen;
        if (rst)                     under <= 0;
        else                         under <= rd && ! rreg_full;
        if (rst)                     over <= 0;
        else                         over <= wr && fill_ram[WIDTH] && !fill_ram[WIDTH-1];
    end
endmodule