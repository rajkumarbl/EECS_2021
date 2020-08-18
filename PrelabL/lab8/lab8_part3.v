module Labx;
	
reg [31:0] a, b, expect;
reg c;
wire [31:0] z;
integer i, j, k;

yMux #(.SIZE(32)) mine3(z, a, b, c);

initial
begin
		repeat(10)
			begin
					a = $random;
					b = $random;
					c = $random % 2;
					#1;
					expect = c ? b : a;
					if(expect == z)
							$display("PASS a=%b b=%b c=%b z=%b", a, b, c, z);
					else
							$display("FAIL a=%b b=%b c=%b z=%b", a, b, c, z, expect);
						
		end
		$finish;
end

endmodule
					