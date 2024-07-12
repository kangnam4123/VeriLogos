module jt10_adpcmb(
    input           rst_n,
    input           clk,        
    input           cen,        
    input   [3:0]   data,
    input           chon,       
    input           adv,
    input           clr,
    output signed [15:0] pcm
);
localparam stepw = 15, xw=16;
reg signed [xw-1:0] x1, next_x5;
reg [stepw-1:0] step1;
reg [stepw+1:0] next_step3;
assign pcm = x1[xw-1:xw-16];
wire [xw-1:0] limpos = {1'b0, {xw-1{1'b1}}};
wire [xw-1:0] limneg = {1'b1, {xw-1{1'b0}}};
reg  [18:0] d2l;
reg  [xw-1:0] d3,d4;
reg  [3:0]  d2;
reg  [7:0]  step_val;
reg  [22:0] step2l;
always @(*) begin
    casez( d2[3:1] )
        3'b0_??: step_val = 8'd57;
        3'b1_00: step_val = 8'd77;
        3'b1_01: step_val = 8'd102;
        3'b1_10: step_val = 8'd128;
        3'b1_11: step_val = 8'd153;
    endcase
    d2l    = d2 * step1; 
    step2l = step_val * step1; 
end
reg [3:0] data2;
reg sign_data2, sign_data3, sign_data4, sign_data5;
reg [3:0] adv2;
reg need_clr;
wire [3:0] data_use = clr || ~chon ? 4'd0 : data;
always @( posedge clk or negedge rst_n )
    if( ! rst_n ) begin
        x1 <= 'd0; step1 <= 'd127;
        d2 <= 'd0; d3 <= 'd0; d4 <= 'd0;
		  need_clr <= 0;
    end else begin
    if( clr )
		  need_clr <= 1'd1;
	 if(cen) begin
        adv2 <= {1'b0,adv2[3:1]};
		  if( adv ) begin
            d2        <= {data_use[2:0],1'b1};
            sign_data2 <= data_use[3];
            adv2[3] <= 1'b1;
        end
        d3        <= { {xw-16{1'b0}}, d2l[18:3] }; 
        next_step3<= step2l[22:6];
		  sign_data3<=sign_data2;
        d4        <= sign_data3 ? ~d3+1'd1 : d3;
		  sign_data4<=sign_data3;
        next_x5   <= x1+d4;
		  sign_data5<=sign_data4;
        if( chon ) begin 
            if( adv2[0] ) begin
                    if( sign_data5 == x1[xw-1] && (x1[xw-1]!=next_x5[xw-1]) )
                        x1 <= x1[xw-1] ? limneg : limpos;
                    else
                        x1 <= next_x5;
                    if( next_step3 < 127 )
                        step1  <= 15'd127;
                    else if( next_step3 > 24576 )
                        step1  <= 15'd24576;
                    else
                        step1 <= next_step3[14:0];
                end
        end else begin
            x1      <= 'd0;
            step1   <= 'd127;
        end
		  if( need_clr ) begin
            x1      <= 'd0;
            step1   <= 'd127;
            next_step3   <= 'd127;
				d2 <= 'd0; d3 <= 'd0; d4 <= 'd0;
				next_x5 <= 'd0;
				need_clr <= 1'd0;
        end
    end
	 end
endmodule