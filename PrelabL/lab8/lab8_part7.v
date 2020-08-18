module Labx;

	reg signed [31:0] expect, a, b;
	reg ok, cin;
	wire signed [31:0] z;
	wire cout;
	
	yAdder my_add(z, cout, a, b, cin);
	
	initial
		begin 
				repeat(10)
					begin
							a = $random;
							b = $random;
							cin = 0;
							
							#1;
							expect = a + b + cin;
							ok = 0;
							if( z === expect) ok = 1;
							$display("ok=%b z=%d expect=%d", ok, z, expect);
						end
						$finish;
end

endmodule