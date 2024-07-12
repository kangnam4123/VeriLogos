module fifo_39(clock,reset,read,write,fifo_in,fifo_out,fifo_empty,fifo_full);
    parameter DEPTH = 128;  						
	 parameter DEPTH_BINARY = 7;  				
	 parameter WIDTH = 4;							
	 parameter MAX_CONT = 7'b1111111;			
	 parameter 
		 reg0=7'b0000001,
		 reg1=7'b1001111,
		 reg2=7'b0010010,
		 reg3=7'b0000110,
		 reg4=7'b1001100,
		 reg5=7'b0100100,
		 reg6=7'b0100000,
		 reg7=7'b0001101,
		 reg8=7'b0000000,
		 reg9=7'b0000100,
		 rega=7'b0001000,
		 regb=7'b1100000,
		 regc=7'b0110001,
		 regd=7'b1000010,
		 rege=7'b0110000,
		 regf=7'b0111000;
    input clock,reset,read,write;       			
    input [WIDTH-1:0]fifo_in;    					
    output[WIDTH-1:0]fifo_out;            	   
    output fifo_empty,fifo_full;        			
    reg [WIDTH-1:0]fifo_out;                    
    reg [WIDTH-1:0]ram[DEPTH-1:0];              
    reg [DEPTH_BINARY-1:0]read_ptr,write_ptr,counter;        
    wire fifo_empty,fifo_full;          			
	 initial                                                
	 begin             
		counter = 0;
		read_ptr = 0;
		write_ptr = 0;
		fifo_out = 0;
	 end              
	 assign fifo_empty = (counter == 0);    		
    assign fifo_full = (counter == DEPTH-1);
	 always@(posedge clock)    						
        if(reset)   										
            begin
                read_ptr = 0; 
                write_ptr = 0;
                counter = 0;
                fifo_out = 0;                    
            end
        else
            case({read,write})  
            2'b00:;  
            2'b01:  
            begin
					 if (counter < DEPTH - 1)	
						 begin
						 ram[write_ptr] = fifo_in;
						 counter = counter + 1;
						 write_ptr = (write_ptr == DEPTH-1)?0:write_ptr + 1;
						 end
            end
            2'b10: 
            begin
					 if (counter > 0)	
						 begin
						 fifo_out = ram[read_ptr];
						 counter = counter - 1;
						 read_ptr = (read_ptr == DEPTH-1)?0:read_ptr + 1;
						 end
            end
            2'b11: 
            begin
                if(counter == 0)
                    fifo_out = fifo_in;	
                else
                begin
                    ram[write_ptr]=fifo_in;
                    fifo_out=ram[read_ptr];
                    write_ptr=(write_ptr==DEPTH-1)?0:write_ptr+1;
                    read_ptr=(read_ptr==DEPTH-1)?0:write_ptr+1;
                end
            end
        endcase
endmodule