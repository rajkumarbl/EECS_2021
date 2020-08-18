module labL;

integer expect;

reg[31:0] a, b;
reg cin;

output[31:0] z;
output cout;

yadder6 funny(z, cout, a, b, cin);

initial
begin
		
	repeat(20)
	begin
		a = $random;
		b = $random;
		cin = 0;
		expect = a + b;
		#1;
		if (expect === z)
		begin
			$display("PASS: a=%d b=%d c=%b z=%d", a, b, cout, z);
		end
		else
		begin
			$display("FAIL: a=%d b=%d c=%b z=%d", a, b, cout, z);
		end	
	end	
	$finish;

end
endmodule
