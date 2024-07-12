module statmath( input statmach_clock, 
                 input  start_stop, 
                 input spilt, 
                 output reg clr, 
                 output reg Time_ce, 
                 output reg enable_lc); 
    localparam [1:0] reset =2'b00, stop =2'b01, normal=2'b10, lock=2'b11;
    reg [1:0] p_state; 
    reg [1:0] n_state = reset; 
    always @ ( start_stop or  spilt or p_state ) begin  
        case(p_state)
            reset:
                case({start_stop,spilt})
                2'b10:n_state <= normal;
                default: n_state <= n_state;
                 endcase
            stop:
                case({start_stop,spilt})
                2'b01:n_state <= reset;
                2'b10:n_state <= normal;
                default: n_state <= n_state;
                endcase
            normal:
                case({start_stop,spilt})
                2'b01:n_state <= lock;
                2'b10:n_state <= stop;
                default: n_state <= n_state;
                endcase
            lock:
                case({start_stop,spilt})
                2'b01:n_state <= normal;
                default: n_state <= n_state;
                endcase
            default: n_state <= reset;             
        endcase 
    end
    always @ (posedge statmach_clock) begin  
        p_state <= n_state;
    end
    always@( p_state)   
         case(p_state)  
               reset: begin
                   clr=1;
                   Time_ce=0;
                   enable_lc=1;
                   end
               stop: begin
                   clr=0;
                   Time_ce=0;
                   enable_lc=1;
                   end
               normal: begin
                   clr=0;
                   Time_ce=1;
                   enable_lc=1;
                   end
               lock: begin
                   clr=0;
                   Time_ce=1;
                   enable_lc=0;
                   end 
           endcase 
endmodule