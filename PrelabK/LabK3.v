module labK;
reg  a, b; // reg without size means 1-bit
wire notOutput, lowerInput, tmp, z;

not my_not(notOutput, b);
and my_and(z, a, lowerInput);
assign lowerInput = notOutput;

initial
begin
	a = 1;
	b = 1;
	#1 $display("a=%d b=%d z=%d", a, b, z);
	$finish;
end

endmodule
