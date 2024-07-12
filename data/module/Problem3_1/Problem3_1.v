module Problem3_1(
    input [7:0] Input,
    input [1:0] Select,
    input Fill,
    input Direction,
    input Rotate,
    output reg [7:0] Output
    );
    always @ (Input, Select, Fill, Direction, Rotate)
    begin
        if (Select == 2'b00)		
            Output = Input;
        else if (Select == 2'b01)	
            begin
                if ( Rotate == 1)
                    begin
                        if (Direction == 1)
                            begin
                                Output = {Input[0], Input[7:1]};
                            end
                        else
                            begin
                                Output = {Input[6:0], Input[7]};
                            end
                    end
                else 
                    begin
                        if (Direction == 1)
                            begin
                                Output = {Fill, Input[7:1]};
                            end
                        else
                            begin
                                Output = {Input[6:0], Fill};
                            end
                    end
            end
        else if (Select == 2'b10)	
            begin
                if ( Rotate == 1)
                    begin
                        if (Direction == 1)
                            begin
                                Output = {Input[1:0], Input[7:2]};
                            end
                        else
                            begin
                                Output = {Input[5:0], Input[7:6]};
                            end
                    end
                else 
                    begin
                        if (Direction == 1)
                            begin
                                Output = {Fill, Fill,  Input[7:2]};
                            end
                        else
                            begin
                                Output = {Input[5:0], Fill, Fill};
                            end
                    end
            end
        else 				
            begin
                if ( Rotate == 1)
                    begin
                        if (Direction == 1)
                            begin
                                Output = {Input[2:0], Input[7:3]};
                            end
                        else
                            begin
                                Output = {Input[4:0], Input[7:5]};
                            end
                    end
                else 
                    begin
                        if (Direction == 1)
                            begin
                                Output = {Fill, Fill, Fill, Input[7:3]};
                            end
                        else
                            begin
                                Output = {Input[4:0], Fill, Fill, Fill};
                            end
                    end
            end
    end
endmodule