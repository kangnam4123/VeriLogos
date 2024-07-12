module arriaii_termination(
            rdn,
            rup,
            scanclock,
            scanin,
            scaninmux,
            scanshiftmux,
            terminationuserclear,
            terminationuserclock,
            comparatorprobe,
            scanout,
            terminationclockout,
            terminationcontrolprobe,
            terminationdataout,
            terminationdone,
            terminationselectout 
        );
input  rdn;
input  rup;
input  scanclock;
input  scanin;
input  scaninmux;
input  scanshiftmux;
input  terminationuserclear;
input  terminationuserclock;
output comparatorprobe;
output scanout;
output terminationclockout;
output terminationcontrolprobe;
output terminationdataout;
output terminationdone;
output terminationselectout;
parameter lpm_type = "arriaii_termination";
parameter runtime_control = "false";
integer cal_shift_cycles;
reg reset_oct_reg;
reg terminationdone_tmp;
reg internal_enable_read;
reg internal_clk_enable;
reg terminationclockout_tmp;
reg terminationselectout_tmp ;
reg terminationuserclear_prev;
initial
begin
    terminationclockout_tmp = 1'b0;
    terminationselectout_tmp = 1'b0;
    terminationdone_tmp = 1'b0;
    cal_shift_cycles = 0;
end
always @(terminationuserclock or terminationuserclear)
begin
    if(terminationuserclear == 1'b1 && terminationuserclear_prev == 1'b0)
        begin
            reset_oct_reg = 1'b1;
            terminationdone_tmp = 1'b1;
            cal_shift_cycles = 0;
            terminationselectout_tmp = 1'b0;
            terminationclockout_tmp = 1'b0;
        end
    if(terminationuserclear == 1'b0 && reset_oct_reg == 1'b1)
        begin
            reset_oct_reg = 1'b0;
            internal_enable_read = 1'b1;
        end
    if(internal_enable_read == 1'b1 && terminationuserclock == 1'b0)
        begin
            internal_clk_enable = 1'b1;
            internal_enable_read = 1'b0;
        end
    if(terminationselectout_tmp == 1'b1)
        terminationclockout_tmp = terminationuserclock;
    if(internal_clk_enable == 1'b1 && terminationuserclock == 1'b1)
        begin
            if(cal_shift_cycles == 27)
                terminationdone_tmp = 1'b0;
            else 
            	begin
            		if(cal_shift_cycles == 10)
            			terminationselectout_tmp = 1'b1;
                	cal_shift_cycles = cal_shift_cycles +1;
                end
        end
    if(cal_shift_cycles == 27 && terminationuserclock == 1'b0)
        terminationselectout_tmp = 1'b0;
        if(terminationdone_tmp == 1'b0)
            begin
                cal_shift_cycles = 0;
                internal_clk_enable = 1'b0;
            end
        terminationuserclear_prev = terminationuserclear;
end
assign terminationdone = terminationdone_tmp;
assign terminationclockout = terminationclockout_tmp;
assign terminationselectout = terminationselectout_tmp;
endmodule