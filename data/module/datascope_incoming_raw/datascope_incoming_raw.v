module  datascope_incoming_raw#(
    parameter ADDRESS_BITS =         10, 
    parameter DATASCOPE_POST_MEAS =  16  
)(
    input                     clk, 
    input               [1:0] charisk,
    input              [15:0] rxdata,
    input                     realign,
    input                     comma,
    input                     aligned,
    input               [1:0] not_in_table,
    input               [1:0] disp_err,
    input                     datascope_arm,
    output                    datascope_clk,
    output [ADDRESS_BITS-1:0] datascope_waddr,
    output                    datascope_we,
    output reg         [31:0] datascope_di,
    input                     datascope_trig 
);
    reg [ADDRESS_BITS - 1:0 ] datascope_post_cntr;
    reg [ADDRESS_BITS - 1:0 ] datascope_waddr_r;
    reg                 [2:0] datascope_start_r;
    wire                      datascope_event;
    reg                       datascope_event_r;
    reg                       datascope_run;
    reg                       datascope_post_run;
    wire                      datascope_stop =  (DATASCOPE_POST_MEAS == 0) ? datascope_event: (datascope_post_cntr == 0);
    reg                 [2:0] datascope_trig_r;      
    assign datascope_waddr =  datascope_waddr_r;
    assign datascope_we =     datascope_run;
    assign datascope_clk =    clk;
    assign datascope_event = (not_in_table) || (disp_err) || realign || (datascope_trig_r[1] && !datascope_trig_r[2]) ;
    always @ (posedge clk) begin
        datascope_trig_r <= {datascope_trig_r[1:0], datascope_trig};
        datascope_start_r <= {datascope_start_r[1:0],datascope_arm};
        datascope_event_r <=datascope_event;
        if      (!datascope_start_r[1]) datascope_run <= 0;
        else if (!datascope_start_r[2]) datascope_run <= 1;
        else if (datascope_stop)        datascope_run <= 0; 
        if      (!datascope_run)        datascope_post_run <= 0;
        else if (datascope_event_r)     datascope_post_run <= 1;
        if (!datascope_post_run) datascope_post_cntr <= DATASCOPE_POST_MEAS;
        else                     datascope_post_cntr <= datascope_post_cntr  - 1;  
        if (!datascope_start_r[1] && datascope_start_r[0]) datascope_waddr_r <= 0; 
        else if (datascope_run)                            datascope_waddr_r <=  datascope_waddr_r + 1;
        if (datascope_start_r[1]) datascope_di <= {
                                   6'b0,
                                   realign,           
                                   comma,             
                                   1'b0,              
                                   aligned,           
                                   not_in_table[1:0], 
                                   disp_err[1:0],     
                                   charisk[1:0],      
                                   rxdata[15:0]};     
    end
endmodule