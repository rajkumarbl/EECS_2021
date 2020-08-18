module labL;


reg[31:0] a0, a1, a2, a3, expect;
reg[1:0] c;
integer i,j,k;

wire [31:0] z;

yMux4 #(32) usagi(z, a0, a1, a2, a3, c);

initial
begin
	repeat(10)
	begin
		a0 = $random;
		a1 = $random;
		a2 = $random;
		a3 = $random;

		c = $random % 4;
		expect = (c[1] === 0)? (c[0] === 0? a0: a1) : (c[0] === 0? a2: a3);
		
		#1
		if (expect === z)
		begin
			$display("PASS: a0=%d a1=%d a2=%d a3=%d c=%b z=%d", a0, a1, a2, a3, c, z);
		end
		else
		begin
			$display("FAIL: a0=%d a1=%d a2=%d a3=%d c=%b z=%d", a0, a1, a2, a3, c, z);
		end
	end
	$finish;
end
endmodule

