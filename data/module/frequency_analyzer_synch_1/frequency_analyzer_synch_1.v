module frequency_analyzer_synch_1 #
(
    parameter integer CLOCK = 100000000,
    parameter integer FREQUENCY = 2000
)
(
    input wire clock,
    input wire reset,
    input wire enable,
    output reg start_analyzer_0,
    output reg stop_analyzer_0,
    output reg start_analyzer_1,
    output reg stop_analyzer_1
);
    localparam integer frequency_ticks = CLOCK / FREQUENCY;
    localparam integer signal_delay = 40;
    integer clock_counter;
	always @(posedge clock) 
	begin
	    if(!reset)
		    clock_counter <= 0;
	    else if(enable) 
	    begin
            clock_counter <= clock_counter + 1;      
            if(clock_counter >= frequency_ticks + frequency_ticks + signal_delay)
                clock_counter <= 0;
		end
	end
	always @(posedge clock) 
	begin
	    if(!reset) 
	    begin
		    start_analyzer_0 <= 0;
			stop_analyzer_0 <= 0;
			start_analyzer_1 <= 0;
			stop_analyzer_1 <= 0;
		end
		else if(enable) 
		begin
            if(clock_counter < signal_delay) 
            begin
                start_analyzer_0 <= 1;
                stop_analyzer_0 <= 0;
                start_analyzer_1 <= 0;
                stop_analyzer_1 <= 0;
            end
            else if(clock_counter >= signal_delay && clock_counter < frequency_ticks) 
            begin
                start_analyzer_0 <= 0;
                stop_analyzer_0 <= 0;
                start_analyzer_1 <= 0;
                stop_analyzer_1 <= 0;
            end
            else if(clock_counter >= frequency_ticks && clock_counter < frequency_ticks + signal_delay) 
            begin
                start_analyzer_0 <= 0;
                stop_analyzer_0 <= 1;
                start_analyzer_1 <= 1;
                stop_analyzer_1 <= 0;
            end
            else if(clock_counter >= frequency_ticks + signal_delay && clock_counter < frequency_ticks + frequency_ticks) 
            begin
                start_analyzer_0 <= 0;
                stop_analyzer_0 <= 0;
                start_analyzer_1 <= 0;
                stop_analyzer_1 <= 0;
            end
            else if(clock_counter >= frequency_ticks + frequency_ticks) 
            begin
                start_analyzer_0 <= 1;
                stop_analyzer_0 <= 0;
                start_analyzer_1 <= 0;
                stop_analyzer_1 <= 1;
            end
        end
    end
endmodule