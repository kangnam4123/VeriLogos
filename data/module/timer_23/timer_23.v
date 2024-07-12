module timer_23(
			pclk,
			nreset,
			bus_write_en, 
			bus_read_en,
			bus_addr,
			bus_write_data,
			bus_read_data,
            fabint
            );
input pclk, nreset, bus_write_en, bus_read_en;
input [7:0] bus_addr;
input [31:0] bus_write_data;
output reg [31:0] bus_read_data;
output reg fabint;
reg [31:0] compareReg;
reg [31:0] counterReg;
reg [31:0] controlReg;
reg [31:0] overflowReg;
reg overflowReset;		
wire timerEn;        
wire interruptEn;    
wire compareEn;      
wire overflowEn;	 
assign timerEn 		= controlReg[0];
assign interruptEn 	= controlReg[1];
assign compareEn 	= controlReg[2];
assign overflowEn	= controlReg[3];
reg [1:0] interrupt_status;
reg reset_interrupt;
reg timer_interrupt;
reg [31:0] nextCounter;
always@(posedge pclk)
if(~nreset)
  fabint   <= 1'b0;
else
  begin
    if(timer_interrupt)
      fabint   <= 1'b1;
    else
      fabint   <= 1'b0;
end
always@(posedge pclk)
if(~nreset)
  begin
    overflowReset <= 1'b0;
    compareReg <= 32'h00000000;
    overflowReg <= 32'h00000000;
	controlReg <= 32'h00000000;
    reset_interrupt <= 1'b0;
  end
else begin
	if(bus_write_en) begin : WRITE
		case(bus_addr[4:2])
			3'b000: 
                begin 
                overflowReset <= 1'b1;
				overflowReg <= bus_write_data;
                end
            3'b001: 
                begin
                overflowReset <= 1'b0;
                end
            3'b010: 
                begin 
                overflowReset <= 1'b0;
                controlReg <= bus_write_data;
                end
            3'b011: 
                begin
                overflowReset <= 1'b0;
                compareReg <= bus_write_data;
                end
            3'b100: 
                begin
                overflowReset <= 1'b0;
                end
            3'b101: 
                begin
                end
        endcase
    end
	else if(bus_read_en) begin : READ
        case(bus_addr[4:2])
	        3'b000: 
                begin 
		        bus_read_data <= overflowReg;
                reset_interrupt <= 1'b0;
				end
            3'b001: 
                begin 
                bus_read_data <= counterReg;
                reset_interrupt <= 1'b0;
				end
            3'b010: 
                begin 
                bus_read_data <= controlReg;
                reset_interrupt <= 1'b0;
			    end
            3'b011: 
                begin
                bus_read_data <= compareReg;
                reset_interrupt <= 1'b0;
                end
            3'b100: 
                begin 
                bus_read_data[31:2] <= 30'd0;;
                bus_read_data[1:0] <= interrupt_status;
                reset_interrupt <= 1'b1;
                end
            3'b101: 
                begin
                end
        endcase
     end
     else begin
	   overflowReset <= 1'b0;
       reset_interrupt <= 1'b0;
     end
end
always@*
	nextCounter = counterReg + 1;
always@(posedge pclk)
if(~nreset) begin
	counterReg <= 32'd0;
    timer_interrupt <= 1'b0;
    interrupt_status <= 2'b00;
end
else begin
    if(reset_interrupt)begin
        interrupt_status <= 2'b00;
        timer_interrupt <= 1'b0;
    end
    else begin
        if(overflowReset) begin
            counterReg <= 32'd0;
            timer_interrupt <= 1'b0;
        end
        else if(timerEn) begin
            if(counterReg == overflowReg) begin
                counterReg <= 32'd0;
                if(interruptEn && overflowEn) begin
                    timer_interrupt <= 1'b1;
                    interrupt_status[0] <= 1'b1;
                end
                else
                    timer_interrupt <= 1'b0;
            end
            else begin
                if(counterReg == compareReg && interruptEn && compareEn) begin
                    timer_interrupt <= 1'b1;
                    interrupt_status[1] <= 1'b1;
                end
                else
                    timer_interrupt <= 1'b0;
                counterReg <= nextCounter;
            end
        end
    end
end
endmodule