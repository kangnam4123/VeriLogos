module MemMux
(
   input               MEM_MUX_CLK,
   inout  wire  [ 7:0] PORTA_DATA ,
   input  wire  [18:0] PORTA_ADDR ,
   input  wire         PORTA_WE   ,
   input  wire         PORTA_OE   ,
   input  wire         PORTA_CE   ,
   output wire  [ 7:0] PORTB_DATA ,
   input  wire  [18:0] PORTB_ADDR ,
   input  wire         PORTB_WE   ,
   input  wire         PORTB_OE   ,
   input  wire         PORTB_CE   ,
   inout  wire  [ 7:0] MEMORY_DATA,
   output wire  [18:0] MEMORY_ADDR,
   output wire         MEMORY_WE  ,
   output wire         MEMORY_OE  ,
   output wire         MEMORY_CE
);
reg  [7:0]PORTA_BUFFDATA = 0;
reg  [7:0]PORTB_BUFFDATA = 0;
reg [1:0]Sel = 0;
wire IS_SELECTED_PORTA = Sel[1];
assign MEMORY_CE   = IS_SELECTED_PORTA ? PORTA_CE   : PORTB_CE;
assign MEMORY_OE   = IS_SELECTED_PORTA ? PORTA_OE   : PORTB_OE;
assign MEMORY_WE   = IS_SELECTED_PORTA ? PORTA_WE   : PORTB_WE;
assign MEMORY_ADDR = IS_SELECTED_PORTA ? PORTA_ADDR : PORTB_ADDR;
assign MEMORY_DATA = ( !MEMORY_CE && !MEMORY_WE && MEMORY_OE && IS_SELECTED_PORTA ) ? PORTA_DATA : 8'hzz;
assign PORTA_DATA  = ( !PORTA_CE && PORTA_WE && !PORTA_OE ) ? PORTA_BUFFDATA : 8'hzz;
assign PORTB_DATA  = PORTB_BUFFDATA;
always @ ( posedge MEM_MUX_CLK )
begin 
    Sel <= Sel + 1'b1;
end
always @ ( negedge MEM_MUX_CLK )
begin
	 if( Sel == 2'b11 )
        PORTA_BUFFDATA <= MEMORY_DATA; 	 
	 if( Sel == 2'b01 )
	     PORTB_BUFFDATA <= MEMORY_DATA;	
end 
endmodule