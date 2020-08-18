module labM;
reg [31:0] d;
reg clk, enable, flag;
wire [31:0] z;

register #(32) master(z, d, clk, enable);

initial
begin
	flag = $value$plusargs("enable=%b", enable); 
	clk = 0;
	repeat (20)
	begin
		#2;
		d = $random;
	end
	$finish; 
end

always
begin
        $monitor("%5d => enable=%b, clk=%b, d=%d, z=%d", $time, enable, clk, d, z);
	#5;
	clk = ~ clk;
end


endmodule

