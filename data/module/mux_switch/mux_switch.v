module mux_switch #(
    parameter                   nslaves     = 2,
    parameter [nslaves*32-1:0]  MATCH_ADDR  = 0,
    parameter [nslaves*32-1:0]  MATCH_MASK  = 0
    )(
    input                           clk,
    input   [31:0]              master_address,     
    input   [31:0]              master_data_i,      
    input   [3:0]               master_wr,          
    input                       master_enable,      
    output  [31:0]              master_data_o,      
    output                      master_ready,       
    output  reg                 master_error,       
    input   [nslaves*32-1:0]    slave_data_i,       
    input   [nslaves-1:0]       slave_ready,        
    output  [31:0]              slave_address,      
    output  [31:0]              slave_data_o,       
    output  [3:0]               slave_wr,           
    output  [nslaves-1:0]       slave_enable        
    );
    localparam integer clog_ns = (nslaves <= 1 << 1)  ? 1  :
                                 (nslaves <= 1 << 2)  ? 2  :
                                 (nslaves <= 1 << 3)  ? 3  :
                                 (nslaves <= 1 << 4)  ? 4  :
                                 (nslaves <= 1 << 5)  ? 5  :
                                 (nslaves <= 1 << 6)  ? 6  :
                                 (nslaves <= 1 << 7)  ? 7  :
                                 (nslaves <= 1 << 8)  ? 8  :
                                 (nslaves <= 1 << 9)  ? 9  :
                                 (nslaves <= 1 << 10) ? 10 :
                                 (nslaves <= 1 << 11) ? 11 :
                                 (nslaves <= 1 << 12) ? 12 :
                                 (nslaves <= 1 << 13) ? 13 :
                                 (nslaves <= 1 << 14) ? 14 :
                                 (nslaves <= 1 << 15) ? 15 :
                                 (nslaves <= 1 << 16) ? 16 :
                                 (nslaves <= 1 << 17) ? 17 :
                                 (nslaves <= 1 << 18) ? 18 :
                                 (nslaves <= 1 << 19) ? 19 : 20;
    localparam slave_sel_bits = nslaves > 1 ? clog_ns : 1;
    wire [slave_sel_bits-1:0] slave_sel;
    wire [nslaves-1:0]        match;
    reg  [8:0]                watchdog_counter;
    assign slave_sel        = ff1(match, nslaves);
    assign slave_address    = master_address;
    assign slave_data_o     = master_data_i;
    assign slave_wr         = master_wr;
    assign slave_enable     = match & {nslaves{master_enable}};
    assign master_data_o    = slave_data_i[slave_sel*32+:32];
    assign master_ready     = slave_ready[slave_sel];
    generate
        genvar i;
        for (i = 0; i < nslaves; i = i + 1)
        begin:addr_match
            assign match[i] = (master_address & MATCH_MASK[i*32+:32]) == MATCH_ADDR[i*32+:32];
        end
    endgenerate
    always @(posedge clk) begin
        master_error <= (watchdog_counter[8] & (|match)) | (master_enable & ~(|match));    
        if (master_enable) begin
            watchdog_counter <= watchdog_counter[7:0] + 8'b1;
        end
        else begin
            watchdog_counter <= 9'b0;
        end
    end
    function integer ff1;
    input integer in;
    input integer width;
    integer i;
    begin
        ff1 = 0;
        for (i = width-1; i >= 0; i=i-1) begin
            if (in[i])
                ff1 = i;
        end
    end
    endfunction
endmodule