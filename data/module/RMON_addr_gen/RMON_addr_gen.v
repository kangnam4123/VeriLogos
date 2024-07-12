module RMON_addr_gen(
Clk                 ,                              
Reset               ,                              
Pkt_type_rmon       ,                              
Pkt_length_rmon     ,                              
Apply_rmon          ,
Pkt_err_type_rmon   ,                              
Reg_apply           ,                              
Reg_addr            ,                              
Reg_data            ,                              
Reg_next            ,                              
Reg_drop_apply                                
);
input           Clk                 ;
input           Reset               ;
input   [2:0]   Pkt_type_rmon       ;
input   [15:0]  Pkt_length_rmon     ;
input           Apply_rmon          ;
input   [2:0]   Pkt_err_type_rmon   ;
output          Reg_apply           ;
output  [4:0]   Reg_addr            ;
output  [15:0]  Reg_data            ;
input           Reg_next            ;
output          Reg_drop_apply      ;
parameter       StateIdle       =4'd0;
parameter       StatePktLength  =4'd1;
parameter       StatePktNumber  =4'd2;
parameter       StatePktType    =4'd3;
parameter       StatePktRange   =4'd4;
reg [3:0]       CurrentState ;
reg [3:0]       NextState;
reg [2:0]       PktTypeReg      ;
reg [15:0]      PktLengthReg    ;
reg [2:0]       PktErrTypeReg   ;
reg             Reg_apply       ;
reg [4:0]       Reg_addr            ;
reg [15:0]      Reg_data            ;
reg             Reg_drop_apply  ;
reg             Apply_rmon_dl1;
reg             Apply_rmon_dl2;
reg             Apply_rmon_pulse;
reg [2:0]       Pkt_type_rmon_dl1       ;
reg [15:0]      Pkt_length_rmon_dl1     ;
reg [2:0]       Pkt_err_type_rmon_dl1   ;
always @(posedge Clk or posedge Reset)
    if (Reset)
        begin
        Pkt_type_rmon_dl1       <=0;
        Pkt_length_rmon_dl1     <=0;
        Pkt_err_type_rmon_dl1   <=0;
        end              
    else
        begin
        Pkt_type_rmon_dl1       <=Pkt_type_rmon     ;   
        Pkt_length_rmon_dl1     <=Pkt_length_rmon   ;
        Pkt_err_type_rmon_dl1   <=Pkt_err_type_rmon ;
        end 
always @(posedge Clk or posedge Reset)
    if (Reset)
        begin
        Apply_rmon_dl1  <=0;
        Apply_rmon_dl2  <=0;
        end
    else
        begin
        Apply_rmon_dl1  <=Apply_rmon;
        Apply_rmon_dl2  <=Apply_rmon_dl1;
        end 
always @(Apply_rmon_dl1 or Apply_rmon_dl2)
    if (Apply_rmon_dl1&!Apply_rmon_dl2)
        Apply_rmon_pulse    =1;
    else
        Apply_rmon_pulse    =0;
always @(posedge Clk or posedge Reset)
    if (Reset)
        begin
        PktTypeReg          <=0;
        PktLengthReg        <=0;
        PktErrTypeReg       <=0;    
        end
    else if (Apply_rmon_pulse&&CurrentState==StateIdle)
        begin
        PktTypeReg          <=Pkt_type_rmon_dl1     ;
        PktLengthReg        <=Pkt_length_rmon_dl1   ;
        PktErrTypeReg       <=Pkt_err_type_rmon_dl1 ;    
        end     
always @(posedge Clk or posedge Reset)
    if (Reset)
        CurrentState    <=StateIdle;
    else
        CurrentState    <=NextState;
always @(CurrentState or Apply_rmon_pulse or Reg_next)
    case (CurrentState)
        StateIdle:
            if (Apply_rmon_pulse)
                NextState   =StatePktLength;
            else
                NextState   =StateIdle;
        StatePktLength:
            if (Reg_next)
                NextState   =StatePktNumber;
            else
                NextState   =CurrentState;
        StatePktNumber:
            if (Reg_next)
                NextState   =StatePktType;
            else
                NextState   =CurrentState;
        StatePktType:
            if (Reg_next)
                NextState   =StatePktRange;
            else
                NextState   =CurrentState;
        StatePktRange:
            if (Reg_next)
                NextState   =StateIdle;
            else
                NextState   =CurrentState;
        default:
                NextState   =StateIdle;
    endcase 
always @ (CurrentState)
    if (CurrentState==StatePktLength||CurrentState==StatePktNumber||
        CurrentState==StatePktType||CurrentState==StatePktRange)
        Reg_apply   =1;
    else
        Reg_apply   =0;
always @ (posedge Clk or posedge Reset)
    if (Reset)
        Reg_addr    <=0;
    else case (CurrentState)
            StatePktLength:
                Reg_addr    <=5'd00;
            StatePktNumber:
                Reg_addr    <=5'd01;
            StatePktType:
                case(PktTypeReg)
                    3'b011:
                        Reg_addr    <=5'd02;    
                    3'b001:
                        Reg_addr    <=5'd03;    
                    3'b100:
                        Reg_addr    <=5'd16;    
                    default:
                        Reg_addr    <=5'd04;    
                endcase
            StatePktRange:
                case(PktErrTypeReg)
                    3'b001:
                        Reg_addr    <=5'd05; 
                    3'b010:
                        Reg_addr    <=5'd06;    
                    3'b011:
                        Reg_addr    <=5'd07;    
                    3'b100:
                        if (PktLengthReg<64)    
                            Reg_addr    <=5'd08; 
                        else if (PktLengthReg==64)
                            Reg_addr    <=5'd09; 
                        else if (PktLengthReg<128)
                            Reg_addr    <=5'd10; 
                        else if (PktLengthReg<256)
                            Reg_addr    <=5'd11; 
                        else if (PktLengthReg<512)
                            Reg_addr    <=5'd12; 
                        else if (PktLengthReg<1024)
                            Reg_addr    <=5'd13; 
                        else if (PktLengthReg<1519)
                            Reg_addr    <=5'd14; 
                        else
                            Reg_addr    <=5'd15; 
                    default:
                        Reg_addr    <=5'd05;
                endcase
            default:
                    Reg_addr    <=5'd05;
        endcase
always @ (CurrentState or PktLengthReg)
    case (CurrentState)
        StatePktLength:
            Reg_data    =PktLengthReg;
        StatePktNumber:
            Reg_data    =1;
        StatePktType:
            Reg_data =1;
        StatePktRange:
            Reg_data =1;
        default:
            Reg_data =0;
    endcase
always @ (posedge Clk or posedge Reset)
    if (Reset)
        Reg_drop_apply  <=0;
    else if (CurrentState!=StateIdle&&Apply_rmon_pulse)
        Reg_drop_apply  <=1;
    else
        Reg_drop_apply  <=0;
endmodule