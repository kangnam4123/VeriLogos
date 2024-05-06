module PLICFanIn(
  input   io_prio_0,
  input   io_ip,
  output  io_dev,
  output  io_max
);
  wire [1:0] effectivePriority_1 = {io_ip,io_prio_0}; 
  wire  _T = 2'h2 >= effectivePriority_1; 
  wire [1:0] maxPri = _T ? 2'h2 : effectivePriority_1; 
  assign io_dev = _T ? 1'h0 : 1'h1; 
  assign io_max = maxPri[0]; 
endmodule