module dummy_cartridge_1
(
  input wire [15:0] iAddr,
	output reg [7:0] oData
);
always @ ( iAddr )
begin
	case ( iAddr )
	16'h100: oData = 8'h00;
	16'h101: oData = 8'hc3;
	16'h102: oData = 8'h50;
	16'h103: oData = 8'h01;
	16'h104: oData = 8'hce; 
	16'h105: oData = 8'hed;
	16'h106: oData = 8'h66;
	16'h107: oData = 8'h66;
	16'h108: oData = 8'hcc;
	16'h109: oData = 8'h0d;
	16'h10a: oData = 8'h00;
	16'h10b: oData = 8'h0b;
	16'h10c: oData = 8'h03;
	16'h10d: oData = 8'h73;
	16'h10e: oData = 8'h00;
	16'h10f: oData = 8'h83;
	16'h110: oData = 8'h00;
	16'h111: oData = 8'h0c;
	16'h112: oData = 8'h00;
	16'h113: oData = 8'h0d;
	16'h114: oData = 8'h00;
	16'h115: oData = 8'h08;
	16'h116: oData = 8'h11;
	16'h117: oData = 8'h1f;
	16'h118: oData = 8'h88;
	16'h119: oData = 8'h89;
	16'h11A: oData = 8'h00;
	16'h11B: oData = 8'h0E;
	16'h11C: oData = 8'hDC;
	16'h11D: oData = 8'hCC;
	16'h11E: oData = 8'h6E;
	16'h11F: oData = 8'hE6;
	16'h120: oData = 8'hdd;
	16'h121: oData = 8'hdd;
	16'h122: oData = 8'hd9;
	16'h123: oData = 8'h99;
	16'h124: oData = 8'hbb;
	16'h125: oData = 8'hbb;
	16'h126: oData = 8'h67;
	16'h127: oData = 8'h63;
	16'h128: oData = 8'h6e;
	16'h129: oData = 8'h0e;
	16'h12A: oData = 8'hec;
	16'h12B: oData = 8'hcc;
	16'h12C: oData = 8'hdd;
	16'h12D: oData = 8'hdc;
	16'h12E: oData = 8'h99;
	16'h12F: oData = 8'h9f;
	16'h130: oData = 8'hbb;
	16'h131: oData = 8'hb9;
	16'h132: oData = 8'h33;
	16'h133: oData = 8'h3e;
	16'h134: oData = 8'h54;
	16'h135: oData = 8'h45;
	16'h136: oData = 8'h54;
	16'h137: oData = 8'h52;
  default: oData = 8'h0;
	endcase
end
endmodule