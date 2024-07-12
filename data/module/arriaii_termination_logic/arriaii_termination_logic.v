module arriaii_termination_logic(
            terminationclock,
            terminationdata,
            terminationselect,
            terminationcontrol 
        );
    parameter lpm_type = "arriaii_termination_logic"; 
    input terminationclock;
    input terminationselect;
    input terminationdata;
    output [15:0] terminationcontrol;
    reg [15:0] shift_reg;
    assign terminationcontrol = shift_reg;
    initial
        shift_reg = 16'b0;
    always @(posedge terminationclock)
        if (terminationselect == 1'b1)
            shift_reg <= {shift_reg[14:0], terminationdata};
endmodule