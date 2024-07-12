module data_align #(
  parameter integer DW = 32,  
  parameter integer KW = DW/8 
)(
  input  wire        clk,
  input  wire        rst,
  input  wire  [3:0] disabledGroups,
  input  wire        sti_valid,
  input  wire [31:0] sti_data,
  output reg         sto_valid,
  output reg  [31:0] sto_data
);
reg [1:0] insel0;
reg [1:0] insel1;
reg       insel2;
always @ (posedge clk)
begin
  case (insel0[1:0])
    2'h3    : sto_data[ 7: 0] <= sti_data[31:24];
    2'h2    : sto_data[ 7: 0] <= sti_data[23:16];
    2'h1    : sto_data[ 7: 0] <= sti_data[15: 8];
    default : sto_data[ 7: 0] <= sti_data[ 7: 0];
  endcase
  case (insel1[1:0])
    2'h2    : sto_data[15: 8] <= sti_data[31:24];
    2'h1    : sto_data[15: 8] <= sti_data[23:16];
    default : sto_data[15: 8] <= sti_data[15: 8];
  endcase
  case (insel2)
    1'b1    : sto_data[23:16] <= sti_data[31:24];
    default : sto_data[23:16] <= sti_data[23:16];
  endcase
              sto_data[31:24] <= sti_data[31:24];
end
always @(posedge clk) 
begin
  case (disabledGroups)
    4'b0001 : begin insel2 <= 1'b1; insel1 <= 2'h1; insel0 <= 2'h1; end
    4'b0010 : begin insel2 <= 1'b1; insel1 <= 2'h1; insel0 <= 2'h0; end
    4'b0100 : begin insel2 <= 1'b1; insel1 <= 2'h0; insel0 <= 2'h0; end
    4'b0011 : begin insel2 <= 1'b0; insel1 <= 2'h2; insel0 <= 2'h2; end
    4'b0101 : begin insel2 <= 1'b0; insel1 <= 2'h2; insel0 <= 2'h1; end
    4'b1001 : begin insel2 <= 1'b0; insel1 <= 2'h1; insel0 <= 2'h1; end
    4'b0110 : begin insel2 <= 1'b0; insel1 <= 2'h2; insel0 <= 2'h0; end
    4'b1010 : begin insel2 <= 1'b0; insel1 <= 2'h1; insel0 <= 2'h0; end
    4'b1100 : begin insel2 <= 1'b0; insel1 <= 2'h0; insel0 <= 2'h0; end
    4'b0111 : begin insel2 <= 1'b0; insel1 <= 2'h0; insel0 <= 2'h3; end
    4'b1011 : begin insel2 <= 1'b0; insel1 <= 2'h0; insel0 <= 2'h2; end
    4'b1101 : begin insel2 <= 1'b0; insel1 <= 2'h0; insel0 <= 2'h1; end
    default : begin insel2 <= 1'b0; insel1 <= 2'h0; insel0 <= 2'h0; end
  endcase
end
always @(posedge clk, posedge rst) 
if (rst)  sto_valid <= 1'b0;
else      sto_valid <= sti_valid;
endmodule