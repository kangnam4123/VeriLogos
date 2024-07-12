module Test_47 (
    input input_signal,
    output output_signal
    );
   wire    some_signal[1:0][1:0];
   assign some_signal[0][0] = input_signal;
   assign some_signal[0][1] = some_signal[0][0];
   assign some_signal[1][0] = some_signal[0][1];
   assign some_signal[1][1] = some_signal[1][0];
   assign output_signal = some_signal[1][1];
endmodule