module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;

not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);

endmodule

module yMux(z, a, b, c);
parameter SIZE = 32;
output [SIZE - 1:0] z;
input [SIZE - 1:0] a, b;
input c;

yMux1 mine[SIZE - 1:0](z, a, b, c);

endmodule

module yAdder1(z, cout, a, b, cin);
output z, cout;
input a, b, cin;

xor left_xor(tmp, a, b);
xor right_xor(z, cin, tmp);
and left_and(outL, a, b);
and right_and(outR, tmp, cin);
or my_or(cout, outR, outL);

endmodule

module yAdder(z, cout, a, b, cin);
output signed[31:0] z;
output cout;
input signed [31:0] a, b;
input cin;
wire [31:0] in, out;

yAdder1 mine[31:0](z, out, a, b, in);

assign in[0] = cin;
assign in[1] = out[0];

assign in[31:2] = out[30:1];

endmodule

module yArith(z, cout, a, b, ctrl);
// add if ctrl = 0, subtract if ctrl = 1
output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire [31:0] notB, tmp, tmp2;
wire cin;

// instantiate the components and connect them
// Hint: about 4 lines of code
not my_not[31:0](notB, b);

yAdder add(tmp, cout, a, b, ctrl);
yAdder sub(tmp2, cout, a, notB, ctrl);

yMux #(32) mine(z, tmp, tmp2, ctrl);

endmodule

module Lab8_part8;
reg signed [31:0] a, b;
reg c;
wire signed [31:0] z;
wire cout;
reg signed [31:0] expect;
integer i, j, k;
	
yArith my_Arith(z, cout, a, b, c);
	
initial
begin
	//a = $random;
	//b = $random;	
	a = $random;
	b = $random;
	c = $random % 2;
	expect = (c) ? a - b : a + b;
	#1;
	if (expect == z)
		// pass
		$display("PASS: a=%d b=%d c=%d z=%d expect=%d", a, b, c, z, expect);
	else
		// fail
		$display("FAIL: a=%d b=%d c=%d z=%d expect=%d", a, b, c, z, expect);

end
endmodule