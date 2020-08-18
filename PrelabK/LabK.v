module fulladder(A, B, Cin);
input[1:0] A, B, Cin;
wire Z, Cout, ox1, ox2, oy1, oy2;

xor (ox1, A, B);
assign outx1 = ox1;

and (ox2, A, B);
assign outx2 = ox2;

xor (Z, c, outx1);

and (oy2, Cin, outx1);
assign outy2 = oy2;

or (Cout, outx2, outy2);
endmodule
