module Labx;

reg a, b, c;
wire z;
integer i, j, k;

yMux1 mine(z, a, b, c);

initial 
begin 
	for(i = 0; i < 2; i = 1 + i)
	begin
			for(j = 0; j < 2; j = j + 1)
			begin
					for(k = 0; k < 2; k = k + 1)
					begin
						a = i; b = j; c = k;
						#1;
						$display("a=%b b=%b c=%b z=%b", a, b, c, z);
					end
			end
	end
	$finish;
end

endmodule