module opc2cpu( inout[7:0] data, output[9:0] address, output rnw, input clk, input reset_b);
   parameter FETCH0=0, FETCH1=1, RDMEM=2, RDMEM2=3, EXEC=4 ;
   parameter LDBP=4'b11_00, LDBI=4'b10_00, LDB=4'b10_01, STAP=4'b10_10;
   parameter JPC =4'b01_00, JPZ=4'b01_01, STA =4'b01_10, JAL=4'b01_11;
   parameter ADC =4'b00_00, NOT=4'b00_01, AND =4'b00_10, AXB=4'b00_11;
   reg [9:0] PC_q, OR_q;
   reg [7:0]  ACC_q, B_q;
   reg [2:0]  FSM_q;
   reg [3:0]  IR_q;
   reg        C_q;
   wire   writeback_w = ((FSM_q == EXEC) && (IR_q==STA || IR_q==STAP)) & reset_b ;
   assign rnw = ~writeback_w ;
   assign data = (writeback_w)?ACC_q:8'bz ;
   assign address = ( writeback_w || FSM_q == RDMEM || FSM_q==RDMEM2)? OR_q:PC_q;
   always @ (posedge clk or negedge reset_b )
     if (!reset_b)
       FSM_q <= FETCH0;
     else
       case(FSM_q)
         FETCH0 : FSM_q <= (data[7] || data[6])?FETCH1:EXEC;     
         FETCH1 : FSM_q <= (IR_q[3] && IR_q != LDBI )?RDMEM:EXEC ;
         RDMEM  : FSM_q <= (IR_q[2])?RDMEM2:EXEC;
         RDMEM2 : FSM_q <= EXEC;
         EXEC   : FSM_q <= FETCH0;
       endcase
   always @ (posedge clk)
     begin
        IR_q <= (FSM_q == FETCH0)? data[7:4] : IR_q;
        OR_q[9:8] <= (FSM_q == FETCH0)? data[1:0] : (FSM_q == RDMEM)? 2'b0: OR_q[9:8];
        OR_q[7:0] <= data; 
        if ( FSM_q == EXEC )
          case(IR_q)
            AXB : {B_q,ACC_q}  <= {ACC_q,B_q};
            AND : {C_q, ACC_q} <= {1'b0, ACC_q & B_q};
            NOT : ACC_q <= ~ACC_q;
            ADC : {C_q,ACC_q} <= ACC_q + C_q + B_q;
            JAL : {B_q,ACC_q}  <= {6'b0,PC_q} ;
            LDB : B_q <= OR_q[7:0];
            LDBP: B_q <= OR_q[7:0];
            LDBI: B_q <= OR_q[7:0];
          endcase 
     end
   always @ (posedge clk or negedge reset_b )
     if (!reset_b) 
       PC_q <= 10'h100;
     else
       if ( FSM_q == FETCH0 || FSM_q == FETCH1 )
         PC_q <= PC_q + 1;
       else if ( FSM_q == EXEC )
         case (IR_q)
           JAL   : PC_q <= {B_q[1:0],ACC_q};
           JPC   : PC_q <= (C_q)?OR_q:PC_q;
         endcase
endmodule