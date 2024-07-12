module Ramdon_gen( 
Reset           ,
Clk             ,
Init            ,
RetryCnt        ,
Random_time_meet
);
input           Reset           ;
input           Clk             ;
input           Init            ;
input   [3:0]   RetryCnt        ;
output          Random_time_meet;   
reg [9:0]       Random_sequence ;
reg [9:0]       Ramdom          ;
reg [9:0]       Ramdom_counter  ;
reg [7:0]       Slot_time_counter; 
reg             Random_time_meet;
always @ (posedge Clk or posedge Reset)
    if (Reset)
        Random_sequence     <=0;
    else
        Random_sequence     <={Random_sequence[8:0],~(Random_sequence[2]^Random_sequence[9])};
always @ (RetryCnt or Random_sequence)
    case (RetryCnt)
        4'h0    :   Ramdom={9'b0,Random_sequence[0]};
        4'h1    :   Ramdom={8'b0,Random_sequence[1:0]};     
        4'h2    :   Ramdom={7'b0,Random_sequence[2:0]};
        4'h3    :   Ramdom={6'b0,Random_sequence[3:0]};
        4'h4    :   Ramdom={5'b0,Random_sequence[4:0]};
        4'h5    :   Ramdom={4'b0,Random_sequence[5:0]};
        4'h6    :   Ramdom={3'b0,Random_sequence[6:0]};
        4'h7    :   Ramdom={2'b0,Random_sequence[7:0]};
        4'h8    :   Ramdom={1'b0,Random_sequence[8:0]};
        4'h9    :   Ramdom={     Random_sequence[9:0]};  
        default :   Ramdom={     Random_sequence[9:0]};
    endcase
always @ (posedge Clk or posedge Reset)
    if (Reset)
        Slot_time_counter       <=0;
    else if(Init)
        Slot_time_counter       <=0;
    else if(!Random_time_meet)
        Slot_time_counter       <=Slot_time_counter+1;
always @ (posedge Clk or posedge Reset)
    if (Reset)
        Ramdom_counter      <=0;
    else if (Init)
        Ramdom_counter      <=Ramdom;
    else if (Ramdom_counter!=0&&Slot_time_counter==255)
        Ramdom_counter      <=Ramdom_counter -1 ;
always @ (posedge Clk or posedge Reset)
    if (Reset)
        Random_time_meet    <=1;
    else if (Init)
        Random_time_meet    <=0;
    else if (Ramdom_counter==0)
        Random_time_meet    <=1;
endmodule