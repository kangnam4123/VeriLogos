module prim_gdff (q, d, clk, ena, clr, pre, ald, adt, sclr, sload );
    input d,clk,ena,clr,pre,ald,adt,sclr,sload;
    output q;
    reg q;
    reg clk_pre;
    initial q = 1'b0;
    always@ (clk or clr or pre or ald or adt)
    begin
        if (clr ==  1'b1)
            q <= 1'b0;
        else if (pre == 1'b1)
            q <= 1'b1;
        else if (ald == 1'b1)
            q <= adt;
        else if ((clk == 1'b1) && (clk_pre == 1'b0))
        begin
            if (ena == 1'b1)
            begin
                if (sclr == 1'b1)
                    q <= 1'b0;
                else if (sload == 1'b1)
                    q <= adt;
                else
                    q <= d;
            end
        end
        clk_pre <= clk;
    end
endmodule