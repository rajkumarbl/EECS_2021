module labL;


reg[1:0] a, b, expect;
reg c;
integer i,j,k;

wire [1:0] z;

yMux2 usagi(z, a, b, c);

initial
begin
	for (i = 0; i < 4; i ++)
	begin
		for (j = 0; j < 4; j ++)
		begin
			for (k = 0; k < 2; k ++)
			begin
				a = i[1:0];
				b = j[1:0];
				c = k;
				expect[0] = (a[0] & (~ c)) | (c & b[0]);
				expect[1] = (a[1] & (~ c)) | (c & b[1]);
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

