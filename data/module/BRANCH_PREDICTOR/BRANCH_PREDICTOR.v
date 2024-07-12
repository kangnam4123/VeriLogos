module BRANCH_PREDICTOR #(
        parameter   ADDRESS_WIDTH       = 32                                ,
        parameter HIGH                  = 1'b1                              ,
        parameter LOW                   = 1'b0
    ) (
        input                               CLK                             ,
        input   [ADDRESS_WIDTH - 1  : 0]    PC                              ,
        input   [ADDRESS_WIDTH - 1  : 0]    PC_EXECUTION                    ,
        input   [ADDRESS_WIDTH - 1  : 0]    PC_PREDICT_LEARN                ,
        input                               PC_PREDICT_LEARN_SELECT         ,
        output  [ADDRESS_WIDTH - 1  : 0]    PC_PREDICTED                    ,
        output                              PC_PREDICTOR_STATUS                   
    );
    reg     [ADDRESS_WIDTH - 1  : 0]    pc_predicted_reg                    ;
    reg                                 pc_predictor_status_reg             ;
    initial
    begin
        pc_predicted_reg            = 32'b0         ;
        pc_predictor_status_reg     = LOW           ;
    end
    always@(*)
    begin
    end
    always@(CLK)
    begin
    end
    assign PC_PREDICTED             = pc_predicted_reg          ;
    assign PC_PREDICTOR_STATUS      = pc_predictor_status_reg   ;      
endmodule