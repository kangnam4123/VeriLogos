module Key_Matrix_Driver_v1_0 (
	output  Changed,
	output [3:0] Column_Output,
	output reg [31:0] Switch_State,
	input   Clock,
	input  [7:0] Row_Input
);
	parameter Generate_Interrupt = 0;
    generate
    if (Generate_Interrupt == 1)
    begin
        reg [1:0] cnt;  
        reg changed_reg;
        assign Column_Output = ~(4'b1000 >> cnt); 
        assign Changed = (cnt == 2'b00) && changed_reg;
        always @ (posedge Clock)
        begin
            cnt <= cnt + 1;
            Switch_State <= Switch_State;  
            case(cnt)
                2'b00:
                begin
                    Switch_State[7:0] <= Row_Input;
                    if(Switch_State[7:0] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= 0;
                    end
                end
                2'b01:
                begin
                    Switch_State[15:8] <= Row_Input;
                    if(Switch_State[15:8] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= changed_reg;
                    end
                end
                2'b10:
                begin
                    Switch_State[23:16] <= Row_Input;
                    if(Switch_State[23:16] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= changed_reg;
                    end
                end
                2'b11:
                begin
                    Switch_State[31:24] <= Row_Input;
                    if(Switch_State[31:24] != Row_Input)
                    begin
                        changed_reg <= 1;
                    end
                    else
                    begin
                        changed_reg <= changed_reg;
                    end
                end
        	endcase
        end
    end
    else 
    begin
        reg [1:0] cnt;  
        assign Column_Output = ~(4'b1000 >> cnt); 
        always @ (posedge Clock)
        begin
            cnt <= cnt + 1;
            Switch_State <= Switch_State;  
            case(cnt)
                2'b00:
                begin
                    Switch_State[7:0] <= Row_Input;
                end
                2'b01:
                begin
                    Switch_State[15:8] <= Row_Input;
                end
                2'b10:
                begin
                    Switch_State[23:16] <= Row_Input;
                end
                2'b11:
                begin
                    Switch_State[31:24] <= Row_Input;
                end
        	endcase
        end
    end
    endgenerate
endmodule