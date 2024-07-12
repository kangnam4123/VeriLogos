module atomic_alu
(
   readdata,
   atomic_op,
   operand0,
   operand1,
   atomic_out
);
parameter ATOMIC_OP_WIDTH=3; 
parameter OPERATION_WIDTH=32; 
parameter USED_ATOMIC_OPERATIONS=8'b00000001;
localparam a_ADD=0;
localparam a_XCHG=1;
localparam a_CMPXCHG=2;
localparam a_MIN=3;
localparam a_MAX=4;
localparam a_AND=5;
localparam a_OR=6;
localparam a_XOR=7;
input logic [OPERATION_WIDTH-1:0] readdata;
input logic [ATOMIC_OP_WIDTH-1:0] atomic_op;
input logic [OPERATION_WIDTH-1:0] operand0;
input logic [OPERATION_WIDTH-1:0] operand1;
output logic [OPERATION_WIDTH-1:0] atomic_out;
wire [31:0] atomic_out_add ;
wire [31:0] atomic_out_cmp ;
wire [31:0] atomic_out_cmpxchg ;
wire [31:0] atomic_out_min ;
wire [31:0] atomic_out_max ;
wire [31:0] atomic_out_and ;
wire [31:0] atomic_out_or ;
wire [31:0] atomic_out_xor ;
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_ADD) ) != 0 ) assign atomic_out_add = readdata + operand0;
else assign atomic_out_add = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_XCHG) ) != 0 ) assign atomic_out_cmp = operand0;
else assign atomic_out_cmp = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_CMPXCHG) ) != 0 ) assign atomic_out_cmpxchg = ( readdata == operand0 ) ? operand1 : readdata;
else assign atomic_out_cmpxchg = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_MIN) ) != 0 ) assign atomic_out_min = ( readdata < operand0 ) ? readdata : operand0;
else assign atomic_out_min = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_MAX) ) != 0 ) assign atomic_out_max = (readdata > operand0) ? readdata : operand0;
else assign atomic_out_max = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_AND) ) != 0 ) assign atomic_out_and = ( readdata & operand0 );
else assign atomic_out_and = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_OR) ) != 0 ) assign atomic_out_or = ( readdata | operand0 );
else assign atomic_out_or = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
generate
if( ( USED_ATOMIC_OPERATIONS & (1 << a_XOR) ) != 0 ) assign atomic_out_xor = ( readdata ^ operand0 );
else assign atomic_out_xor = {ATOMIC_OP_WIDTH{1'bx}};
endgenerate
always @(*)
begin
  case ( atomic_op )
  a_ADD:
  begin
    atomic_out = atomic_out_add;
  end
  a_XCHG:
  begin
    atomic_out = atomic_out_cmp;
  end
  a_CMPXCHG:
  begin
    atomic_out = atomic_out_cmpxchg;
  end
  a_MIN:
  begin
    atomic_out = atomic_out_min;
  end
  a_MAX:
  begin
    atomic_out = atomic_out_max;
  end
  a_AND:
  begin
    atomic_out = atomic_out_and;
  end
  a_OR:
  begin
    atomic_out = atomic_out_or;
  end
  default:
  begin
    atomic_out = atomic_out_xor;
  end
  endcase
end
endmodule