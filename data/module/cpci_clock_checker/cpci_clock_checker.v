module cpci_clock_checker
   (
    output error,
    output reg [31:0] n_clk_count,
    input [31:0] clk_chk_p_max,    
    input [31:0] clk_chk_n_exp,    
    input [3:0] shift_amount, 
    input reset,  
    input p_clk,   
    input n_clk    
    );
   reg [31:0] min_exp_count;
   reg [31:0] max_exp_count;
   always @(posedge p_clk) begin
      min_exp_count <= clk_chk_n_exp - (1<<shift_amount);
      max_exp_count <= clk_chk_n_exp + (1<<shift_amount);
   end
   reg [31:0] p_count;
   reg [31:0] n_count;
   parameter START = 0, COUNT = 1, WAIT1 = 2, CHECK = 3;
   reg [1:0] state, state_nxt;
   reg go, go_nxt, stop, stop_nxt;
   reg saw_error;
   always @* begin
      state_nxt = state;
      saw_error = 0;
      go_nxt = 0;
      stop_nxt = 0;
      case (state)
         START: begin
            go_nxt = 1;
            state_nxt = COUNT;
         end
         COUNT: begin  
            if (p_count == clk_chk_p_max) begin
               stop_nxt = 1;
               state_nxt = WAIT1;
            end
         end
         WAIT1: begin   
            if (p_count == (clk_chk_p_max + 2))
               state_nxt = CHECK;
         end
         CHECK: begin
            if ((n_count < min_exp_count) ||
                (n_count > max_exp_count)) 
              saw_error = 1;
            state_nxt = START;
          end  
          default: state_nxt = START;
       endcase
    end
   reg [15:0] error_cnt;
   always @(posedge p_clk)
     if (reset)
       error_cnt <= 0;
     else
       if (saw_error) error_cnt <= 10000;
       else if (error_cnt > 0)
	 error_cnt <= error_cnt - 1;
   assign error = (error_cnt != 0);
    always @(posedge p_clk) begin
       go <= go_nxt;
       stop <= stop_nxt;
       state <= reset ? START : state_nxt;
    end
    always @(posedge p_clk)
       if (reset || go) p_count <= 0;
       else p_count <= p_count + 1;
   reg go_n, reset_n, stop_n, run_n;
   always @(posedge n_clk) begin
      go_n <= go;
      reset_n <= reset;
      stop_n <= stop;
   end
   always @(posedge n_clk) 
      if (reset_n || stop_n) run_n <= 0; 
      else if (go_n) run_n <= 1;
   always @(posedge n_clk)
      if (reset_n || go_n) n_count <= 0;
      else if (run_n) n_count <= n_count + 1;
   always @(posedge n_clk) 
      if (reset_n ) n_clk_count <= 'h0; 
      else if (stop_n) n_clk_count <= n_count;
endmodule