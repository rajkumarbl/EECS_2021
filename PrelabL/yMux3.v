
module yMux3(z, a, b, c);
parameter SIZE = 2;//similar to constant
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;

yMux1 funny0[SIZE-1:0](z, a, b, c);
//return [1:0] z a b ,whereas(Ran2E2) as declared as a single bit but replicated

endmodule
