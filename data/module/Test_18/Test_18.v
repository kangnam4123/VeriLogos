module Test_18(Pop,Pid);
output Pop,Pid;
reg Pop,Pid;
initial
begin
Pop = 0;
Pid = 0;
Pop = #5 1;
Pid = #3 1;
Pop = #6 0;
Pid = #2 0;
end
endmodule