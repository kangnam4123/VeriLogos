module fsm_ps2data (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
 	localparam [1:0] BYTE1 = 2'b00,
    				 BYTE2 = 2'b01,
    				 BYTE3 = 2'b10,
    				 DONE  = 2'b11;

    reg [1:0] state, next;
    reg [23:0] data;

    always @(*) begin
    	case(state)
    		BYTE1 : next = (in[3]) ? BYTE2 : BYTE1;
    		BYTE2 : next = BYTE3;
    		BYTE3 : next = DONE;
    		DONE  : next = (in[3]) ? BYTE2 : BYTE1;
    	endcase
    end

    always @(posedge clk) begin
    	if(reset) state <= BYTE1;
    	else state <= next;
    end
 
    always @(posedge clk) begin
    	if (reset) data <= 24'b0;
    	else data <= {data[15:8], data[7:0], in};
    end
    
    assign done = (state == DONE);
    assign out_bytes = (done) ? data : 23'b0;		
	
endmodule