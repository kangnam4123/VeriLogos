module IRRecive(
	input	 clk,
	input  ir,
	output reg [7:0]Code,
	output reg press
);
reg [2:0]IR_reg;
initial IR_reg = 3'b0;
always @ (posedge clk) 			
begin
	IR_reg[0] <= ir;
	IR_reg[1] <= IR_reg[0];
	IR_reg[2] <= IR_reg[1];
end
wire IR_pos = (IR_reg[0]==1'b1) & (IR_reg[1]==1'b0);
wire IR_pos2= (IR_reg[1]==1'b1) & (IR_reg[2]==1'b0);
wire IR_neg = (IR_reg[0]==1'b0) & (IR_reg[1]==1'b1);
wire IR_neg2= (IR_reg[1]==1'b0) & (IR_reg[2]==1'b1);
parameter ST_START_L = 3'b000, ST_CODE_P = 3'b001 , ST_VALUE_P = 3'b010;
parameter ST_START_H = 3'b011, ST_CODE_N = 3'b100 , ST_VALUE_N = 3'b101;
parameter START_H = 16'd4096;	
parameter START_L = 16'd8192;	
parameter CODE_0 	= 16'd512  + 16'd512 ;	
parameter CODE_1 	= 16'd1536 + 16'd512 ;	
reg   [2:0]state;		
reg	[15:0]cnt_h;
reg	[15:0]cnt_l;
reg 	[31:0]IR_Value;
reg	[15:0]cnt_val;
reg   Flag_LVL;
reg   Flag_HVL;
always @ (posedge clk or posedge ir)
begin
		if(ir)									
			cnt_l <= 16'b0;
		else if(cnt_l[15] & cnt_l[10])	
			cnt_l 	<= 16'b0;
		else
			cnt_l <= cnt_l + 1'b1;			
end
always @ (negedge clk)
	begin
		if(cnt_l == START_L)
			Flag_LVL <= 1'b1;
		else if(IR_pos2)
			Flag_LVL <= 1'b0;
	end
always @ (posedge clk or negedge ir)
begin
		if(!ir)								
			cnt_h <= 16'b0;					
		else if(cnt_h[15] & cnt_h[10])	
			cnt_h <= 16'b0;
		else
			cnt_h <= cnt_h + 1'b1;			
end
always @ (negedge clk)
	begin
		if(cnt_h == START_H)
				Flag_HVL <=1;
		else if(IR_neg2)
				Flag_HVL <= 1'b0;
	end
reg [15:0]IR_code;
always @ (posedge clk or posedge IR_neg) 			
begin
			if(IR_neg)
				begin
					cnt_val 	<= 16'b0;				
				end
			else if(state == ST_CODE_P)
			begin
				if(cnt_val == CODE_0)
					begin
					IR_code	<= CODE_0;
					cnt_val <= cnt_val + 1'b1;				
					end
				else if(cnt_val == CODE_1)
					begin		
					IR_code	<= CODE_1;			
					cnt_val <= cnt_val + 1'b1;				
					end
				else
					cnt_val <= cnt_val + 1'b1;	
			end
end
wire fault = cnt_h[15] | cnt_l[15];		
reg [5:0]cnt_num;
initial cnt_num = 6'b0;
reg [19:0]cnt_press;
always @ (posedge clk) 			
begin
 if(press == 1'b1)
	cnt_press <= cnt_press + 1;
 if(cnt_press == 20'd100000)
	begin
		press <= 0;
		cnt_press <=0;
	end
 case(state)
 ST_START_L:
	begin
	cnt_num  <=  6'b0;
		if((IR_pos == 1'b1) & (Flag_LVL==1'b1))
			begin
				state <= ST_START_H;
			end
		else if(fault)
			state <= ST_START_L;
	end
 ST_START_H : 
 	begin
	cnt_num  <=  6'b0;	
		if((IR_neg == 1'b1) & (Flag_HVL==1'b1))
			begin
				state <= ST_CODE_P;
			end
		else if(fault)
			state <= ST_START_L;
	end			
 ST_CODE_P : 
	begin
		if((IR_neg)&(IR_code == CODE_1))
			begin
				cnt_num = cnt_num + 1'b1;
				IR_Value <= {IR_Value[30:0],1'b1};
			end
		else	if((IR_neg)&(IR_code == CODE_0))
			begin
				cnt_num = cnt_num + 1'b1;
				IR_Value <= {IR_Value[30:0],1'b0};
			end
		else if(cnt_num==6'd32)
			begin
				press    <=  1'b1;
				cnt_num  <=  6'b0;
				state 	<=  ST_START_L;
				Code 		<=  {IR_Value[8],IR_Value[9],IR_Value[10],IR_Value[11],IR_Value[12],IR_Value[13],IR_Value[14],IR_Value[15]};
			end
	end
   default : state <=  ST_START_L;
endcase
end
endmodule