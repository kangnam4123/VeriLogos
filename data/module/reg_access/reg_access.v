module reg_access (
		input clk,
		input reset,
		input work_bit,
		output reg req_enb,
		output reg [1:0] req_op,
		output reg [4:0]phy_addr,
		output reg [4:0]reg_addr,
		output reg [3:0]port_link,
		input  [15:0]data_sta,
		input  sta_enb
);
reg [31:0]cnt;
reg [4:0]state;
reg timer;
parameter	  	idle      =4'd0,
					read_port0=4'h1,
					send_data0=4'h2,
					read_port1=4'd3,
					key_data1 =4'd4,
					send_data1=4'd5,
					read_port2=4'd6,
					key_data2 =4'd7,
					send_data2=4'd8,
					read_port3=4'd9,
					key_data3 =4'hA,
					send_data3=4'hB;
always@(posedge clk,negedge reset)begin
   if(!reset)begin
					cnt<=32'b0;
					timer<=1'b0;
					end
	else if(cnt<32'd1250000)begin	
				cnt<=cnt+1'b1;
				timer<=1'b0;
		  end
	else begin
			cnt<=32'b0;
			timer<=1'b1;
		  end
 end 
always@(posedge clk,negedge reset)begin
	if(!reset)begin
					req_enb<=1'b0;
					req_op<=2'b10;
					phy_addr<=5'b0;
					port_link<=4'b0;
					state<=idle;
					end
	else begin
			case(state) 
				 idle:  if(timer==1'b1&&work_bit==1'b0)begin
							state<=read_port0;
							end
							else begin
							state<=idle;
							end
		   read_port0: begin
							req_enb<=1'b1;
							req_op<=2'b10;
							phy_addr<=5'd0;
							reg_addr<=5'd1;
							if(work_bit==1'b1)begin
								req_enb<=1'b0;
								state<=send_data0;
							end
							else begin
							state<=read_port0;
							end
						end
		   send_data0:   begin
							   if(sta_enb==1'b1)begin
								port_link[0]<=data_sta[2];
								req_enb<=1'b0;
								state<=read_port1;
								end
								else begin
								state<=send_data0;
								end								
							end
		   read_port1: 	if(work_bit==1'b0)begin
								req_enb<=1'b1;
								req_op<=2'b10;
								phy_addr<=5'd1;
								reg_addr<=5'd1;
								state<=key_data1;
								end
						      else begin
								state<=read_port1;
							   end
			key_data1:	   if(work_bit==1'b1)begin
								req_enb<=1'b0;
								state<=send_data1;
								end
						      else begin
							   state<=key_data1;
						      end	
		   send_data1:    begin
								if(sta_enb==1'b1)begin
									port_link[1]<=data_sta[2];
									req_enb<=1'b0;
									state<=read_port2;
									end
								else begin
									state<=send_data1;
									end
								end
	       read_port2:		if(work_bit==1'b0)begin
							       req_enb<=1'b1;
							       req_op<=2'b10;
						          phy_addr<=5'd2;
							       reg_addr<=5'd1;
							       state<=key_data2;
							       end
							       else begin
							       state<=read_port2;
							       end	
			key_data2:	   if(work_bit==1'b1)begin
								req_enb<=1'b0;
								state<=send_data2;
								end
						      else begin
							   state<=key_data2;
						      end	
		   send_data2:    begin
								   if(sta_enb==1'b1)begin
									port_link[2]<=data_sta[2];
									req_enb<=1'b0;
									state<=read_port3;
									end
									else begin
									state<=send_data2;
									end
						      end
		   read_port3:	    begin
							    if(work_bit==1'b0)begin
							    req_enb<=1'b1;
							    req_op<=2'b10;
						       phy_addr<=5'd3;
							    reg_addr<=5'd1;
							    state<=key_data3;
							    end
							    else begin
							    state<=read_port3;
							    end
						       end
		    key_data3:	    if(work_bit==1'b1)begin
								  req_enb<=1'b0;
								  state<=send_data3;
						       end
						       else begin
							    state<=key_data3;
						       end	
		   send_data3:	    if(sta_enb==1'b1)begin
							  	 port_link[3]<=data_sta[2];
							    req_enb<=1'b0;
								 state<=idle;
						       end
						       else begin
								 state<=send_data3;
						       end					 
			default:		    state<=idle;		
			endcase
		end
		end
endmodule