module acc_vadd (
        ap_clk,
        ap_rst_n,
        sI1_TDATA,
        sI1_TVALID,
        sI1_TREADY,
        sI2_TDATA,
        sI2_TVALID,
        sI2_TREADY,
        mO1_TDATA,
        mO1_TVALID,
        mO1_TREADY
);
parameter    ap_const_logic_1 = 1'b1;
parameter    ap_const_logic_0 = 1'b0;
parameter    ap_ST_st1_fsm_0 = 1'b0;
parameter    ap_true = 1'b1;
input   ap_clk;
input   ap_rst_n;
input  [31:0] sI1_TDATA;
input   sI1_TVALID;
output   sI1_TREADY;
input  [31:0] sI2_TDATA;
input   sI2_TVALID;
output   sI2_TREADY;
output  [31:0] mO1_TDATA;
output   mO1_TVALID;
input   mO1_TREADY;
reg sI1_TREADY;
reg sI2_TREADY;
reg mO1_TVALID;
reg   [0:0] ap_CS_fsm = 1'b0;
reg    ap_sig_bdd_23;
reg    ap_sig_ioackin_mO1_TREADY;
reg    ap_reg_ioackin_mO1_TREADY = 1'b0;
reg   [0:0] ap_NS_fsm;
reg    ap_sig_bdd_48;
always @ (posedge ap_clk)
begin : ap_ret_ap_CS_fsm
    if (ap_rst_n == 1'b0) begin
        ap_CS_fsm <= ap_ST_st1_fsm_0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end
always @ (posedge ap_clk)
begin : ap_ret_ap_reg_ioackin_mO1_TREADY
    if (ap_rst_n == 1'b0) begin
        ap_reg_ioackin_mO1_TREADY <= ap_const_logic_0;
    end else begin
        if ((ap_ST_st1_fsm_0 == ap_CS_fsm)) begin
            if (~(ap_sig_bdd_23 | (ap_const_logic_0 == ap_sig_ioackin_mO1_TREADY))) begin
                ap_reg_ioackin_mO1_TREADY <= ap_const_logic_0;
            end else if (ap_sig_bdd_48) begin
                ap_reg_ioackin_mO1_TREADY <= ap_const_logic_1;
            end
        end
    end
end
always @ (mO1_TREADY or ap_reg_ioackin_mO1_TREADY)
begin
    if ((ap_const_logic_0 == ap_reg_ioackin_mO1_TREADY)) begin
        ap_sig_ioackin_mO1_TREADY = mO1_TREADY;
    end else begin
        ap_sig_ioackin_mO1_TREADY = ap_const_logic_1;
    end
end
always @ (ap_CS_fsm or ap_sig_bdd_23 or ap_reg_ioackin_mO1_TREADY)
begin
    if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~ap_sig_bdd_23 & (ap_const_logic_0 == ap_reg_ioackin_mO1_TREADY))) begin
        mO1_TVALID = ap_const_logic_1;
    end else begin
        mO1_TVALID = ap_const_logic_0;
    end
end
always @ (ap_CS_fsm or ap_sig_bdd_23 or ap_sig_ioackin_mO1_TREADY)
begin
    if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~(ap_sig_bdd_23 | (ap_const_logic_0 == ap_sig_ioackin_mO1_TREADY)))) begin
        sI1_TREADY = ap_const_logic_1;
    end else begin
        sI1_TREADY = ap_const_logic_0;
    end
end
always @ (ap_CS_fsm or ap_sig_bdd_23 or ap_sig_ioackin_mO1_TREADY)
begin
    if (((ap_ST_st1_fsm_0 == ap_CS_fsm) & ~(ap_sig_bdd_23 | (ap_const_logic_0 == ap_sig_ioackin_mO1_TREADY)))) begin
        sI2_TREADY = ap_const_logic_1;
    end else begin
        sI2_TREADY = ap_const_logic_0;
    end
end
always @ (ap_CS_fsm or ap_sig_bdd_23 or ap_sig_ioackin_mO1_TREADY)
begin
    case (ap_CS_fsm)
        ap_ST_st1_fsm_0 : 
        begin
            ap_NS_fsm = ap_ST_st1_fsm_0;
        end
        default : 
        begin
            ap_NS_fsm = 'bx;
        end
    endcase
end
always @ (sI1_TVALID or sI2_TVALID)
begin
    ap_sig_bdd_23 = ((sI1_TVALID == ap_const_logic_0) | (sI2_TVALID == ap_const_logic_0));
end
always @ (mO1_TREADY or ap_sig_bdd_23)
begin
    ap_sig_bdd_48 = (~ap_sig_bdd_23 & (ap_const_logic_1 == mO1_TREADY));
end
assign mO1_TDATA = (sI2_TDATA + sI1_TDATA);
endmodule