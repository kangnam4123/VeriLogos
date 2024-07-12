module gci_std_display_device_special_memory
	#(
		parameter USEMEMSIZE = 32'h00000000,
		parameter PRIORITY = 32'h00000000,
		parameter DEVICECAT = 32'h00000000
	)(							
		input wire iCLOCK,
		input wire inRESET,
		input wire iSPECIAL_REQ,
		input wire iSPECIAL_RW,
		input wire [7:0] iSPECIAL_ADDR,
		input wire [31:0] iSPECIAL_DATA,
		output wire [31:0] oSPECIAL_DATA
	);
	integer	i;
	reg [31:0] b_mem[0:255];	
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			for(i = 0; i < 256; i = i + 1)begin
				if(i == 0)begin
					b_mem[i] <= USEMEMSIZE;
				end
				else if(i == 1)begin
					b_mem[i] <= PRIORITY;
				end
				else begin
					b_mem[i] <= 32'h00000000;
				end
			end		
		end
		else begin
			if(iSPECIAL_REQ && iSPECIAL_RW)begin
				b_mem [iSPECIAL_ADDR] <= iSPECIAL_ADDR;
			end	
		end
	end 
	assign oSPECIAL_DATA = b_mem[iSPECIAL_ADDR];
endmodule