module arbiter_7 #(
    parameter nmasters = 2
    )(
    input                           clk,
    input                           rst,
    input       [32*nmasters-1:0]   master_address,     
    input       [32*nmasters-1:0]   master_data_i,      
    input       [4*nmasters-1:0]    master_wr,          
    input       [nmasters-1 : 0]    master_enable,      
    output      [31:0]              master_data_o,      
    output      [nmasters-1 : 0]    master_ready,       
    output      [nmasters-1 : 0]    master_error,       
    input       [31:0]              slave_data_i,       
    input                           slave_ready,        
    input                           slave_error,        
    output      [31:0]              slave_address,      
    output      [31:0]              slave_data_o,       
    output      [3:0]               slave_wr,           
    output                          slave_enable        
    );
    localparam integer clog_nm = (nmasters <= 1 << 1)  ? 1  :
                                 (nmasters <= 1 << 2)  ? 2  :
                                 (nmasters <= 1 << 3)  ? 3  :
                                 (nmasters <= 1 << 4)  ? 4  :
                                 (nmasters <= 1 << 5)  ? 5  :
                                 (nmasters <= 1 << 6)  ? 6  :
                                 (nmasters <= 1 << 7)  ? 7  :
                                 (nmasters <= 1 << 8)  ? 8  :
                                 (nmasters <= 1 << 9)  ? 9  :
                                 (nmasters <= 1 << 10) ? 10 :
                                 (nmasters <= 1 << 11) ? 11 :
                                 (nmasters <= 1 << 12) ? 12 :
                                 (nmasters <= 1 << 13) ? 13 :
                                 (nmasters <= 1 << 14) ? 14 :
                                 (nmasters <= 1 << 15) ? 15 :
                                 (nmasters <= 1 << 16) ? 16 :
                                 (nmasters <= 1 << 17) ? 17 :
                                 (nmasters <= 1 << 18) ? 18 :
                                 (nmasters <= 1 << 19) ? 19 : 20;
    localparam master_sel_bits = nmasters > 1 ? clog_nm : 1;
    wire [master_sel_bits-1:0]  master_sel;         
    wire [master_sel_bits-1:0]  master_sel2;        
    reg  [nmasters-1:0]         grant;
    reg  [nmasters-1:0]         selected;
    assign master_sel    = fl1(master_enable, nmasters);
    assign master_sel2   = fl1(grant, nmasters);
    assign slave_address = master_address[master_sel2*32+:32];
    assign slave_data_o  = master_data_i[master_sel2*32+:32];
    assign slave_wr      = master_wr[master_sel2*4+:4];
    assign slave_enable  = master_enable[master_sel2];
    assign master_data_o = slave_data_i;
    assign master_ready  = grant & {nmasters{slave_ready}};
    assign master_error  = grant & {nmasters{slave_error}};
    function integer fl1;
    input integer in;
    input integer width;
    integer i;
    begin
        fl1 = 0;
        for (i = 0; i < width; i=i+1) begin
            if (in[i])
                fl1 = i;
        end
    end
    endfunction
    always @(posedge clk) begin
        if (rst) begin
            selected <= 0;
        end
        else begin
            selected <= grant & master_enable;
        end
    end
    always @(*) begin
        if (selected == 0) begin
            grant <= (1'b1 << master_sel);
        end
        else begin
            grant <= selected;
        end
    end
endmodule