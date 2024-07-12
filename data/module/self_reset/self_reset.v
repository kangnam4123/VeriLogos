module self_reset (input wire mgmt_reset, input wire clk, output wire reset, output wire init_reset);
    localparam RESET_COUNTER_VALUE = 3'd2;
    localparam INITIAL_WAIT_VALUE = 9'd340;
    reg [9:0]counter;
    reg local_reset;
    reg usr_mode_init_wait;
    initial 
    begin
        local_reset = 1'b1;
        counter = 0;
        usr_mode_init_wait = 0;
    end
    always @(posedge clk)
    begin
        if (mgmt_reset)
        begin
            counter <= 0;
        end
        else
        begin
            if (!usr_mode_init_wait)
            begin
                if (counter == INITIAL_WAIT_VALUE)
                begin
                    local_reset <= 0;
                    usr_mode_init_wait <= 1'b1;
                    counter <= 0;
                end
                else 
                begin
                counter <= counter + 1'b1;
                end
            end
            else
            begin
                if (counter == RESET_COUNTER_VALUE)
                    local_reset <= 0;
                else 
                    counter <= counter + 1'b1;
            end
        end
    end
    assign reset = mgmt_reset | local_reset;
    assign init_reset = local_reset;
endmodule