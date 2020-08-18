module labx;

reg [31:0] a, b;
reg [31:0] expect;
reg [2:0] op;
wire ex;
wire [31:0] z;
reg ok, flag;

yAlu mine(z, ex, a, b, op);

initial
begin
	repeat(10)
	begin
		
		a = $random;
		b = $random;
		flag = $value$plusargs("op=%d", op);
		case(op)
			0: expect = a & b;
			1: expect = a | b;
			2: expect = a + b;
			6: expect = a - b;
			7: expect = 0;
		endcase

		#1;
		ok = expect === z ? 1 : 0;
		$display("ok=%b", ok);

	end
	$finish;
end
endmodule