module Test_29 (
   state, myevent, myevent_pending,
   clk, reset
   );
   input clk;
   input reset;
   output [1:0] state;
   output	myevent;
   output	myevent_pending;
   reg [5:0] 	count = 0;
   always @ (posedge clk)
     if (reset) count <= 0;
     else count <= count + 1;
   reg 		myevent = 1'b0;
   always @ (posedge clk)
     myevent <= (count == 6'd27);
   reg 		myevent_done;
   reg 		hickup_ready;
   reg 		hickup_done;
   localparam STATE_ZERO   = 0;
   localparam STATE_ONE    = 1;
   localparam STATE_TWO    = 2;
   reg [1:0] 	state                   = STATE_ZERO;
   reg 		state_start_myevent     = 1'b0;
   reg 		state_start_hickup      = 1'b0;
   reg 		myevent_pending         = 1'b0;
   always @ (posedge clk) begin
      state <= state;
      myevent_pending <= myevent_pending || myevent;
      state_start_myevent <= 1'b0;
      state_start_hickup <= 1'b0;
      case (state)
	STATE_ZERO:
	  if (myevent_pending) begin
             state <= STATE_ONE;
             myevent_pending <= 1'b0;
             state_start_myevent <= 1'b1;
	  end else if (hickup_ready) begin
             state <= STATE_TWO;
             state_start_hickup <= 1'b1;
	  end
	STATE_ONE:
	  if (myevent_done)
            state <= STATE_ZERO;
	STATE_TWO:
	  if (hickup_done)
            state <= STATE_ZERO;
	default:
	  ; 
      endcase
   end
   reg [3:0] myevent_count = 0;
   always @ (posedge clk)
     if (state_start_myevent)
       myevent_count <= 9;
     else if (myevent_count > 0)
       myevent_count <= myevent_count - 1;
   initial myevent_done = 1'b0;
   always @ (posedge clk)
     myevent_done <= (myevent_count == 0);
   reg [4:0] hickup_backlog = 2;
   always @ (posedge clk)
     if (state_start_myevent)
       hickup_backlog <= hickup_backlog - 1;
     else if (state_start_hickup)
       hickup_backlog <= hickup_backlog + 1;
   initial hickup_ready = 1'b1;
   always @ (posedge clk)
     hickup_ready <= (hickup_backlog < 3);
   reg [3:0] hickup_count = 0;
   always @ (posedge clk)
     if (state_start_hickup)
       hickup_count <= 10;
     else if (hickup_count > 0)
       hickup_count <= hickup_count - 1;
   initial hickup_done = 1'b0;
   always @ (posedge clk)
     hickup_done <= (hickup_count == 1);
endmodule