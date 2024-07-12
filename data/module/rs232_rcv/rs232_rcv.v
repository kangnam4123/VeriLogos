module  rs232_rcv (xclk,           
                   bitHalfPeriod,  
                   ser_di,         
                   ser_rst,        
                   ts_stb,         
                   wait_just_pause,
                   start,          
                   ser_do,         
                   ser_do_stb,    
                   debug,        
                   bit_dur_cntr,
                   bit_cntr);
  input         xclk;           
  input  [15:0] bitHalfPeriod;  
  input         ser_di;         
  input         ser_rst;        
  output        ts_stb;         
  output        wait_just_pause;
  output        start;          
  output [4:0]  debug;          
  output        ser_do;         
  output        ser_do_stb;     
  output [15:0] bit_dur_cntr;   
  output  [4:0] bit_cntr;       
  reg  [4:0] ser_di_d;
  reg        ser_filt_di;
  reg        ser_filt_di_d;
  reg        bit_half_end; 
  reg        last_half_bit;
  reg        wait_pause;   
  reg        wait_start;   
  reg        receiving_byte;
  reg        start;
  reg [15:0] bit_dur_cntr; 
  reg [4:0]  bit_cntr;     
  wire       error;        
  reg  [1:0] restart;
  wire       reset_wait_pause;
  reg        ts_stb;
  reg        shift_en;
  reg        ser_do;
  reg        ser_do_stb;
  wire       sample_bit;
  wire       reset_bit_duration;
  reg        wait_just_pause;
  wire       wstart;
  wire [4:0] debug;
  reg  [4:0] debug0;          
  assign     reset_wait_pause= (restart[1] && !restart[0]) || (wait_pause && !wait_start && !ser_di);
  assign     error=!ser_filt_di && last_half_bit && bit_half_end && receiving_byte;
  assign     sample_bit=shift_en && bit_half_end && !bit_cntr[0];
  assign     reset_bit_duration= reset_wait_pause || start || bit_half_end || ser_rst;
  assign wstart=wait_start && ser_filt_di_d && !ser_filt_di;
  assign debug[4:0] = {1'b0,wait_start,wait_pause,receiving_byte,shift_en};
  always @ (posedge xclk) begin
    ser_di_d[4:0] <= {ser_di_d[3:0],ser_di};
    if (ser_rst || &ser_di_d[4:0]) ser_filt_di <= 1'b1;
    else if      (~|ser_di_d[4:0]) ser_filt_di <= 1'b0;
    ser_filt_di_d <= ser_filt_di;
    restart[1:0] <= {restart[0],(ser_rst || (last_half_bit && bit_half_end && receiving_byte))};
    wait_pause <= !ser_rst && (reset_wait_pause ||
                               (receiving_byte && last_half_bit && bit_half_end ) ||
                               (wait_pause && !(last_half_bit && bit_half_end) && !(wait_start && !ser_filt_di)));
    start                 <= wstart;
    ts_stb <= !wait_pause && wstart; 
    bit_half_end <=(bit_dur_cntr[15:0]==16'h1) && !reset_bit_duration;
    wait_start <= !ser_rst && ((wait_pause || receiving_byte) && last_half_bit && bit_half_end  || (wait_start && !wstart));
    receiving_byte <= !ser_rst && (start || (receiving_byte && !(last_half_bit && bit_half_end)));
    wait_just_pause <=wait_pause && !wait_start;
    if (reset_bit_duration) bit_dur_cntr[15:0] <= bitHalfPeriod[15:0];
    else                    bit_dur_cntr[15:0] <= bit_dur_cntr[15:0] - 1;
    if (reset_wait_pause || ser_rst)  bit_cntr[4:0] <= 5'h13;
    else if (start)                    bit_cntr[4:0] <= 5'h12;
    else if (bit_half_end)             bit_cntr[4:0] <= bit_cntr[4:0] - 1;
    last_half_bit <= ((bit_cntr[4:0] == 5'h0) && !bit_half_end); 
    shift_en <= receiving_byte &&  ((bit_half_end && ( bit_cntr[3:0]==4'h2))? bit_cntr[4]:shift_en);
    if (sample_bit) ser_do <= ser_filt_di;
    ser_do_stb <= sample_bit; 
    if (ser_rst) debug0[4:0] <=5'b0;
    else debug0[4:0] <= debug | {ts_stb,start,error,ser_di_d[0],~ser_di_d[0]};
  end
endmodule