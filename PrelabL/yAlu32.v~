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

