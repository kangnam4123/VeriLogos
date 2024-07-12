module nfa_accept_samples_generic_hw_add_64ns_64ns_64_16_AddSubnS_2_fadder_f 
#(parameter
    N = 4
)(
    input  [N-1 : 0]  faa,
    input  [N-1 : 0]  fab,
    input  wire  facin,
    output [N-1 : 0]  fas,
    output wire  facout
);
assign {facout, fas} = faa + fab + facin;
endmodule