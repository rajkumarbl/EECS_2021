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


///////////////////////////////////
//			CPU
///////////////////////////////////
module yPC(PCin, PCp4, INT, entryPoint, imm, jTarget, zero, branch, jump);
output [31:0] PCin;
input [31:0] PCp4, entryPoint, imm;
input [25:0] jTarget;
input INT, zero, branch, jump;
wire [31:0] immX4, bTarget, jTargetX4, choiceA, choiceB;
wire doBranch, zf;
assign immX4[31:2] = imm[29:0];
assign immX4[1:0] = 2'b00; 							//immX4 is the real address (imm * 4)
yAlu beqmaster(bTarget, zf, PCp4, immX4, 3'b010);	//bTarget = PCp4 + imm * 4
and (doBranch, branch, zero); 						//doBranch
yMux #(32) mux1(choiceA, PCp4, bTarget, doBranch);	//if jump branch or execute the next
assign jTargetX4[31:28] = PCp4[31:28];
assign jTargetX4[27:2] = jTarget[25:0];
assign jTargetX4[1:0] = 2'b00;
yMux #(32) mux2(choiceB, choiceA, jTargetX4, jump);	// if not jump then use choiceA
yMux #(32) mux3(PCin, choiceB, entryPoint, INT);	// choose between previous and entryPoint
endmodule

module yC1(rtype, lw, sw, jump, branch, opCode);
output rtype, lw, sw, jump, branch;
input [5:0] opCode;
wire not5, not4, not3, not2, not1, not0;
not (not5, opCode[5]);
not (not4, opCode[4]);
not (not3, opCode[3]);
not (not2, opCode[2]);
not (not1, opCode[1]);
not (not0, opCode[0]);
and (lw, opCode[5], not4, not3, not2, opCode[1], opCode[0]);
and (sw, opCode[5], not4, opCode[3], not2, opCode[1], opCode[0]);
and (jump, not5, not4, not3, not2, opCode[1], not0);
and (branch, not5, not4, not3, opCode[2], not1, not0);
and (rtype, not5, not4, not3, not2, not1, not0);
endmodule

module yC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, jump, branch);
output RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite;
input rtype, lw, sw, jump, branch;
assign RegDst = rtype;			//use [rd] field
nor (ALUSrc, rtype, branch);	//0 - do calculation; 1 - add immediate
nor (RegWrite, sw, branch, jump);		//need to write to a register
assign Mem2Reg = lw;
assign MemRead = lw;
assign MemWrite = sw;
endmodule

module yC3(ALUop, rtype, branch);
output [1:0] ALUop;
input rtype, branch;
assign ALUop[0] = branch;
assign ALUop[1] = rtype;
endmodule

module yC4(op, ALUop, fnCode);
output [2:0] op;
input [5:0] fnCode;
input [1:0] ALUop;
wire t1, t2;
or (t1, fnCode[0], fnCode[3]);
and (t2, fnCode[1], ALUop[1]);
and (op[0], ALUop[1], t1);
nand (op[1], ALUop[1], fnCode[2]);
or (op[2], t2, ALUop[0]);
endmodule

module yChip(ins, rd2, wb, entryPoint, INT, clk);
output [31:0] ins, rd2, wb;
input [31:0] entryPoint;
input INT, clk;

wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb, PCin;
wire [25:0] jTarget;
wire [5:0] opCode, fnCode;
wire [2:0] op;
wire [1:0] ALUop;
wire zero, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, jump, branch, rtype, lw, sw;

//Get pointer
yIF myIF(ins, PCp4, PCin, clk);

//Get instruction  
//{
//	RegDst: write to a location, 0-IJ, 1-R; 
//	RegWrite: 0-disable register, 1-will be able to store date in register
//}
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);

//Execute instruction
//{
//	ALUSrc:	0-not imm, 1-imm;
//	op:		do the calculation
//}
yEX myEX(z, zero, rd1, rd2, imm, op, ALUSrc);

//Data Memory
//{MemRead, MemWrite}
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);

//Write Back: from Memory to Register
//{Mem2Reg}
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;

//Auto Control Module
yPC myPC(PCin, PCp4, INT, entryPoint, imm, jTarget, zero, branch, jump);

assign opCode = ins[31:26];
yC1 myC1(rtype, lw, sw, jump, branch, opCode);
yC2 myC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, jump, branch);

assign fnCode = ins[5:0];
yC3 myC3(ALUop, rtype, branch);
yC4 myC4(op, ALUop, fnCode);

endmodule



































