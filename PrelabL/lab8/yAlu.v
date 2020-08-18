module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
wire[31:0] And, Or, Sum, slt;
assign slt = 0; // not supported
	
assign ex = 0; // not supported
	
yArith arith(Sum, ex, a, b, op[2]);
and myAnd[31:0](And, a, b);
or myOr[31:0](Or, a, b);
yMux4to1 #(32) mux(z, And, Or,Sum, slt, op[1:0]);

endmodule