module lab5dram(CLK, RESET, ADDR, DATA, MW, Q, IOA, IOB, IOC, IOD, IOE, IOF, IOG);
  input        CLK;
  input        RESET;
  input  [7:0] ADDR;  
  input  [7:0] DATA;  
  input        MW;
  output [7:0] Q;
  input  [7:0] IOA;
  input  [7:0] IOB;
  input  [7:0] IOC;
  output [7:0] IOD;
  output [7:0] IOE;
  output [7:0] IOF;
  output [7:0] IOG;
  reg    [7:0] Q;
  reg    [7:0] IOreg [3:6]; 
  reg    [7:0] mem   [0:247];
  reg    [7:0] Q_IO;
  reg    [7:0] Q_mem;
  reg    [7:0] ADDR_IO;
  reg          MW_IO;
  reg          MW_mem;
  always @(*) begin
    Q_mem <= mem[ADDR];
  end
  always @(posedge CLK) begin
    if(RESET) begin
      mem[0]  <= 8'b0000_0000;  
      mem[1]  <= 8'b0000_0000;
      mem[2]  <= 8'b0000_1000;  
      mem[3]  <= 8'b0000_0000;
      mem[4]  <= 8'b0001_0111;  
      mem[5]  <= 8'b0000_0000;
      mem[6]  <= 8'b0010_0110;  
      mem[7]  <= 8'b0000_0000;
      mem[8]  <= 8'b0011_0101;  
      mem[9]  <= 8'b0000_0000;
      mem[10] <= 8'b0100_0100;  
      mem[11] <= 8'b0000_0000;
      mem[12] <= 8'b0101_0011;  
      mem[13] <= 8'b0000_0000;
      mem[14] <= 8'b0110_0010;  
      mem[15] <= 8'b0000_0000;
      mem[16] <= 8'b0111_0001;  
      mem[17] <= 8'b0000_0000;
      mem[18] <= 8'b1000_0000;  
      mem[19] <= 8'b0000_0000;
      mem[20] <= 8'b1000_1001;  
      mem[21] <= 8'b0000_0000;
      mem[22] <= 8'b1001_1000;  
      mem[23] <= 8'b0000_0000;
      mem[24] <= 8'b0000_0111;  
      mem[25] <= 8'b0000_0001;
      mem[26] <= 8'b0001_0110;  
      mem[27] <= 8'b0000_0001;
      mem[28] <= 8'b0010_0101;  
      mem[29] <= 8'b0000_0001;
      mem[30] <= 8'b0011_0011;  
      mem[31] <= 8'b0000_0001;
      mem[32] <= 8'b0100_0010;  
      mem[33] <= 8'b0000_0001;
      mem[34] <= 8'b0101_0001;  
      mem[35] <= 8'b0000_0001;
      mem[36] <= 8'b0110_0000;  
      mem[37] <= 8'b0000_0001;
      mem[38] <= 8'b0110_1001;  
      mem[39] <= 8'b0000_0001;
      mem[40] <= 8'b0111_1000;  
      mem[41] <= 8'b0000_0001;
      mem[42] <= 8'b1000_0111;  
      mem[43] <= 8'b0000_0001;
      mem[44] <= 8'b1001_0110;  
      mem[45] <= 8'b0000_0001;
      mem[46] <= 8'b0000_0101;  
      mem[47] <= 8'b0000_0010;
      mem[48] <= 8'b0001_0100;  
      mem[49] <= 8'b0000_0010;
      mem[50] <= 8'b0010_0011;  
      mem[51] <= 8'b0000_0010;
      mem[52] <= 8'b0011_0010;  
      mem[53] <= 8'b0000_0010;
      mem[54] <= 8'b0100_0001;  
      mem[55] <= 8'b0000_0010;
      mem[56] <= 8'b0101_0000;  
      mem[57] <= 8'b0000_0010;
      mem[58] <= 8'b0101_1001;  
      mem[59] <= 8'b0000_0010;
    end
    else if(MW_IO == 1'b1) begin
      IOreg[ADDR_IO] <= DATA;
    end
    else if(MW_mem == 1'b1) begin
      mem[ADDR] <= DATA;
    end
  end
  assign IOD = IOreg[3];
  assign IOE = IOreg[4];
  assign IOF = IOreg[5];
  assign IOG = IOreg[6];
  always @(*) begin
    MW_mem  = 0;
    MW_IO   = 0;
    ADDR_IO = 0;
    Q       = 8'd0;
    case(ADDR)
      8'd249: begin
        ADDR_IO = 0;
        Q = IOA;
      end
      8'd250: begin
        ADDR_IO = 1;
        Q = IOB;
      end
      8'd251: begin
        ADDR_IO = 2;
        Q = IOC;
      end
      8'd252: begin
        ADDR_IO = 3;
        MW_IO = MW;
      end
      8'd253: begin
        ADDR_IO = 4;
        MW_IO = MW;
      end
      8'd254: begin
        ADDR_IO = 5;
        MW_IO = MW;
      end
      8'd255: begin
        ADDR_IO = 6;
        MW_IO = MW;
      end
      default: begin 
        if(MW) begin
          MW_mem = 1;
        end
        else begin
          Q = Q_mem;
        end
      end
    endcase
  end
endmodule