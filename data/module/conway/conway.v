module conway #(
    parameter WIDTH = 32,
    parameter HEIGHT = 32
)(
    in_states,
    out_states
);
    input [WIDTH*HEIGHT-1:0] in_states;
    output [WIDTH*HEIGHT-1:0] out_states;
    genvar r, c;
    generate 
        for (c = 0; c < WIDTH; c=c+1) begin
            assign out_states[c] = 0;
            assign out_states[(HEIGHT-1)*WIDTH + c] = 0;
        end
        for (r = 1; r < HEIGHT-1; r=r+1) begin
            assign out_states[r * WIDTH] = 0;
            assign out_states[(r + 1) * WIDTH - 1] = 0;
            for (c = 1; c < WIDTH-1; c=c+1) begin
                wire cur_state_i;
                wire [4:0] sum_i;
                assign cur_state_i = in_states[r * WIDTH + c];
                assign sum_i = in_states[r * WIDTH + c-WIDTH-1] + in_states[r * WIDTH + c-WIDTH] + in_states[r * WIDTH + c-WIDTH+1] + in_states[r * WIDTH + c-1] + in_states[r * WIDTH + c+1] + in_states[r * WIDTH + c+WIDTH-1] + in_states[r * WIDTH + c+WIDTH] + in_states[r * WIDTH + c+WIDTH+1];
                wire eq2_i, eq3_i;
                assign eq2_i = (sum_i == 2);
                assign eq3_i = (sum_i == 3);
                wire next_state_i;
                assign next_state_i = (cur_state_i & (eq2_i | eq3_i)) | (~cur_state_i & eq3_i);
                assign out_states[r * WIDTH + c] = next_state_i;
            end
        end
    endgenerate
endmodule