module Lab4;
reg [31:0] expect, a0, a1, a2, a3;
reg [1:0] c;
wire [31:0] z;

yMux4to1 #(32) mine4(z, a0, a1, a2, a3, c);

initial
begin
		repeat(10)
			begin
					a0 = $random;
					a1 = $random;
					a2 = $random;
					a3 = $random;
					c = $random %4;
				#1;
					case(c)
						0: expect = a0;
						1: expect = a1;
						2: expect = a2;
						3: expect = a3;
					endcase
					
					if(expect == z)
						$display("Pass: a0=%d a1=%d a2=%d a3=%d c=%d z=%d", a0, a1, a2, a3, c, z);
					else
						$display("FAIL: a0=%d a1=%d a2=%d a3=%d c=%d z=%d", a0, a1, a2, a3, c, z);
		end
		$finish;
end
endmodule