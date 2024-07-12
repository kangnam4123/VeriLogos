module mig_7series_v2_3_ecc_gen
  #(
    parameter CODE_WIDTH        = 72,
    parameter ECC_WIDTH         = 8,
    parameter DATA_WIDTH        = 64
   )
   (
  h_rows
  );
  function integer factorial (input integer i);
    integer index;
    if (i == 1) factorial = 1;
    else begin
      factorial = 1;
      for (index=2; index<=i; index=index+1)
        factorial = factorial * index;
    end
  endfunction 
  function integer combos (input integer n, k);
    combos = factorial(n)/(factorial(k)*factorial(n-k));
  endfunction 
  function [ECC_WIDTH-1:0] next_combo (input [ECC_WIDTH-1:0] i);
    integer index;
    integer dump_index;
    reg seen0;
    reg trig1;
    reg [ECC_WIDTH-1:0] ones;
    begin
      seen0 = 1'b0;
      trig1 = 1'b0;
      ones = 0;
      for (index=0; index<ECC_WIDTH; index=index+1)
        begin
          if ((&i == 1'bx) || trig1) next_combo[index] = i[index];
          else begin
            next_combo[index] = 1'b0;
            ones = ones + i[index];
            if (i[index] && seen0) begin
              trig1 = 1'b1;
              for (dump_index=index-1; dump_index>=0;dump_index=dump_index-1)
                if (dump_index>=index-ones) next_combo[dump_index] = 1'b1;  
            end               
            seen0 = ~i[index];
          end 
        end            
    end 
  endfunction 
  wire [ECC_WIDTH-1:0] ht_matrix [CODE_WIDTH-1:0];
  output wire [CODE_WIDTH*ECC_WIDTH-1:0] h_rows;
  localparam COMBOS_3 = combos(ECC_WIDTH, 3);
  localparam COMBOS_5 = combos(ECC_WIDTH, 5);
  genvar n;
  genvar s;
  generate
    for (n=0; n<CODE_WIDTH; n=n+1) begin : ht
      if (n == 0)                
         assign ht_matrix[n] = {{3{1'b1}}, {ECC_WIDTH-3{1'b0}}};
      else if (n == COMBOS_3 && n < DATA_WIDTH)    
         assign ht_matrix[n] = {{5{1'b1}}, {ECC_WIDTH-5{1'b0}}};
      else if ((n == COMBOS_3+COMBOS_5) && n < DATA_WIDTH)    
         assign ht_matrix[n] = {{7{1'b1}}, {ECC_WIDTH-7{1'b0}}};
      else if (n == DATA_WIDTH)   
         assign ht_matrix[n] = {{1{1'b1}}, {ECC_WIDTH-1{1'b0}}};
      else assign ht_matrix[n] = next_combo(ht_matrix[n-1]);
      for (s=0; s<ECC_WIDTH; s=s+1) begin : h_row
        assign h_rows[s*CODE_WIDTH+n] = ht_matrix[n][s];
      end
    end
  endgenerate 
endmodule