//----------------------------------------ALU-----------------------------------
module yAlu(z, ex, a, b, op); 
input [31:0] a, b; 
input [2:0] op; 
output [31:0] z; 
output ex; 
wire [31:0] andi, ori, arith, sub, slt;
wire condition;
wire [15:0] z16;
wire [7:0]  z8;
wire [3:0]  z4;
wire [1:0]  z2;
wire z1;
assign slt[31:1] = 0;  
// not supported 
// instantiate the components and connect them 
// Hint: about 4 lines of code 

//and--------------------------------
and myAnd[31:0](andi, a, b);
//or---------------------------------
or  myOr[31:0](ori, a, b);
//(+-)------------------------------
yArith myArith(arith,null, a, b, op[2]);

//slt------------------------------
xor myXor (condition, a[31], b[31]);
yArith sltArith(sub,null, a, b, 1'b1);
yMux1  sltMux (slt[0], sub[31], a[31], condition);
//---------------------------------
//chosing result
yMux4to1 #(32) myMux (z, andi, ori, arith, slt, op[1:0]);

//Ex-------------------------------
or or16[15:0] (z16, z[15:0], z[31:16]); 
or or8[7:0]  (z8, z16[7:0], z16[15:8]); 
or or4[3:0] (z4, z8[3:0], z8[7:4]); 
or or2[1:0]  (z2, z4[1:0], z4[3:2]); 
or or1 (z1, z2[0:0], z2[1:1]);
not noting(ex, z1);
endmodule

//--------------------------------------------------------------------------------------
//---------------------------------------- MUX1  ---------------------------------------
module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
endmodule 

//---------------------------------------------------------------------------------------
//--------------------------------------- MUX  ------------------------------------------
module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;
yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule 

//---------------------------------------------------------------------------------------
//--------------------------------------MUX4to1------------------------------------------
module yMux4to1(z,a0,a1,a2,a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] zLo, zHi;
yMux #(SIZE) lo(zLo, a0, a1, c[0]);
yMux #(SIZE) hi(zHi, a2, a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);
endmodule 

//---------------------------------------------------------------------------------------
//-------------------------------------Adder1--------------------------------------------
module yAdder1(z, cout, a, b, cin); 
output z, cout; 
input a, b, cin; 
xor left_xor(tmp, a, b); 
xor right_xor(z, cin, tmp); 
and left_and(outL, a, b); 
and right_and(outR, tmp, cin); 
or my_or(cout, outR, outL); 
endmodule 

//---------------------------------------------------------------------------------------
//----------------------------------- Adder----------------------------------------------
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

//--------------------------------------------------------------------------------------------
//--------------------------------------Arith ------------------------------------------------
module yArith(z, cout, a, b, ctrl); 

//add if ctrl=0, subtract if ctrl=1
output [31:0] z; 
output cout; 
input [31:0] a, b; 
input ctrl; 
wire[31:0] notB, tmp; 
wire cin; 

assign cin = ctrl;
not myNot[31:0](notB, b);
yMux #(32) mymux(tmp, b, notB, cin);
yAdder myadder(z,cout, a ,tmp , cin);

endmodule 
//--------------------------------------------------------------------------------------------

module yAlu32(z, ex, a, b, op);
output[31:0] z;
output ex;
input[31:0] a, b;
input[2:0] op;

wire[31:0] result0, result1, result23, f1, f2, slt, minus;
wire[15:0] z16;
wire[7:0] z8;
wire[3:0] z4;
wire[1:0] z2;
wire lor;
wire adderCOut;
wire ctrlArith;
wire condition;
wire resultSlt;
/*
0	000	a&b
1	001	a|b
2	010	a+b
3	110	a-b
4	111	slt (set a less than b)
*/

//a&b
and op0[31:0](result0, a, b);

//a|b
or	op1[31:0](result1, a, b);

//a +- b
yArith op23[31:0](result23, adderCOuer, a, b, ctrlArith);

//slt
xor op4a(condition, a[31], b[31]);
yArith op4b(minus, null, a, b, 1'b1);
yMux3 #(.SIZE(1)) op4i(resultSlt, minus[31], a[31], condition);

//ALU
yMux3 #(.SIZE(32)) fi1(f1, result0, result1, op[0]);
yMux3 #(.SIZE(32)) fi2(f2, f1, result23, op[1]);
yMux3 #(.SIZE(32)) fi3(z, f2, slt, op[0]);

//Exception
or or16[15:0] (z16, z[15:0], z[31:16]);
or or8[7:0] (z8, z16[7:0], z16[15:8]);
or or4[3:0] (z4, z8[3:0], z8[7:4]);
or or2[1:0] (z2, z4[1:0], z4[3:2]);
or lor (lor, z2[0], z2[1]);
not (ex, lor);

//Connections
assign ctrlArith = op[2];
assign slt[31:1] = 0;
assign slt[0] = resultSlt;

endmodule

