module labL;

//integer signed expect;
reg signed [31:0] expect, a, b;
reg [2:0] op;
reg flag;

wire ex;

output  signed [31:0] z;
//output cout;

yAlu32 fun(z, ex, a, b, op);

initial
begin
		
	flag = $value$plusargs("op=%d", op);
	$display("OPC = %b", op);

	repeat(20)
	begin
		a = $random;
		b = $random;

		#1;
		$display("RESULT: a=%b %d b=%b %d =>  z=%b %d  ex=>%b", a,a, b,b, z,z, ex);
	end	
	$finish;

end
endmodule

