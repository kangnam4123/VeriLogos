module register_renaming_table #(
		parameter ENTRY_ID = 5'h0
	)(
		input wire iCLOCK,
		input wire inRESET,
		input wire iRESTART_VALID,	
		input wire iROLLBACK_UPDATE_CANDIDATE0_VALID,	
		input wire [4:0] iROLLBACK_UPDATE_CANDIDATE0_LREGNAME,	
		input wire [5:0] iROLLBACK_UPDATE_CANDIDATE0_PREGNAME,	
		input wire iROLLBACK_UPDATE_CANDIDATE1_VALID,		
		input wire [4:0] iROLLBACK_UPDATE_CANDIDATE1_LREGNAME,	
		input wire [5:0] iROLLBACK_UPDATE_CANDIDATE1_PREGNAME,	
		input wire iROLLBACK_UPDATE_CANDIDATE2_VALID,		
		input wire [4:0] iROLLBACK_UPDATE_CANDIDATE2_LREGNAME,	
		input wire [5:0] iROLLBACK_UPDATE_CANDIDATE2_PREGNAME,	
		input wire iROLLBACK_UPDATE_CANDIDATE3_VALID,			
		input wire [4:0] iROLLBACK_UPDATE_CANDIDATE3_LREGNAME,	
		input wire [5:0] iROLLBACK_UPDATE_CANDIDATE3_PREGNAME,
		input wire iLOCK,
		input wire iREGIST_0_VALID,
		input wire [4:0] iREGIST_0_LOGIC_DESTINATION,
		input wire [5:0] iREGIST_0_REGNAME,
		input wire iREGIST_1_VALID,
		input wire [4:0] iREGIST_1_LOGIC_DESTINATION,
		input wire [5:0] iREGIST_1_REGNAME,
		output wire oINFO_VALID,
		output wire [5:0] oINFO_REGNAME,
		output wire [5:0] oINFO_OLD_REGNAME
	);
	reg b_state;
	reg b_valid;				
	reg [5:0] b_regname;
	reg [5:0] bb_regname;
	reg [5:0] b_rollback_point;
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_state <= 1'b0;
			b_valid <= 1'b0;
			b_regname <= {6{1'b0}};
			bb_regname <= {6{1'b0}};
			b_rollback_point <= {6{1'b0}};
		end			
		else begin
			case(b_state)
				1'b0 :	
					begin
						b_state <= 1'b1;
						b_regname <= {1'b0, ENTRY_ID[4:0]};
						bb_regname <= {1'b0, ENTRY_ID[4:0]};
						b_rollback_point <= {1'b0, ENTRY_ID[4:0]};
					end
				default :
					begin
						if(iRESTART_VALID)begin		
								b_regname <= b_rollback_point;
								bb_regname <= b_rollback_point;
						end
						if(iROLLBACK_UPDATE_CANDIDATE3_VALID && iROLLBACK_UPDATE_CANDIDATE3_LREGNAME == ENTRY_ID[4:0])begin	
							b_rollback_point <= iROLLBACK_UPDATE_CANDIDATE3_PREGNAME;
						end
						else if(iROLLBACK_UPDATE_CANDIDATE2_VALID && iROLLBACK_UPDATE_CANDIDATE2_LREGNAME == ENTRY_ID[4:0])begin	
							b_rollback_point <= iROLLBACK_UPDATE_CANDIDATE2_PREGNAME;
						end
						else if(iROLLBACK_UPDATE_CANDIDATE1_VALID && iROLLBACK_UPDATE_CANDIDATE1_LREGNAME == ENTRY_ID[4:0])begin	
							b_rollback_point <= iROLLBACK_UPDATE_CANDIDATE1_PREGNAME;
						end
						else if(iROLLBACK_UPDATE_CANDIDATE0_VALID && iROLLBACK_UPDATE_CANDIDATE0_LREGNAME == ENTRY_ID[4:0])begin	
							b_rollback_point <= iROLLBACK_UPDATE_CANDIDATE0_PREGNAME;
						end
						if(!iLOCK)begin
							bb_regname <= b_regname;
							if(iREGIST_1_VALID && ENTRY_ID[4:0] == iREGIST_1_LOGIC_DESTINATION)begin
								b_valid <= 1'b1;
								b_regname <= iREGIST_1_REGNAME;
							end
							else if(iREGIST_0_VALID && ENTRY_ID[4:0] == iREGIST_0_LOGIC_DESTINATION)begin
								b_valid <= 1'b1;
								b_regname <= iREGIST_0_REGNAME;
							end
						end
					end
			endcase
		end
	end 
	assign oINFO_VALID = b_valid;
	assign oINFO_REGNAME = b_regname;
	assign oINFO_OLD_REGNAME = bb_regname;
endmodule