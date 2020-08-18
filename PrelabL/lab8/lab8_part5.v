module Labx;

	integer i, j, k;
	reg a, b, cin;
	reg [1:0] expect;
	wire z, cout;
	
	
	yAdder1 mine5(z, count, a, b, cin);
	
	initial
		begin 
			for(i = 0; i < 2; i = i + 1)
			begin
					for(j = 0; j < 2; j = j + 1)
					begin
						for(k = 0; k < 2; k = k + 1)
						begin
							a = i; b = j; cin = k;
							#1;
							expect = a + b + cin;
							if(cout !== expect[1])
								$display("Fail count=$b, expect=%b", cout, expect);
								if(z !== expect[0])
									$display("Fail count=$b, expect=%b", z, expect);
							$display("a=%b, b=%b, cin=%b, expect=%b", a, b, cin, expect);
						end
					end
			end
			$finish;
end

endmodule