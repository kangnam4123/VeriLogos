module Debouncer #(parameter DEFAULT_VALUE=1'b0)
(
    input wire clock,
    input wire reset_n,
    input wire button,
    output reg debounced_button,
    output reg changed
);
    localparam N = 21;
    reg [N-1:0] counter;
    always @(posedge clock or negedge reset_n) begin
        if (!reset_n) begin
            debounced_button <= DEFAULT_VALUE;
            counter <= 1'b0;
            changed <= 1'b0;
        end else begin
            changed <= 1'b0;
            if (button == debounced_button) begin
                counter <= {N{1'b1}};
            end else begin
                if (counter == 0) begin
                    debounced_button <= button;
                    counter <= {N{1'b1}};
                    changed <= 1'b1;
                end else begin
                    counter <= counter - 1'b1;
                end
            end
        end
    end
endmodule