module flags_1 (
  input  wire        clock,
  input  wire        wrFlags,
  input  wire [31:0] config_data,
  input  wire        finish_now,
  output reg  [31:0] flags_reg
);
reg [31:0] next_flags_reg;
initial flags_reg = 0;
always @(posedge clock) 
flags_reg <= next_flags_reg;
always @*
begin
  next_flags_reg = (wrFlags) ? config_data : flags_reg;
  if (finish_now) next_flags_reg[8] = 1'b0;
end
endmodule