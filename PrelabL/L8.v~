module labL;

//integer signed expect;
reg signed [31:0] expect;
reg signed [31:0] a, b;// signed
reg cin;

output signed [31:0] z;
output cout;

integer seed;

yArith funny(z, cout, a, b, cin);

initial
begin

	repeat(20)
	begin
		a = $random(seed) % 100;
		b = $random(seed) % 100;
		cin = $random(seed) % 2;

		#1;
		if (cin === 1)
		begin
			expect = a - b;	
			$write("MINUS =>");
		end
		else
		begin
			expect = a + b;
			$write("PLUS  =>");
		end

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

