module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;

// Gates and interconnections for MUX
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
endmodule 