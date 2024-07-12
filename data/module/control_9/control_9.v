module control_9 (clk, cEnter, cEne, cDelete, cCounter, cNum, new, reset, complete, enter, delete, add, load, addEnhe, change, virgul, changeVirgul);
input clk;
input enter; 
input virgul;
input cEne, cEnter;
input cDelete;
input cCounter;
input new;
input reset;
input cNum;
output reg complete;
output reg delete;
output reg add;
output reg load;
output reg addEnhe;
output reg change;
output reg changeVirgul;
reg [2:0] next_state;
parameter init=3'b000, new_data=3'b001, Add=3'b010, Delete=3'b011, ChangeVirgul=3'b100, AddEnhe=3'b101, Enter=3'b110, effect=3'b111;
always @( negedge clk )
	begin
	if (reset) next_state<=init;
	else 
	case (next_state)
		init: 	next_state<=new_data;
		new_data: begin
		if (cNum==1'b1 & enter==1'b1) next_state<=effect;
		else if(cEnter==1'b1) next_state<=Enter; 
			else if((new==1'b0 | cCounter==1'b1) |  (cNum==1'b0 & enter==1'b1)) next_state<=new_data; 
				    else if (virgul==1'b1 & cEne==0) next_state<=ChangeVirgul; 
						else if((cDelete==1'b1 | (cEne==1'b1 & virgul==1'b1))) next_state<=Delete; 
				          		else next_state<=Add; 
		end 	
		Add: 	next_state<=new_data;
		Delete: begin 
		if (cEne==1'b1 & virgul==1) next_state<=AddEnhe;
		else    next_state<=new_data;
		end
		AddEnhe:    next_state<=new_data;
		Enter:      next_state<=new_data;
		effect:     next_state<=init;
		default:    next_state<=new_data;
	endcase		
	end 
always @( next_state or cEne or virgul)
	begin
	case (next_state)
		init: begin
			complete=1'b0;
			delete=1'b0;
			add=1'b0;
			load=1'b1;
			addEnhe=1'b0;
			change=1'b0;
			changeVirgul=1'b0;			
		end	
		new_data: begin
			complete=1'b0;
			delete=1'b0;
			add=1'b0;
			load=1'b0;
			addEnhe=1'b0;
			change=1'b0;		
			changeVirgul=1'b0;			
		end		
		Add: begin 
			complete=1'b0;
			delete=1'b0;
			add=1'b1;
			load=1'b0;
			addEnhe=1'b0;
			change=1'b1;
			changeVirgul=1'b0;			
		end
		Delete: begin
			  complete=1'b0;
			  delete=1'b1;
			  add=1'b0;
			  load=1'b0;
			  addEnhe=1'b0;
			  change=1'b1;
	    		  changeVirgul=1'b0;			
		end
		ChangeVirgul: begin 
				complete=1'b0;
				delete=1'b0;
				add=1'b1;
				load=1'b0;
				addEnhe=1'b0;
				change=1'b1;		
				changeVirgul=1'b1;
		end
		AddEnhe: begin    				
			complete=1'b0;
			delete=1'b0;
			add=1'b1;
			load=1'b0;
			addEnhe=1'b1;
			change=1'b1;
			changeVirgul=1'b0;			
		end
		Enter: begin 
			complete=1'b0;
			delete=1'b0;
			add=1'b0;
			load=1'b0;
			addEnhe=1'b0;
			change=1'b1;
			changeVirgul=1'b0;			
		end
		effect: begin 
			complete=1'b1;
			delete=1'b0;
			add=1'b1;
			load=1'b0;
			addEnhe=1'b0;
			change=1'b1;
			changeVirgul=1'b0;			
		end		
		default: begin
			complete=1'b0;
			delete=1'b0;
			add=1'b0;
			load=1'b0;
			addEnhe=1'b0;
			change=1'b0;
			changeVirgul=1'b0;			
		end
	endcase		
	end 
endmodule