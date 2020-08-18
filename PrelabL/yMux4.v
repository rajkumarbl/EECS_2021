module yMux4(z, a0,a1,a2,a3, c); 

parameter SIZE = 2; 
output [SIZE-1:0] z; 
input [SIZE-1:0] a0, a1, a2, a3; 
input [1:0] c; 
wire [SIZE-1:0] zLo, zHi;
 
yMux3 #(SIZE) lo(zLo, a0, a1, c[0]); 
yMux3 #(SIZE) hi(zHi, a2, a3, c[0]); 
yMux3 #(SIZE) final(z, zLo, zHi, c[1]); 

endmodule 
