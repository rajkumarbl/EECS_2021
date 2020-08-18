module labK;
reg a, b, c, flag;
wire z, cn, and1, and2;
integer i, j;

not my_not(cn, c);
assign cnot = cn;
and my_and(and1, a, cnot);
assign o1 = and1;
and my_and2(and2, b, c);
assign o2 = and2;
or (z, o1, o2);

initial
begin
        flag = $value$plusargs("a=%b", a);
	flag = $value$plusargs("b=%b", b);
	flag = $value$plusargs("c=%b", c);
	#1 $display("a=%b b=%b c=%b z=%b", a, b, c, z);
        $finish;
end

endmodule
