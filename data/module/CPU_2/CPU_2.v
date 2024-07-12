module CPU_2 (clk,reset,pc,inst,Addr,Data_I,Data_O,WE,ACK,STB,debug_next_pc); 
    input  clk, reset;                                  
    input  [31:0] inst;                                 
    input  [31:0] Data_I;                               
    input  ACK;
    output [31:0] pc;                                   
    output [31:0] Addr;                                 
    output [31:0] Data_O;                               
    output WE;                                          
    output STB;
    output [31: 0] debug_next_pc;
    reg           wreg;                                 
    reg           wmem,rmem;                            
    reg    [31:0] alu_out;                              
    reg     [4:0] dest_rn;                              
    reg    [31:0] next_pc;                              
    wire   [31:0] pc_plus_4 = pc + 4;                   
    wire  [05:00] opcode = inst[31:26];
    wire  [04:00] rs     = inst[25:21];
    wire  [04:00] rt     = inst[20:16];
    wire  [04:00] rd     = inst[15:11];
    wire  [04:00] sa     = inst[10:06];
    wire  [05:00] func   = inst[05:00];
    wire  [15:00] imm    = inst[15:00];
    wire  [25:00] addr   = inst[25:00];
    wire          sign   = inst[15];
    wire  [31:00] offset = {{14{sign}},imm,2'b00};
    wire  [31:00] j_addr = {pc_plus_4[31:28],addr,2'b00};
    wire i_add  = (opcode == 6'h00) & (func == 6'h20);  
    wire i_sub  = (opcode == 6'h00) & (func == 6'h22);  
    wire i_and  = (opcode == 6'h00) & (func == 6'h24);  
    wire i_or   = (opcode == 6'h00) & (func == 6'h25);  
    wire i_xor  = (opcode == 6'h00) & (func == 6'h26);  
    wire i_sll  = (opcode == 6'h00) & (func == 6'h00);  
    wire i_srl  = (opcode == 6'h00) & (func == 6'h02);  
    wire i_sra  = (opcode == 6'h00) & (func == 6'h03);  
    wire i_jr   = (opcode == 6'h00) & (func == 6'h08);  
    wire i_addi = (opcode == 6'h08);                    
    wire i_andi = (opcode == 6'h0c);                    
    wire i_ori  = (opcode == 6'h0d);                    
    wire i_xori = (opcode == 6'h0e);                    
    wire i_lw   = (opcode == 6'h23);                    
    wire i_sw   = (opcode == 6'h2b);                    
    wire i_beq  = (opcode == 6'h04);                    
    wire i_bne  = (opcode == 6'h05);                    
    wire i_lui  = (opcode == 6'h0f);                    
    wire i_j    = (opcode == 6'h02);                    
    wire i_jal  = (opcode == 6'h03);                    
    reg [31:0] pc;
    always @ (posedge clk or posedge reset) begin
        if (reset) pc <= 0;
        else begin
            if (STB)
                pc <= ACK ? next_pc : pc;
            else
                pc <= next_pc;
        end
    end
    wire   [31:0] data_2_rf = i_lw ? Data_I : alu_out;
    reg    [31:0] regfile [1:31];                       
    wire   [31:0] a = (rs==0) ? 0 : regfile[rs];        
    wire   [31:0] b = (rt==0) ? 0 : regfile[rt];        
    always @ (posedge clk) begin
        if (wreg && (dest_rn != 0)) begin
            regfile[dest_rn] <= data_2_rf;              
        end
    end
    assign WE = wmem;    
    assign Data_O = b;                               
    assign Addr = alu_out;                         
    assign STB = rmem | wmem;
    always @(*) begin
        alu_out = 0;                                    
        dest_rn = rd;                                   
        wreg    = 0;                                    
        wmem    = 0;                                    
        rmem    = 0;                                    
        next_pc = pc_plus_4;
        case (1'b1)
            i_add: begin                                
                alu_out = a + b;
                wreg    = 1; end
            i_sub: begin                                
                alu_out = a - b;
                wreg    = 1; end
            i_and: begin                                
                alu_out = a & b;
                wreg    = 1; end
            i_or: begin                                 
                alu_out = a | b;
                wreg    = 1; end
            i_xor: begin                                
                alu_out = a ^ b;
                wreg    = 1; end
            i_sll: begin                                
                alu_out = b << sa;
                wreg    = 1; end
            i_srl: begin                                
                alu_out = b >> sa;
                wreg    = 1; end
            i_sra: begin                                
                alu_out = $signed(b) >>> sa;
                wreg    = 1; end
            i_jr: begin                                 
                next_pc = a; end
            i_addi: begin                               
                alu_out = a + {{16{sign}},imm};
                dest_rn = rt;
                wreg    = 1; end
            i_andi: begin                               
                alu_out = a & {16'h0,imm};
                dest_rn = rt;
                wreg    = 1; end
            i_ori: begin                                
                alu_out = a | {16'h0,imm};
                dest_rn = rt;
                wreg    = 1; end
            i_xori: begin                               
                alu_out = a ^ {16'h0,imm};
                dest_rn = rt;
                wreg    = 1; end
            i_lw: begin                                 
                alu_out = a + {{16{sign}},imm};
                dest_rn = rt;
                rmem    = 1;
                wreg    = 1; end
            i_sw: begin                                 
                alu_out = a + {{16{sign}},imm};
                wmem    = 1; end
            i_beq: begin                                
                if (a == b) 
                  next_pc = pc_plus_4 + offset; end
            i_bne: begin                                
                if (a != b) 
                  next_pc = pc_plus_4 + offset; end
            i_lui: begin                                
                alu_out = {imm,16'h0};
                dest_rn = rt;
                wreg    = 1; end
            i_j: begin                                  
                next_pc = j_addr; end
            i_jal: begin                                
                alu_out = pc_plus_4;
                wreg    = 1;
                dest_rn = 5'd31;
                next_pc = j_addr; end
            default: ;
        endcase
        wreg = STB ? wreg & ACK : wreg;
    end
    assign debug_next_pc = next_pc;
endmodule