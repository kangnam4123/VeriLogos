module BTN_Anti_jitter_2(
                        clk, 
                        button,
                        SW, 
                        button_out,
                        SW_OK
                        );
    input  wire         clk;
    input  wire [ 3: 0] button;
    input  wire [ 7: 0] SW;
    output reg  [ 3: 0] button_out = 0;
	output reg  [ 7: 0] SW_OK      = 0;
    reg         [31: 0] counter    = 0;
    always @(posedge clk) begin
       if ( counter > 0 ) begin
            if ( counter < 100000 )
                counter <= counter+1;
            else 
				begin 
				    counter     <= 32'b0;
                    button_out  <= button; 
					SW_OK       <= SW; 
				end
        end else begin
            if ( button > 0 || SW > 0 )
                counter <= counter + 1;
        end     
    end
endmodule