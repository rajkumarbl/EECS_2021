module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;

// Gates and interconnections for MUX
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
endmodule module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;

yMux1 mine[SIZE-1:0](z, a, b, c);
//yMux1 mine[1:0](z, a, b, c);
endmodulemodule yMux4to1(z, a0,a1,a2,a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;

wire [SIZE-1:0] zLo, zHi;
yMux #(SIZE) lo(zLo, a0, a1, c[0]);
yMux #(SIZE) hi(zHi, a2, a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);
endmodule module yAdder1(z, cout, a, b, cin);
output z, cout;
input a, b, cin;
xor left_xor(tmp, a, b);
xor right_xor(z, cin, tmp);
and left_and(outL, a, b);
and right_and(outR, tmp, cin);
or my_or(cout, outR, outL);
endmodule module yAdder(z, cout, a, b, cin);
output [31:0] z;
output cout;
input [31:0] a, b;
input cin;
wire[31:0] in, out;
yAdder1 mine[31:0](z, out, a, b, in);
assign in[0] = cin;
assign in[31:1] = out[30:0];
assign cout = out[31];

endmodulemodule yArith(z, cout, a, b, ctrl);
// add if ctrl=0, subtract if ctrl=1
output [31:0] z;

output cout;
input [31:0] a, b;
input ctrl;
wire[31:0] notB, tmp;
wire cin;

not notofB[31:0](notB, b);
yMux #(32) mux(tmp, b, notB, ctrl);
yAdder add(z, cout, a, tmp, ctrl);


endmodulemodule yAlu(z, ex, a, b, op);
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