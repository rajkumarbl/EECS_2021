module labL;

integer i, j, k, expect;
reg a, b, c;

yMux1 funny(z, a, b, c);

initial
begin
	for (i = 0; i < 2; i ++)
	begin
		for (j = 0; j < 2; j ++)
		begin
			for (k = 0; k < 2; k ++)
			begin
				a = i;
				b = j;
				c = k;
				expect = (a & (~ c)) | (c & b);
				#1	
				if (expect === z)
				begin
					$display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);				
				end
				else
				begin
					$display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
				end
			end
		end
	end
	$finish;

end
endmodule
