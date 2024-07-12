module DNegflipFlop_2(dbus, abus, Dselect, Bselect, Aselect, bbus, clk);
    input [31:0] dbus;
    input Dselect;
    input Bselect;
    input Aselect;
    input clk;
    output [31:0] abus;
    output [31:0] bbus;
    reg [31:0] data;
    always @(negedge clk) begin
      if(Dselect) begin
      data = dbus;
      end
    end
    assign abus = Aselect ? data : 32'bz;
    assign bbus = Bselect ? data : 32'bz;
  endmodule