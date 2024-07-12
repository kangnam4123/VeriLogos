module k580wi53channel(input clk, input c, input gate, output reg cout,
	input addr, input rd, input we_n, input[7:0] idata, output reg[7:0] odata);
reg[5:0]  mode;
reg[15:0] init;
reg[15:0] cntlatch;
reg[15:0] counter;
reg[15:0] sub1;
reg[15:0] sub2;
reg enabled;
reg latched;
reg loaded;
reg ff;
reg first;
reg done;
reg exc;
reg exgate;
reg exrd;
reg exwe_n;
always @(*)
	case ({latched,ff})
	2'b00: odata = counter[7:0];
	2'b01: odata = counter[15:8];
	2'b10: odata = cntlatch[7:0];
	2'b11: odata = cntlatch[15:8];
	endcase
always @(*)
	casex ({mode[0],|counter[15:12],|counter[11:8],|counter[7:4],|counter[3:0]})
	5'b10000: sub1 = 16'h9999;
	5'b11000: sub1 = 16'hF999;
	5'b1x100: sub1 = 16'hFF99;
	5'b1xx10: sub1 = 16'hFFF9;
	default:  sub1 = 16'hFFFF;
	endcase
always @(*)
	casex ({mode[0],|counter[15:12],|counter[11:8],|counter[7:4],|counter[3:1]})
	5'b10000: sub2 = 16'h9998;
	5'b11000: sub2 = 16'hF998;
	5'b1x100: sub2 = 16'hFF98;
	5'b1xx10: sub2 = 16'hFFF8;
	default:  sub2 = 16'hFFFE;
	endcase
wire[15:0] new1 = counter + (first|~&mode[2:1]?sub1:sub2);
wire[15:0] newvalue = {new1[15:1],new1[0]&~&mode[2:1]};
always @(posedge clk)
begin
	exc <= c; exgate <= gate; exrd <= rd; exwe_n <= we_n;
	if (enabled & c & ~exc) begin
		if (loaded) begin
			if (mode[2]==1'b1 && newvalue==0) begin
				counter <= init;
				first <= init[0]&~cout;
			end else begin
				counter <= newvalue;
				first <= 0;
			end
			if (newvalue[15:1]==0 && ~done) begin
				casex ({mode[3:1],newvalue[0]})
				4'b0000: {cout,done} <= 2'b11;
				4'b0010: {cout,done} <= 2'b11;
				4'bx100: cout <= 1'b1;
				4'bx101: cout <= 0;
				4'bx11x: cout <= ~cout;
				4'b1000: {cout,done} <= 2'b11;
				4'b1001: cout <= 0;
				4'b1010: {cout,done} <= 2'b11;
				4'b1011: cout <= 0;
				endcase
			end
		end else begin
			counter <= init; loaded <= 1'b1; first <= 1'b1; done <= 0;
			if (mode[3:2]==0) cout <= 0;
		end
	end
	if (exgate ^ gate) begin
		if (mode[2:1]!=2'b01) enabled <= gate;
		else if (gate) begin loaded <= 0; enabled <= 1; end
	end
	if (exrd & ~rd) begin
		if (mode[5:4]==2'b11) ff <= ~ff;
		if (mode[5:4]!=2'b11 || ff) latched <= 0;
	end else
	if (exwe_n & ~we_n) begin
		if (addr) begin
			if (idata[5:4]==0) begin
				cntlatch <= counter; latched <= 1;
			end else begin
				mode <= idata[5:0]; enabled <= 0; loaded <= 0; done <= 1'b1;
				latched <= 0; cout <= idata[3:1]!=0;
			end
			ff <= idata[5:4]==2'b10;
		end else begin
			casex ({mode[5:4],ff})
			3'b01x: begin init <= {8'h00,idata}; enabled <= gate; ff <= 0; end
			3'b10x: begin init <= {idata,8'h00}; enabled <= gate; ff <= 1; end
			3'b110: begin init[7:0] <= idata; enabled <= 0; ff <= 1; end
			3'b111: begin init[15:8] <= idata; enabled <= gate; ff <= 0; end
			endcase
			loaded <= mode[2:1]!=0 & ~done;
			cout <= mode[3:1]!=0||(mode[5:4]==2'b01&&idata==8'b1);
		end
	end
end
endmodule