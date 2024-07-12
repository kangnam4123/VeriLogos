module ALU_26
#(
    parameter DATA_WIDTH = 32
)(
    input [DATA_WIDTH - 1:0] channel_A, channel_B,
    output reg [DATA_WIDTH - 1:0] operation_result,
    input [3:0] control,
    input previous_specreg_carry,
    output reg Negative_ALU_flag, Zero_ALU_flag, 
    output reg Carry_ALU_flag, oVerflow_ALU_flag
);
    wire [DATA_WIDTH - 1:0] channel_B_negative;
    wire most_significant_bit, local_overflow, channel_A_msb, channel_B_msb;
    reg use_negative_B;
    assign most_significant_bit = operation_result[DATA_WIDTH - 1];
    assign channel_A_msb = channel_A[DATA_WIDTH -1];
    assign channel_B_negative = - channel_B;
    assign channel_B_msb = use_negative_B ? channel_B_negative[DATA_WIDTH - 1] :
                                            channel_B[DATA_WIDTH -1];
    assign local_overflow =   most_significant_bit ?    !(channel_A_msb || channel_B_msb) :
                                                        channel_A_msb && channel_B_msb;
    always @ ( * ) begin
        Negative_ALU_flag = 0;
        Carry_ALU_flag = 0;
        oVerflow_ALU_flag = 0;
        use_negative_B = 0;
        operation_result = 0;
        case (control)
            1:  
            begin 
                {Carry_ALU_flag, operation_result} =  channel_A + channel_B + previous_specreg_carry;
                oVerflow_ALU_flag = local_overflow;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            2:  
            begin 
                {Carry_ALU_flag, operation_result} =  channel_A + channel_B;
                oVerflow_ALU_flag = local_overflow;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            3:  
            begin 
                operation_result = channel_A & channel_B;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            4:  
            begin 
                operation_result = channel_A & (~channel_B);
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            5:  
            begin 
                use_negative_B = 1;
                {Carry_ALU_flag, operation_result} =  channel_A + channel_B_negative;
                oVerflow_ALU_flag = local_overflow;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            6:  
            begin
                {Carry_ALU_flag, operation_result} =  - channel_A;
                oVerflow_ALU_flag = local_overflow;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            7:  
            begin
                operation_result = channel_A | channel_B;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            8:  
            begin
                {Carry_ALU_flag, operation_result} =  channel_A - channel_B - ~previous_specreg_carry;
                oVerflow_ALU_flag = local_overflow;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            9:  
            begin
                operation_result = channel_A * channel_B;
                Negative_ALU_flag  =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            10: 
            begin 
                oVerflow_ALU_flag = (channel_B == 0);
                operation_result = (oVerflow_ALU_flag) ? 0 : channel_A / channel_B;
                Zero_ALU_flag = (operation_result == 0);
            end
            11: 
            begin
                oVerflow_ALU_flag  = (channel_B == 0);
                operation_result = (oVerflow_ALU_flag) ? 0 : channel_A % channel_B;
                Zero_ALU_flag = (operation_result == 0);
            end
            12: 
            begin
                operation_result = channel_B;
                Zero_ALU_flag = (operation_result == 0);
            end
            13: 
            begin
                operation_result = channel_A ^ channel_B;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            14: 
            begin
                operation_result = channel_A && channel_B;
                Negative_ALU_flag =  most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
            15: 
            begin
                Negative_ALU_flag = channel_A[3];
                Zero_ALU_flag = channel_A[2];
                Carry_ALU_flag = channel_A[1];
                oVerflow_ALU_flag = channel_A[0];
            end
            default:    
            begin 
                operation_result = channel_A;
                Negative_ALU_flag = most_significant_bit;
                Zero_ALU_flag = (operation_result == 0);
            end
        endcase
    end
endmodule