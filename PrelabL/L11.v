module labL;
reg signed [31:0] a, b;
reg [2:0] op;
reg flag;
wire ex;
wire  signed [31:0] z;
integer expect;
yAlu32 fun(z, ex, a, b, op);
initial
begin
//Alu 32-bit
/*
op	operation
0	and
1	or
2	plus
6	minus
7	slt
*/
	flag = $value$plusargs("op=%d", op);
	$display("OPC = %b", op);
	repeat(20)
	begin
		a = $random;
		b = $random;
		#1;
		if (op === 0)
		begin
			expect = a & b;
		end
		
		if (op === 1)
		begin
			expect = a | b;
		end
		
		
		if (op === 2)
		begin
			expect = a + b;
		end
		
		if (op === 6)
		begin
			expect = a - b;
		end
		
		if (op === 7)
		begin
			if (a < b) 
			begin
				expect = 1;
			end
			else
			begin
				expect = 0;
			end
		end
		if (expect == z)
		begin
			$display("Success => a=%b %d b=%b %d z=%b %d  ex=>%b expect=>%b %d", a, a, b, b, z, z, ex, expect, expect);
		end
		else
		begin
			$display("Failed  => a=%b %d b=%b %d z=%b %d  ex=>%b expect=>%b %d", a, a, b, b, z, z, ex, expect, expect);
		end

	end	
	$finish;
end
endmodule

