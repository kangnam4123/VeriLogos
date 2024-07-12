module i_mem
(
  input [7:0]address,
  output [31:0]data
);
wire [31:0]program[255:0];
assign program[0]=32'h0036e000; 
assign program[1]=32'h0036e104; 
assign program[2]=32'h0010e001; 
assign program[3]=32'h00001200; 
assign program[4]=32'h0332e702; 
assign program[5]=32'h0036e301; 
assign data=program[address];
endmodule