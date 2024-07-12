module hardcopyiv_bias_generator (
    din,
    mainclk,
    updateclk,
    capture,
    update,
    dout 
    );
input  din;
input  mainclk;
input  updateclk;
input  capture;
input  update;
output dout;
parameter TOTAL_REG = 100;
reg dout_tmp;
reg generator_reg [TOTAL_REG - 1:0];
reg update_reg [TOTAL_REG - 1:0];
integer i;
initial
begin
    dout_tmp <= 'b0;
    for (i = 0; i < TOTAL_REG; i = i + 1)
    begin
        generator_reg [i] <= 'b0;
        update_reg [i] <= 'b0;
    end
end
always @(posedge mainclk)
begin
    if ((capture == 'b0) && (update == 'b1)) 
    begin
        for (i = 0; i < TOTAL_REG; i = i + 1)
        begin
            generator_reg[i] <= update_reg[i];
        end
    end
end
always @(posedge updateclk)
begin
    dout_tmp <= update_reg[TOTAL_REG - 1];
    if ((capture == 'b0) && (update == 'b0)) 
    begin
        for (i = (TOTAL_REG - 1); i > 0; i = i - 1)
        begin
            update_reg[i] <= update_reg[i - 1];
        end
        update_reg[0] <= din; 
    end
    else if ((capture == 'b1) && (update == 'b0)) 
    begin
        for (i = 0; i < TOTAL_REG; i = i + 1)
        begin
            update_reg[i] <= generator_reg[i];
        end
    end
end
and (dout, dout_tmp, 1'b1);
endmodule