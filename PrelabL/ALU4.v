module yAlu32(z, ex, a, b, op);
output[3:0] z;
output ex;
input[3:0] a, b;
input[3:0] op;

wire [31:0] andi, ori, arith, sub, slt;
wire condition;
wire [15:0] z16;
wire [7:0]  z8;
wire [3:0]  z4;
wire [1:0]  z2;
wire z1;
 
// not supported 
// instantiate the components and connect them 
// Hint: about 4 lines of code 

//and-----------------------------------------
and myAnd[3:0](andi, a, b);
//or------------------------------------------
or  myOr[3:0](ori, a, b);
//(+-)----------------------------------------
yArith myArith(arith,null, a, b, op[2]);

//chosing result
yMux4to1 #(32) myMux (z, andi, ori, arith, slt, op[1:0]);

//Ex--------------------------------------------
or or16[15:0] (z16, z[15:0], z[31:16]); 
or or8[7:0]  (z8, z16[7:0], z16[15:8]); 
or or4[3:0] (z4, z8[3:0], z8[7:4]); 
or or2[1:0]  (z2, z4[1:0], z4[3:2]); 
or or1 (z1, z2[0:0], z2[1:1]);
not noting(ex, z1);
endmodule

module yArith(z, cout, a, b, ctrl); 

//add if ctrl=0, subtract if ctrl=1
output [3:0] z; 
output cout; 
input [3:0] a, b; 
input ctrl; 
wire[3:0] notB, tmp; 
wire cin; 

assign cin = ctrl;
not myNot[31:0](notB, b);
yMux #(32) mymux(tmp, b, notB, cin);
yAdder myadder(z,cout, a ,tmp , cin);

endmodule 

module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;
yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule 

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




