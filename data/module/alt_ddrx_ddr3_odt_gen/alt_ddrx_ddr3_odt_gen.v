module alt_ddrx_ddr3_odt_gen
    # (parameter
        DWIDTH_RATIO            =   2,
        TCL_BUS_WIDTH           =   4,
        CAS_WR_LAT_BUS_WIDTH    =   4
    )
    (
        ctl_clk,
        ctl_reset_n,
        mem_tcl,
        mem_cas_wr_lat,
        do_write,
        do_read,
        int_odt_l,
        int_odt_h
    );
    input   ctl_clk;
    input   ctl_reset_n;
    input   [TCL_BUS_WIDTH-1:0]         mem_tcl;
    input   [CAS_WR_LAT_BUS_WIDTH-1:0]  mem_cas_wr_lat;
    input   do_write;
    input   do_read;
    output  int_odt_l;
    output  int_odt_h;
    wire    do_write;
    wire    int_do_read;
    reg     do_read_r;
    wire [3:0]  diff_unreg; 
    reg  [3:0]  diff;
    reg     int_odt_l_int;
    reg     int_odt_l_int_r;
    wire    int_odt_l;
    wire    int_odt_h;
    reg [2:0]   doing_write_count;
    reg [2:0]   doing_read_count;
    assign  diff_unreg  =   mem_tcl - mem_cas_wr_lat;
    assign  int_do_read =   (diff > 1) ? do_read_r : do_read;
    generate
        if (DWIDTH_RATIO == 2) 
            begin
                assign  int_odt_h   = int_odt_l_int;
                assign  int_odt_l   = int_odt_l_int;
            end
        else 
            begin
                assign  int_odt_h   = int_odt_l_int | do_write | (int_do_read & ~|diff);
                assign  int_odt_l   = int_odt_l_int | int_odt_l_int_r;
            end
    endgenerate
    always @(posedge ctl_clk, negedge ctl_reset_n)
        begin
            if (!ctl_reset_n)
                diff    <=  0;
            else
                diff    <=  diff_unreg;
        end
    always @(posedge ctl_clk, negedge ctl_reset_n)
        begin
            if (!ctl_reset_n)
                do_read_r   <=  0;
            else
                do_read_r   <=  do_read;
        end
    always @(posedge ctl_clk, negedge ctl_reset_n)
        begin
            if (!ctl_reset_n)
                doing_write_count   <=  0;
            else
                if (do_write)
                    doing_write_count   <=  1;
                else if ((DWIDTH_RATIO == 2 && doing_write_count == 4) || (DWIDTH_RATIO != 2 && doing_write_count == 1))
                    doing_write_count   <=  0;
                else if (doing_write_count > 0)
                    doing_write_count   <=  doing_write_count + 1'b1;
        end
    always @(posedge ctl_clk, negedge ctl_reset_n)
        begin
            if (!ctl_reset_n)
                doing_read_count   <=  0;
            else
                if (int_do_read)
                    doing_read_count   <=  1;
                else if ((DWIDTH_RATIO == 2 && doing_read_count == 4) || (DWIDTH_RATIO != 2 && doing_read_count == 1))
                    doing_read_count   <=  0;
                else if (doing_read_count > 0)
                    doing_read_count   <=  doing_read_count + 1'b1;
        end
    always @(posedge ctl_clk, negedge ctl_reset_n)
        begin
            if (!ctl_reset_n)
                int_odt_l_int         <=  1'b0;
            else
                if (do_write || int_do_read)
                    int_odt_l_int         <=  1'b1;
                else if (doing_write_count > 0 || doing_read_count > 0)
                    int_odt_l_int         <=  1'b1;
                else
                    int_odt_l_int         <=  1'b0;
        end
    always @(posedge ctl_clk, negedge ctl_reset_n)
        begin
            if (!ctl_reset_n)
                int_odt_l_int_r         <=  1'b0;
            else
                int_odt_l_int_r         <=  int_odt_l_int;
        end
endmodule