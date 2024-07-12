module gtx_comma_align(
    input   wire            rst,
    input   wire            clk,
    input   wire    [19:0]  indata,
    output  wire    [19:0]  outdata,
    output  wire            comma,
    output  wire            realign
);
reg     [19:0] indata_r;
wire    [38:0] window;
always @ (posedge clk)
    indata_r <= indata;
assign  window = {indata[18:0], indata_r};
wire    [19:0]  subwindow [19:0];
wire    [19:0]  comma_match;
wire    [19:0]  comma_match_p;
reg     [19:0]  aligned_data;
reg     [19:0]  comma_match_prev;
wire            comma_detected;
wire    [19:0]  comma_p = 20'b10101010100101111100;
wire    [19:0]  comma_n = 20'b10101010101010000011;
genvar ii;
generate
    for (ii = 0; ii < 20; ii = ii + 1)
    begin: look_for_comma
        assign  subwindow[ii]   = window[ii + 19:ii];
        assign  comma_match_p[ii] = subwindow[ii] == comma_p;
        assign  comma_match[ii]   = comma_match_p[ii] | subwindow[ii] == comma_n;
    end
endgenerate
assign  comma_detected = |comma_match;
always @ (posedge clk)
    comma_match_prev <= rst ? 20'h1 : comma_detected ? comma_match : comma_match_prev;
wire    [19:0]  shifted_window;
wire    [19:0]  ored_subwindow [19:0];
wire    [19:0]  ored_subwindow_comdet [19:0];
assign  ored_subwindow_comdet[0] = {20{comma_match_p[0]}} & comma_p | {20{~comma_match_p[0] & comma_match[0]}} & comma_n;
assign  ored_subwindow[0]       = {20{comma_match_prev[0]}} & subwindow[0];
generate
    for (ii = 1; ii < 20; ii = ii + 1)
    begin: or_all_possible_windows
        assign ored_subwindow_comdet[ii] = {20{comma_match_p[ii]}} & comma_p | {20{~comma_match_p[ii] & comma_match[ii]}} & comma_n | ored_subwindow_comdet[ii-1];  
        assign ored_subwindow[ii]        = {20{comma_match_prev[ii]}} & subwindow[ii] | ored_subwindow[ii-1];                                                       
    end
endgenerate
assign  shifted_window = comma_detected ? ored_subwindow_comdet[19] : ored_subwindow[19];
always @ (posedge clk)
    aligned_data <= shifted_window[19:0];
assign  comma   = comma_detected;
assign  realign = comma_detected & |(comma_match_prev ^ comma_match);
assign  outdata = aligned_data;
endmodule