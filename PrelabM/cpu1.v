///////////////////////////////////
//			Mux
///////////////////////////////////
//Mux 1-bit
module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
endmodule

//Mux n-bit
module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;
yMux1 master1[SIZE-1:0](z, a, b, c);
endmodule

//4to1 Mux n-bit
module yMux4to1(z, a0, a1, a2, a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] rlo, rhi;
yMux #(SIZE) low(rlo, a0, a1, c[0]);
yMux #(SIZE) high(rhi, a2, a3, c[0]);
yMux #(SIZE) result(z, rlo, rhi, c[1]);
endmodule

///////////////////////////////////
//			Adder
///////////////////////////////////
//Adder 1-bit
module yAdder1(z, cout, a, b, cin);
output z, cout;
input a, b, cin;
xor (p1, a, b);
xor (z, p1, cin);
and (p2, a, b);
and (p3, cin, p1);
or (cout, p3, p2);
endmodule

//Adder 32-bit
module yAdder(z, cout, a, b, cin);
output[31:0] z;
output cout;
input[31:0] a, b;
input cin;
wire[31:0] in, out;
assign in[0] = cin;
assign in[31:1] = out[30:0];
assign cout = out[31];
yAdder1 master2[31:0](z, out, a, b, in);
endmodule


///////////////////////////////////
//			Arith
///////////////////////////////////
//Arith 32-bit
module yArith(z, cout, a, b, ctrl);
output[31:0] z;
output cout;
input[31:0] a, b;
input ctrl;
wire[31:0] in, out, notB, tempB;
not switch[31:0](notB, b);
yMux #(.SIZE(32)) convert(tempB, b, notB, ctrl);
yAdder master3(z, cout, a, tempB, ctrl);
endmodule


///////////////////////////////////
//			Alu
///////////////////////////////////
//Alu 32-bit
/*
op	operation
0	and
1	or
2	plus
6	minus
7	slt
*/
module yAlu(z, ex, a, b, op);
output[31:0] z;
output ex;
input[31:0] a, b;
input[2:0] op;

wire[31:0] result0, result1, result2, result3;

wire[15:0] z16;
wire[7:0] z8;
wire[3:0] z4;
wire[1:0] z2;
wire slt;

wire null;

//a&b
and operation0[31:0](result0, a, b);

//a|b
or	operation1[31:0](result1, a, b);

//a+-b
yArith operation2[31:0](result2, null, a, b, op[2]);

//slt
xor operation3a[31:0](condition, a[31], b[31]);
yMux1 operation3b(result3[0], result2[31], a[31], condition);
assign result3[31:1] = 0;

//ALU
yMux4to1 #(.SIZE(32)) master4(z, result0, result1, result2, result3, op[1:0]);


//Exception
or or16[15:0] (z16, z[15:0], z[31:16]);
or or8[7:0] (z8, z16[7:0], z16[15:8]);
or or4[3:0] (z4, z8[3:0], z8[7:4]);
or or2[1:0] (z2, z4[1:0], z4[3:2]);
or lor (lor, z2[0], z2[1]);
not (ex, lor);

endmodule



///////////////////////////////////
//			MIPS
///////////////////////////////////
module yIF(ins, PCp4, PCin, clk);
output [31:0] ins, PCp4;
input [31:0] PCin;
input clk;
wire [31:0] pcOut;
wire null;
register #(32) pc(pcOut, PCin, clk, 1'b1);
yAlu myAlu(PCp4, null, pcOut, 32'd4, 3'b010);
mem myMem(ins, pcOut, 32'b0, clk, 1'b1, 1'b0);
endmodule

module yID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
output [31:0] rd1, rd2, imm;
output [25:0] jTarget;
input [31:0] ins, wd;
input RegDst, RegWrite, clk;
wire [4:0] rn1, rn2, wn;
assign rn1 = ins[25:21];		//rs
assign rn2 = ins[20:16];		//rt
//assign rn3 = ins[15:11];		//rd
assign jTarget = ins[25:0];
assign imm[15:0] = ins[15:0];	//signed number
yMux #(5) master(wn, rn2, ins[15:11], RegDst);
yMux #(16) se(imm[31:16], 16'h0000, 16'hffff, ins[15]);//c
rf myRF(rd1, rd2, rn1, rn2, wn, wd, clk, RegWrite);
endmodule

module yEX(z, zero, rd1, rd2, imm, op, ALUSrc);
output [31:0] z;
output zero;
input [31:0] rd1, rd2, imm;
input [2:0] op;
input ALUSrc; 
wire [31:0] b;
yMux #(32) master(b, rd2, imm, ALUSrc);
yAlu main(z, zero, rd1, b, op);
endmodule

module yDM(memOut, exeOut, rd2, clk, MemRead, MemWrite);
output [31:0] memOut;
input [31:0] exeOut, rd2;
input clk, MemRead, MemWrite;
mem masterDM(memOut, exeOut, rd2, clk, MemRead, MemWrite);
endmodule 

module yWB(wb, exeOut, memOut, Mem2Reg);
output [31:0] wb;
input [31:0] exeOut, memOut;
input Mem2Reg;
yMux #(32) masterWB(wb, exeOut, memOut, Mem2Reg);
endmodule 



