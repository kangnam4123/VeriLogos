module RAM_IS61WV6416BLL (
    input       [0:0] clk,         
    input       [0:0] n_reset,     
    input      [16:0] w_address,   
    input       [7:0] w_data,      
    input       [0:0] w_request,   
    output reg  [0:0] w_started,   
    output reg  [0:0] w_done,      
    input      [16:0] r_address,   
    output reg  [7:0] r_data,      
    input       [0:0] r_request,   
    output reg  [0:0] r_started,   
    output reg  [0:0] r_done,      
    output reg [15:0] hw_address,  
    output reg  [0:0] hw_n_cs,     
    output reg  [0:0] hw_n_we,     
    output reg  [0:0] hw_n_oe,     
    output reg  [0:0] hw_n_ub,     
    output reg  [0:0] hw_n_lb,     
    input      [15:0] hw_data_in,  
    output reg [15:0] hw_data_out, 
    output reg  [0:0] hw_data_oe   
);
    reg [0:0] counter = 0;
    reg [0:0] r_request_int = 0;
    reg [0:0] w_request_int = 0;
    always @ (posedge clk) begin
        if (!n_reset) begin
            r_done  <= 0;
            w_done  <= 0;
            hw_n_we <= 1;
            hw_n_oe <= 1;
            hw_n_cs <= 1;
            counter <= 0;
        end else begin
            if (counter) begin
                counter <= counter-1;
            end else begin
                if (r_done || w_done) begin
                    r_done        <= 0;
                    w_done        <= 0;
                    r_request_int <= 0;
                    w_request_int <= 0;
                    hw_n_cs       <= 1;
                    hw_data_oe    <= 1;
                    hw_data_oe    <= 1;
                end else if (r_request && hw_n_cs) begin
                    r_request_int <= 1;
                    r_started     <= 1;
                    hw_n_we       <= 1; 
                    hw_n_oe       <= 0;
                    hw_n_cs       <= 0;
                    hw_n_ub       <=  r_address[16];
                    hw_n_lb       <= !r_address[16];
                    hw_address    <=  r_address[15:0];
                    counter       <= 1;
                end else if (r_request_int && !hw_n_cs) begin
                    r_started     <= 0;
                    hw_n_oe       <= 1;
                    hw_n_cs       <= 1;
                    r_data        <= hw_n_ub ? hw_data_in[15:8] : hw_data_in[7:0];
                    r_done        <= 1;
                end else if (w_request && hw_n_cs && !hw_data_oe) begin
                    hw_data_oe    <= 1;
                end else if (w_request && hw_n_cs && hw_data_oe) begin
                    w_request_int <= 1;
                    w_started     <= 1;
                    hw_n_we       <= 0; 
                    hw_n_oe       <= 1;
                    hw_n_cs       <= 0;
                    hw_data_oe    <= 0;
                    hw_n_ub       <=  r_address[16];
                    hw_n_lb       <= !r_address[16];
                    hw_address    <=  r_address[15:0];
                    hw_data_out   <= {w_data, w_data};
                    counter       <= 1;
                end else if (w_request_int && !hw_n_cs) begin
                    w_started     <= 0;
                    hw_n_oe       <= 1;
                    hw_n_cs       <= 1;
                    w_done        <= 1;
                end else begin
                end
            end
        end
    end
endmodule