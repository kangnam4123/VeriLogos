module control_leer(clk,load_e,efect0,add_1,add_2,reset_1,reset_2,top_1,top_2,load_crt,done_crt,new_col,reset_new,load_led,rst,run_efect);
	input clk;
	input load_e;
	input efect0;
	input top_1;
	input top_2; 
	input done_crt;
	input new_col;
	input run_efect;
	output reg rst;
	output reg add_1;
	output reg add_2;
	output reg reset_1;
	output reg reset_2;
	output reg load_crt;
	output reg reset_new;
	output reg load_led;				
	reg [6:0] current_state;
	reg [6:0] next_state;
	parameter start=7'b0000000, state_1=7'b0000001, state_2=7'b0000010, state_3=7'b0000011, state_4=7'b0000100, state_5=7'b0000101, state_6=7'b0000110,state_3f=7'b0000111; 
	always @(top_1 or run_efect or load_e or efect0 or  top_2 or done_crt or new_col or current_state)begin
		case(current_state)
     		start: 	begin			
						add_1= 1'b0 ;
						add_2= 1'b0;
						reset_1= 1'b1;
						reset_2= 1'b1;
						load_crt= 1'b0;
						reset_new= 1'b1;
						load_led= 1'b0;
						rst=1'b1;
						if ((load_e==1'b1 || efect0==1'b1) && run_efect==1'b1) next_state<=state_1;
						else next_state<=start;
					end
			state_1:	begin 		
						add_1= 1'b0 ;
						add_2= 1'b0;
						reset_1= 1'b0;
						reset_2= 1'b0;
						load_crt= 1'b1;
						reset_new= 1'b1;
						load_led= 1'b0;
						rst=1'b0;
						next_state<=state_2;
					end
				state_2:	begin		
						add_1= 1'b0 ;
						add_2= 1'b0;
						reset_1= 1'b0;
						reset_2= 1'b0;
						load_crt= 1'b0;
						reset_new= 1'b0;
						load_led= 1'b0;
						rst=1'b0;
						if(efect0==1'b1) begin
						if (new_col == 1'b1) next_state<=state_3f;
						else if (done_crt==1'b1)next_state<=state_1;
						else next_state<=state_2;
						end else begin
						if (new_col == 1'b1) next_state<=state_3;
						else if (done_crt==1'b1)next_state<=state_4;
						else next_state<=state_2;
						end
					end
			state_3:	begin		
						add_1= 1'b0 ;
						add_2= 1'b0;
						reset_1= 1'b0;
						reset_2= 1'b0;
						load_crt= 1'b0;
						reset_new= 1'b1;
						load_led= 1'b1;
						rst=1'b0;
						if (done_crt==1'b1)next_state<=state_4;
						else next_state<=state_2;
					end
			state_3f:	begin		
						add_1= 1'b0 ;
						add_2= 1'b0;
						reset_1= 1'b1;
						reset_2= 1'b1;
						load_crt= 1'b0;
						reset_new= 1'b1;
						load_led= 1'b1;
						rst=1'b0;
						if (done_crt==1'b1)next_state<=state_4;
						else next_state<=state_2;
					end
			state_4:	begin		
						add_1= 1'b1;
						add_2= 1'b0;
						reset_1= 1'b0;
						reset_2= 1'b0;
						load_crt= 1'b0;
						reset_new= 1'b0;
						load_led= 1'b0;
						rst=1'b0;
						if (top_1==1'b1)next_state<=state_5;
						else next_state<=state_1;
					end
			state_5:	begin		
						add_1= 1'b0 ;
						add_2= 1'b1;
						reset_1= 1'b1;	
						reset_2= 1'b0;
						load_crt= 1'b0;			
						reset_new= 1'b0;		
						load_led= 1'b0;
						rst=1'b0;
						next_state<=state_1;
					end
			state_6:	begin		
						add_1= 1'b0 ;
						add_2= 1'b0;
						reset_1= 1'b0;
						reset_2= 1'b1;
						load_crt= 1'b0;
						reset_new= 1'b0;
						load_led= 1'b0;
						rst=1'b0;
						next_state<=state_1;
					end
			default:
					begin
						add_1= 1'b0 ;
						add_2= 1'b0;
						reset_1= 1'b0;
						reset_2= 1'b0;
						load_crt= 1'b0;
						reset_new= 1'b0;
						load_led= 1'b0;
						rst=1'b0;
						next_state<=start;
					end
		endcase
	end	
	always @(negedge clk) begin
	    current_state<=next_state;	
	end
endmodule