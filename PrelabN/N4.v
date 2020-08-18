module labM;

reg [31:0] entryPoint;
reg clk, INT;

wire [31:0] ins, rd2, wb;

yChip myChip(ins, rd2, wb, entryPoint, INT, clk);

initial
begin
	entryPoint = 32'h80;
	INT = 1'b1;
	#1;
	repeat(43)
	begin
		//Fetch an instruction
		clk = 1'b1;

		//Set Control Signals
		#1;
		INT = 1'b0;
		clk = 1'b0;

		//View Results
		#1;
		$display("%h: rd2=%2d wb=%2d", ins, rd2, wb);

	end
	$finish; 
end
endmodule













