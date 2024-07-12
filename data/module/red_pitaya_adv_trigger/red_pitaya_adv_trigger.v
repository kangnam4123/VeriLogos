module red_pitaya_adv_trigger #(
    parameter COUNTERSZ = 64
)
(
    input           dac_clk_i,
    input           reset_i,  
    input           trig_i,
    output          trig_o,
    input           rearm_i,
    input           invert_i,
    input [COUNTERSZ-1:0]  hysteresis_i 
    );
reg [COUNTERSZ-1:0] counter;
reg triggered;
reg armed;
always @(posedge dac_clk_i) begin
    if (reset_i == 1'b1) begin
        triggered <= 1'b0;
        armed <= 1'b1;
        counter <= hysteresis_i;
        end
    else if (armed&(!triggered)) begin
        triggered <= trig_i;
        counter <= hysteresis_i;
        end
    else if (triggered) begin
        if ( counter != {COUNTERSZ{1'b0}} ) 
            counter <= counter - {{COUNTERSZ-1{1'b0}},1'b1};
        else begin               
            if (rearm_i) begin    
                triggered <= trig_i; 
                armed <= 1'b1;       
                counter <= hysteresis_i; 
                end
            else begin  
                triggered <= 1'b0; 
                armed <= 1'b0;     
                end
        end
    end
end
assign trig_o = reset_i ? trig_i : (invert_i ^ triggered);
endmodule