module labK;
reg a, b, c;
reg[1:0] expect;
wire z,cout, ox1, ox2, oy1, oy2;
integer i, j, k;

xor (ox1, a, b);
assign outx1 = ox1;

and (ox2, a, b);
assign outx2 = ox2;

xor (z, c, outx1);

and (oy2, c, outx1);
assign outy2 = oy2;

or (cout, outx2, outy2);

initial
begin
        for (i = 0; i < 2; i = i + 1)
        begin
            for (j = 0; j < 2; j = j + 1)
            begin
                for(k = 0; k < 2; k = k + 1)
		begin
			a = i; b = j; c = k;
                        expect[0] = (a ^ b) ^ c; //z
			expect[1] = ((a & b) | (c & (a ^ b))); //cout
			#1; // wait for z and cout
                        if (expect[0] === z && expect[1] === cout)
			$display("PASS: a=%b b=%b c=%b z=%b cout=%b", a, b, c, z, cout);
			else
 			$display("FAIL: a=%b b=%b c=%b z=%b cout=%b", a, b, c, z, cout);
                end
            end
        end
        $finish;
end

endmodule
