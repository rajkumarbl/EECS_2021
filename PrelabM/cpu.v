module yMux1(z, a, b, c); 
output z; 
input a, b, c; 
wire notC, upper, lower; 
not my_not(notC, c); 
and upperAnd(upper, a, notC); 
and lowerAnd(lower, c, b); 
or my_or(z, upper, lower); 
endmodule 
module yMux(z, a, b, c); 
parameter SIZE = 2; 
output [SIZE-1:0] z; 
input [SIZE-1:0] a, b; 
input c; 
yMux1 mine[SIZE-1:0](z, a, b, c); 
endmodule 
module yMux4to1(z, a0,a1,a2,a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] zLo, zHi;

yMux #(SIZE) lo(zLo, a0 , a1, c[0]);
yMux #(SIZE) hi(zHi, a2 , a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);

endmodule
module yAdder1(z, cout, a, b, cin); 
output z, cout; 
input a, b, cin; 
xor left_xor(tmp, a, b); 
xor right_xor(z, cin, tmp); 
and left_and(outL, a, b); 
and right_and(outR, tmp, cin); 
or my_or(cout, outR, outL); 
endmodule 
module yAdder(z, cout, a, b, cin); 
output [31:0] z; 
output cout; 
input [31:0] a, b; 
input cin; 
wire[31:0] in, out; 

yAdder1 mine[31:0](z, out, a, b, in); 
assign in[0] = cin; 
assign in[31:1] = out[30:0];
assign cout = out[31]; 
endmodule
module yArith(z, cout, a, b, ctrl);

output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire [31:0] notB, tmp;
wire cin;

not not_b[31:0](notB,b);
yMux #(32) my_ctrl(tmp,b,notB,ctrl); 
yAdder adder(z,cout,a,tmp,ctrl);


//yAdder mine(z, out, a, notB, cin);
//assign cin = ctrl ? 1 : 0;
//assign notB = ctrl ? ~b : b;

endmodule
module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
wire [31:0] arith_z, and_z, or_z, slt_z;
wire [15:0] or16;
wire [7:0] or8;
wire [3:0] or4;
wire [1:0] or2;
wire cout;

//assign slt_z[31:1] = 0;
assign slt_z = (a[31] ^ b[31]) ? a[31] : arith_z[31];
and my_and[31:0] (and_z, a, b);
or my_or[31:0] (or_z, a, b);
//not my_nor[31:0] (nor_z, or_z, 32'b11111111111111111111111111111111);

or or_16[15:0]	(or16,	z[31:16],	z[15:0]);
or or_8[7:0]	(or8,	or16[15:8],	or16[7:0]);
or or_4[3:0]	(or4,	or8[7:4],	or8[3:0]);
or or_2[1:0]	(or2,	or4[3:2],	or4[1:0]);
nor nor_1		(ex,	or2[1],		or2[0]);

//assign ex = ~(|z);

yArith my_arith(arith_z, cout, a, b, op[2]);
yMux4to1 #(32) my_mux(z, and_z, or_z, arith_z, slt_z, op[1:0]);

endmodule

module yIF(ins, PCp4, PCin, clk); 
output [31:0] ins, PCp4; 
input [31:0] PCin; 
input clk; 
wire [31:0] z;
assign memIn= 32'b0;

register #(32) mine(z, PCin, clk, 1'b1);
mem data(ins, z, memIn, clk, 1'b1, 1'b0);
yAlu my_Alu(PCp4, ex, 4, z, 3'b010);

endmodule 




module yID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk); 
output [31:0] rd1, rd2, imm; 
output [25:0] jTarget; 
input [31:0] ins, wd; 
input RegDst, RegWrite, clk; 

wire [4:0] wn;
reg [15:0] zeros, ones;
assign zeros = 16'b0;
assign ones = 16'b1;

assign rn1 = ins[25:21];
assign rn2 = ins[20:16];

yMux1 my_mux(wn, rn2, ins[15:11], RegDst); 
rf myRF(rd1, rd2, rn1, rn2, wn, wd, clk, RegWrite); 

assign imm[15:0] = ins[15:0]; 
yMux #(16) se(imm[31:16], zeros, ones, ins[15]); 

endmodule

module yEX(z, zero, rd1, rd2, imm, op, ALUSrc); 
output [31:0] z; 
output zero; 
input [31:0] rd1, rd2, imm; 
input [2:0] op; 
input ALUSrc; 
wire [31:0]b , a;
wire ex;
yMux #(32) mux_two(b ,  rd2, imm, ALUSrc);
yAlu  myAlu(z, zero,rd1, b, op);
endmodule


