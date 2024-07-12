module nfa_accept_samples_generic_hw_add_32ns_32ns_32_8_AddSubnS_0_fadder_f 
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