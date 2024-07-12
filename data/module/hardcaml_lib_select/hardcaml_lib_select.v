module hardcaml_lib_select 
#(
    parameter b=1,
    parameter h=0,
    parameter l=0
) 
(
    input [b-1:0] i,
    output [h-l:0] o
);
    assign o=i[h:l];
endmodule