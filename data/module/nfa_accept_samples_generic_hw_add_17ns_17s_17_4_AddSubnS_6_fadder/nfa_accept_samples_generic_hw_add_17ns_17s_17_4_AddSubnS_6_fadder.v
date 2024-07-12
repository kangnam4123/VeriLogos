module nfa_accept_samples_generic_hw_add_17ns_17s_17_4_AddSubnS_6_fadder 
#(parameter
    N = 5
)(
    input  [N-1 : 0]  faa,
    input  [N-1 : 0]  fab,
    input  wire  facin,
    output [N-1 : 0]  fas,
    output wire  facout
);
assign {facout, fas} = faa + fab + facin;
endmodule