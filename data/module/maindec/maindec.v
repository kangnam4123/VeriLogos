module maindec(input        clk, reset, 
               input  [5:0] op, 
               output       pcwrite, memwrite, irwrite, regwrite,
               output       alusrca, branch, iord, memtoreg, regdst,
               output [1:0] alusrcb, 
					output [1:0] pcsrc,   
               output [1:0] aluop); 
  parameter   FETCH   			= 5'b00000; 
  parameter   DECODE  			= 5'b00001; 
  parameter   MEMADR  			= 5'b00010;	
  parameter   MEMRD   			= 5'b00011;	
  parameter   MEMWB   			= 5'b00100;	
  parameter   MEMWR   			= 5'b00101;	
  parameter   EXECUTE 			= 5'b00110;	
  parameter   ALUWRITEBACK 	= 5'b00111;	
  parameter   BRANCH   			= 5'b01000;	
  parameter   ADDIEXECUTE		= 5'b01001;	
  parameter   ADDIWRITEBACK	= 5'b01010;	
  parameter   JUMP    			= 5'b01011;	
  parameter   LW      = 6'b100011;	
  parameter   SW      = 6'b101011;	
  parameter   RTYPE   = 6'b000000;	
  parameter   BEQ     = 6'b000100;	
  parameter   ADDI    = 6'b001000;	
  parameter   J       = 6'b000010;	
  reg [4:0]  state, nextstate;
  reg [16:0] controls;
  always @(posedge clk or posedge reset)			
    if(reset) state <= FETCH;
    else state <= nextstate;
  always @( * )
    case(state)
      FETCH:   nextstate <= DECODE;
      DECODE:  case(op)
                 LW:      nextstate <= MEMADR;
                 SW:      nextstate <= MEMADR;
                 RTYPE:   nextstate <= EXECUTE;
                 BEQ:     nextstate <= BRANCH;
                 ADDI:    nextstate <= ADDIEXECUTE;
                 J:       nextstate <= JUMP;
                 default: nextstate <= FETCH;  
               endcase
      MEMADR:  case(op)
                 LW:      nextstate <= MEMRD;
                 SW:      nextstate <= MEMWR;
                 default: nextstate <= FETCH; 
               endcase
      MEMRD:   nextstate <= MEMWB;
      MEMWB:   nextstate <= FETCH;
      MEMWR:   nextstate <= FETCH;
      EXECUTE: nextstate <= ALUWRITEBACK;
      ALUWRITEBACK: nextstate <= FETCH;
      BRANCH:   nextstate <= FETCH;
      ADDIEXECUTE:  nextstate <= ADDIWRITEBACK;
      ADDIWRITEBACK:  nextstate <= FETCH;
      JUMP:    nextstate <= FETCH;
      default: nextstate <= FETCH;  
    endcase
  assign {pcwrite, memwrite, irwrite, regwrite, 
          alusrca, branch, iord, memtoreg, regdst, 
          alusrcb, pcsrc, 
			 aluop} = controls;
  always @( * )
    case(state)
      FETCH:          controls <= 19'b1010_00000_0100_00;
      DECODE:         controls <= 19'b0000_00000_1100_00;
      MEMADR:         controls <= 19'b0000_10000_1000_00;
      MEMRD:          controls <= 19'b0000_00100_0000_00;
      MEMWB:          controls <= 19'b0001_00010_0000_00;
      MEMWR:          controls <= 19'b0100_00100_0000_00;
      EXECUTE:        controls <= 19'b0000_10000_0000_10;
      ALUWRITEBACK:   controls <= 19'b0001_00001_0000_00;
      BRANCH:         controls <= 19'b0000_11000_0001_01;
      ADDIEXECUTE:    controls <= 19'b0000_10000_1000_00;
      ADDIWRITEBACK:  controls <= 19'b0001_00000_0000_00;
      JUMP:           controls <= 19'b1000_00000_0010_00;     
      default:        controls <= 19'b0000_xxxxx_xxxx_xx; 
    endcase
endmodule