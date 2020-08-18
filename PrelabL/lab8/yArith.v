module yArith(z, cout, a, b, ctrl);
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


endmodule