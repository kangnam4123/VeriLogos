module altera_up_character_lcd_initialization (
	clk,
	reset,
	initialize_LCD_display,
	command_was_sent,
	done_initialization,
	send_command,
	the_command
);
parameter	CURSOR_ON						= 1'b1;
parameter	BLINKING_ON						= 1'b1;
parameter	CLOCK_CYCLES_FOR_15MS		= 750000;
parameter	W15								= 20;	
parameter	COUNTER_INCREMENT_FOR_15MS	= 20'h00001;
parameter	CLOCK_CYCLES_FOR_5MS			= 250000;
parameter	W5									= 18;	
parameter	COUNTER_INCREMENT_FOR_5MS	= 18'h00001;
input						clk;
input						reset;
input						initialize_LCD_display;
input						command_was_sent;
output					done_initialization;
output					send_command;
output reg	[ 8: 0]	the_command;
localparam	LCD_INIT_STATE_0_WAIT_POWER_UP	= 2'h0,
				LCD_INIT_STATE_1_SEND_COMMAND		= 2'h1,
				LCD_INIT_STATE_2_CHECK_DONE		= 2'h2,
				LCD_INIT_STATE_3_DONE				= 2'h3;
localparam	AUTO_INIT_LENGTH						= 4'h8;
reg			[ 8: 0]	command_rom;
reg			[W15: 1]	waiting_power_up;
reg			[W5: 1]	waiting_to_send;
reg			[ 3: 0]	command_counter;
reg			[ 1: 0]	ns_lcd_initialize;
reg			[ 1: 0]	s_lcd_initialize;
always @(posedge clk)
begin
	if (reset)
		s_lcd_initialize <= LCD_INIT_STATE_0_WAIT_POWER_UP;
	else
		s_lcd_initialize <= ns_lcd_initialize;
end
always @(*)
begin
	ns_lcd_initialize = LCD_INIT_STATE_0_WAIT_POWER_UP;
   case (s_lcd_initialize)
	LCD_INIT_STATE_0_WAIT_POWER_UP:
		begin
			if ((waiting_power_up == CLOCK_CYCLES_FOR_15MS) &
					(initialize_LCD_display))
				ns_lcd_initialize = LCD_INIT_STATE_1_SEND_COMMAND;
			else
				ns_lcd_initialize = LCD_INIT_STATE_0_WAIT_POWER_UP;
		end
	LCD_INIT_STATE_1_SEND_COMMAND:
		begin
			if (command_was_sent)
				ns_lcd_initialize = LCD_INIT_STATE_2_CHECK_DONE;
			else
				ns_lcd_initialize = LCD_INIT_STATE_1_SEND_COMMAND;
		end
	LCD_INIT_STATE_2_CHECK_DONE:
		begin
			if (command_counter == AUTO_INIT_LENGTH)
				ns_lcd_initialize = LCD_INIT_STATE_3_DONE;
			else if (waiting_to_send == CLOCK_CYCLES_FOR_5MS)
				ns_lcd_initialize = LCD_INIT_STATE_1_SEND_COMMAND;
			else
				ns_lcd_initialize = LCD_INIT_STATE_2_CHECK_DONE;
		end
	LCD_INIT_STATE_3_DONE:
		begin
			if (initialize_LCD_display)
				ns_lcd_initialize = LCD_INIT_STATE_3_DONE;
			else
				ns_lcd_initialize = LCD_INIT_STATE_0_WAIT_POWER_UP;
		end
	default:
		begin
			ns_lcd_initialize = LCD_INIT_STATE_0_WAIT_POWER_UP;
		end
	endcase
end
always @(posedge clk)
begin
	if (reset)
		the_command <= 9'h000;
	else
		the_command <= command_rom;
end
always @(posedge clk)
begin
	if (reset)
		waiting_power_up <= {W15{1'b0}};
	else if ((s_lcd_initialize == LCD_INIT_STATE_0_WAIT_POWER_UP) &&
				(waiting_power_up != CLOCK_CYCLES_FOR_15MS))
		waiting_power_up <= waiting_power_up + COUNTER_INCREMENT_FOR_15MS;
end
always @(posedge clk)
begin
	if (reset)
		waiting_to_send <= {W5{1'b0}};
	else if (s_lcd_initialize == LCD_INIT_STATE_2_CHECK_DONE)
	begin
		if (waiting_to_send != CLOCK_CYCLES_FOR_5MS)
			waiting_to_send <= waiting_to_send + COUNTER_INCREMENT_FOR_5MS;
	end
	else
		waiting_to_send <= {W5{1'b0}};
end
always @(posedge clk)
begin
	if (reset)
		command_counter <= 4'h0;
	else if (s_lcd_initialize == LCD_INIT_STATE_1_SEND_COMMAND)
	begin
		if (command_was_sent)
			command_counter <= command_counter + 4'h1;
	end
	else if (s_lcd_initialize == LCD_INIT_STATE_3_DONE)
		command_counter <= 4'h5;
end
assign send_command	= (s_lcd_initialize == LCD_INIT_STATE_1_SEND_COMMAND);
assign done_initialization = (s_lcd_initialize == LCD_INIT_STATE_3_DONE);
always @(*)
begin
	case (command_counter)
	0		:	command_rom	<=	9'h030;
	1		:	command_rom	<=	9'h030;
	2		:	command_rom	<=	9'h030;
	3		:	command_rom	<=	9'h03C;
	4		:	command_rom	<=	9'h008;
	5		:	command_rom	<=	9'h001;
	6		:	command_rom	<=	9'h006;
	7		:	command_rom	<=	{7'h03, CURSOR_ON, BLINKING_ON};
	default	:	command_rom	<=	9'h000;
	endcase
end
endmodule