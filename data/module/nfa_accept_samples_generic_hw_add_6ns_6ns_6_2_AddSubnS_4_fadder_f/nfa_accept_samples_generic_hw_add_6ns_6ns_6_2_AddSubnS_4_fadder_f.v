module nfa_accept_samples_generic_hw_add_6ns_6ns_6_2_AddSubnS_4_fadder_f 
#(parameter
    N = 3
)(
    input  [N-1 : 0]  faa,
    input  [N-1 : 0]  fab,
    input  wire  facin,
    output [N-1 : 0]  fas,
    output wire  facout
);
assign {facout, fas} = faa + fab + facin;
endmodule